package com.metahub.service.ingestion;

import com.metahub.event.MetadataChangeEvent;
import com.metahub.exception.IngestionException;
import com.metahub.exception.ResourceNotFoundException;
import com.metahub.model.DataSource;
import com.metahub.model.Dataset;
import com.metahub.repository.DataSourceRepository;
import com.metahub.repository.DatasetRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.ApplicationEventPublisher;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.UUID;

@Slf4j
@Service
@RequiredArgsConstructor
public class IngestionOrchestrator {

    private final List<IngestionStrategy> strategies;
    private final DataSourceRepository dataSourceRepository;
    private final DatasetRepository datasetRepository;
    private final ApplicationEventPublisher eventPublisher;

    @Transactional
    public List<Dataset> runIngestion(UUID dataSourceId) {
        DataSource source = dataSourceRepository.findById(dataSourceId)
                .orElseThrow(() -> new ResourceNotFoundException("DataSource", "id", dataSourceId));

        IngestionStrategy strategy = strategies.stream()
                .filter(s -> s.supports(source))
                .findFirst()
                .orElseThrow(() -> new IngestionException(
                        "No ingestion strategy found for source type: " + source.getType()));

        log.info("Running ingestion for source: {} using strategy: {}",
                source.getName(), strategy.getClass().getSimpleName());

        List<Dataset> ingested = strategy.ingest(source);

        // Persist and publish events for each ingested dataset
        for (Dataset dataset : ingested) {
            // Check if dataset already exists by qualified name
            var existing = datasetRepository.findByQualifiedName(dataset.getQualifiedName());
            if (existing.isPresent()) {
                Dataset existingDs = existing.get();
                existingDs.setDescription(dataset.getDescription());
                existingDs.setSchemas(dataset.getSchemas());
                dataset.getSchemas().forEach(s -> s.setDataset(existingDs));
                Dataset saved = datasetRepository.save(existingDs);
                eventPublisher.publishEvent(new MetadataChangeEvent(this, saved, MetadataChangeEvent.Action.UPDATED));
            } else {
                Dataset saved = datasetRepository.save(dataset);
                eventPublisher.publishEvent(new MetadataChangeEvent(this, saved, MetadataChangeEvent.Action.CREATED));
            }
        }

        log.info("Ingestion complete. Processed {} datasets from source: {}", ingested.size(), source.getName());
        return ingested;
    }
}

