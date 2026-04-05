package com.metahub.event;

import com.metahub.document.DatasetDocument;
import com.metahub.model.Dataset;
import com.metahub.model.SchemaDefinition;
import com.metahub.model.Tag;
import com.metahub.repository.search.DatasetSearchRepository;
import com.metahub.service.AuditLogService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.event.EventListener;
import org.springframework.stereotype.Component;

import java.util.Collections;
import java.util.stream.Collectors;

@Slf4j
@Component
public class MetadataEventListener {

    @Value("${metahub.search.engine:jpa}")
    private String searchEngine;

    @Autowired(required = false)
    private DatasetSearchRepository searchRepository;

    @Autowired
    private AuditLogService auditLogService;

    @EventListener
    public void handleMetadataChange(MetadataChangeEvent event) {
        // Always record audit log
        Dataset dataset = event.getDataset();
        auditLogService.record(
                "Dataset",
                dataset.getId().toString(),
                event.getAction().name(),
                dataset.getOwner() != null ? dataset.getOwner().getUsername() : "system",
                String.format("%s dataset: %s (%s)", event.getAction().name().toLowerCase(),
                        dataset.getName(), dataset.getQualifiedName())
        );

        if (!"elasticsearch".equals(searchEngine) || searchRepository == null) {
            log.debug("ES sync skipped (engine={})", searchEngine);
            return;
        }
        switch (event.getAction()) {
            case CREATED, UPDATED -> {
                DatasetDocument doc = toDocument(dataset);
                searchRepository.save(doc);
                log.info("Indexed dataset {} in ES", dataset.getQualifiedName());
            }
            case DELETED -> {
                searchRepository.deleteById(dataset.getId().toString());
                log.info("Deleted dataset {} from ES", dataset.getQualifiedName());
            }
        }
    }

    private DatasetDocument toDocument(Dataset dataset) {
        return DatasetDocument.builder()
                .id(dataset.getId().toString())
                .name(dataset.getName())
                .description(dataset.getDescription())
                .qualifiedName(dataset.getQualifiedName())
                .tags(dataset.getTags() != null
                        ? dataset.getTags().stream().map(Tag::getName).collect(Collectors.toList())
                        : Collections.emptyList())
                .ownerName(dataset.getOwner() != null ? dataset.getOwner().getDisplayName() : null)
                .dataSourceName(dataset.getDataSource() != null ? dataset.getDataSource().getName() : null)
                .columnNames(dataset.getSchemas() != null
                        ? dataset.getSchemas().stream()
                            .flatMap(s -> s.getColumns().stream())
                            .map(c -> c.getName())
                            .collect(Collectors.toList())
                        : Collections.emptyList())
                .build();
    }
}

