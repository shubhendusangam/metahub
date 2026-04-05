package com.metahub.service;

import com.metahub.dto.response.DataQualityScoreResponse;
import com.metahub.model.DataQualityScore;
import com.metahub.model.Dataset;
import com.metahub.repository.DataQualityScoreRepository;
import com.metahub.repository.DatasetRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.Duration;
import java.time.Instant;
import java.util.List;
import java.util.Optional;
import java.util.UUID;
import java.util.stream.Collectors;

@Slf4j
@Service
@RequiredArgsConstructor
public class DataQualityService {

    private final DataQualityScoreRepository qualityRepository;
    private final DatasetRepository datasetRepository;

    @Transactional(readOnly = true)
    public List<DataQualityScoreResponse> getAllScores() {
        return qualityRepository.findAllByOrderByOverallScoreDesc().stream()
                .map(this::toResponse)
                .collect(Collectors.toList());
    }

    @Transactional(readOnly = true)
    public Optional<DataQualityScoreResponse> getScoreForDataset(UUID datasetId) {
        return qualityRepository.findByDatasetId(datasetId).map(this::toResponse);
    }

    @Scheduled(cron = "${metahub.quality.cron:0 0 */6 * * *}")
    @Transactional
    public void computeAllScores() {
        log.info("Computing data quality scores for all datasets...");
        List<Dataset> datasets = datasetRepository.findAll();
        int count = 0;
        for (Dataset dataset : datasets) {
            computeAndSave(dataset);
            count++;
        }
        log.info("Computed quality scores for {} datasets", count);
    }

    @Transactional
    public DataQualityScoreResponse computeAndSave(Dataset dataset) {
        int completeness = computeCompleteness(dataset);
        int freshness = computeFreshness(dataset);
        int schemaCoverage = computeSchemaCoverage(dataset);
        int overall = (completeness * 40 + freshness * 30 + schemaCoverage * 30) / 100;

        DataQualityScore score = qualityRepository.findByDatasetId(dataset.getId())
                .orElseGet(() -> {
                    DataQualityScore s = new DataQualityScore();
                    s.setDataset(dataset);
                    return s;
                });

        score.setOverallScore(overall);
        score.setCompletenessScore(completeness);
        score.setFreshnessScore(freshness);
        score.setSchemaCoverageScore(schemaCoverage);
        score.setComputedAt(Instant.now());

        return toResponse(qualityRepository.save(score));
    }

    /**
     * Completeness: checks if description, owner, tags, and schemas are present.
     * Each contributes 25 points.
     */
    private int computeCompleteness(Dataset dataset) {
        int score = 0;
        if (dataset.getDescription() != null && !dataset.getDescription().isBlank()) score += 25;
        if (dataset.getOwner() != null) score += 25;
        if (dataset.getTags() != null && !dataset.getTags().isEmpty()) score += 25;
        if (dataset.getSchemas() != null && !dataset.getSchemas().isEmpty()) score += 25;
        return score;
    }

    /**
     * Freshness: based on how recently the dataset was updated.
     * Updated within 7 days = 100, 30 days = 75, 90 days = 50, 365 days = 25, else 10
     */
    private int computeFreshness(Dataset dataset) {
        if (dataset.getUpdatedAt() == null) return 10;
        long daysSinceUpdate = Duration.between(dataset.getUpdatedAt(), Instant.now()).toDays();
        if (daysSinceUpdate <= 7) return 100;
        if (daysSinceUpdate <= 30) return 75;
        if (daysSinceUpdate <= 90) return 50;
        if (daysSinceUpdate <= 365) return 25;
        return 10;
    }

    /**
     * Schema coverage: percentage of columns that have descriptions.
     */
    private int computeSchemaCoverage(Dataset dataset) {
        if (dataset.getSchemas() == null || dataset.getSchemas().isEmpty()) return 0;
        long totalColumns = dataset.getSchemas().stream()
                .flatMap(s -> s.getColumns().stream())
                .count();
        if (totalColumns == 0) return 0;
        long describedColumns = dataset.getSchemas().stream()
                .flatMap(s -> s.getColumns().stream())
                .filter(c -> c.getDescription() != null && !c.getDescription().isBlank())
                .count();
        return (int) (describedColumns * 100 / totalColumns);
    }

    private DataQualityScoreResponse toResponse(DataQualityScore score) {
        return DataQualityScoreResponse.builder()
                .id(score.getId())
                .datasetId(score.getDataset().getId())
                .datasetName(score.getDataset().getName())
                .qualifiedName(score.getDataset().getQualifiedName())
                .overallScore(score.getOverallScore())
                .completenessScore(score.getCompletenessScore())
                .freshnessScore(score.getFreshnessScore())
                .schemaCoverageScore(score.getSchemaCoverageScore())
                .computedAt(score.getComputedAt())
                .build();
    }
}

