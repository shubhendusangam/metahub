package com.metahub.service.ingestion;

import com.metahub.model.DataSource;
import com.metahub.model.Dataset;
import com.metahub.model.enums.DataSourceType;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;

/**
 * Stub: Ingests metadata from cloud storage (S3, GCS, Azure Blob).
 * Implement by using the respective SDK to list objects and extract metadata.
 */
@Slf4j
@Component
public class CloudStorageIngestionStrategy implements IngestionStrategy {

    @Override
    public boolean supports(DataSource source) {
        return source.getType() == DataSourceType.CLOUD_STORAGE;
    }

    @Override
    public List<Dataset> ingest(DataSource source) {
        log.info("Cloud storage ingestion for source: {} (stub — implement SDK calls)", source.getName());
        // TODO: Use AWS S3 / GCS / Azure Blob SDK to list objects and extract metadata
        return new ArrayList<>();
    }
}

