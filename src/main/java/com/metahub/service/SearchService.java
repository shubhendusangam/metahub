package com.metahub.service;

import com.metahub.dto.response.SearchResponse;
import com.metahub.dto.response.SearchResponse.SearchHit;
import com.metahub.model.Dataset;
import com.metahub.model.Tag;
import com.metahub.repository.DatasetRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;
import java.util.stream.Collectors;

@Slf4j
@Service
@RequiredArgsConstructor
public class SearchService {

    private final DatasetRepository datasetRepository;

    /**
     * In dev profile, searches datasets using JPA LIKE queries.
     * Supports multi-word queries by searching for each term.
     */
    @Transactional(readOnly = true)
    public SearchResponse search(String query, int page, int size) {
        if (query == null || query.isBlank()) {
            Page<Dataset> all = datasetRepository.findAll(PageRequest.of(page, size));
            return toSearchResponse(all, page, size);
        }

        // Split query into words and search for each
        String[] terms = query.trim().toLowerCase().split("\\s+");

        // Collect all matching datasets with scores
        Map<UUID, Dataset> uniqueResults = new LinkedHashMap<>();
        Map<UUID, Integer> scores = new HashMap<>();

        for (String term : terms) {
            if (term.length() < 2) continue; // Skip very short terms

            Page<Dataset> results = datasetRepository.searchByQuery(term, PageRequest.of(0, 100));
            for (Dataset ds : results.getContent()) {
                uniqueResults.putIfAbsent(ds.getId(), ds);
                scores.merge(ds.getId(), 1, Integer::sum);
            }
        }

        // Sort by score (number of matching terms) descending
        List<Dataset> sortedResults = uniqueResults.values().stream()
                .sorted((a, b) -> scores.get(b.getId()).compareTo(scores.get(a.getId())))
                .collect(Collectors.toList());

        // Paginate
        int start = page * size;
        int end = Math.min(start + size, sortedResults.size());
        List<Dataset> pageContent = start < sortedResults.size()
                ? sortedResults.subList(start, end)
                : Collections.emptyList();

        Page<Dataset> pagedResults = new PageImpl<>(pageContent, PageRequest.of(page, size), sortedResults.size());
        return toSearchResponse(pagedResults, page, size);
    }

    private SearchResponse toSearchResponse(Page<Dataset> datasetPage, int page, int size) {
        var hits = datasetPage.getContent().stream()
                .map(ds -> SearchHit.builder()
                        .id(ds.getId().toString())
                        .name(ds.getName())
                        .qualifiedName(ds.getQualifiedName())
                        .description(ds.getDescription())
                        .dataSourceName(ds.getDataSource() != null ? ds.getDataSource().getName() : null)
                        .tags(ds.getTags() != null
                                ? ds.getTags().stream().map(Tag::getName).collect(Collectors.toList())
                                : Collections.emptyList())
                        .score(1.0)
                        .build())
                .collect(Collectors.toList());

        return SearchResponse.builder()
                .hits(hits)
                .totalHits(datasetPage.getTotalElements())
                .page(page)
                .size(size)
                .build();
    }
}

