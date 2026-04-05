package com.metahub.service.ingestion;

import com.metahub.model.DataSource;
import com.metahub.model.Dataset;
import com.metahub.model.enums.DataSourceType;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;

/**
 * Stub: Ingests metadata from external REST/GraphQL APIs.
 * Extend this to call specific metadata API endpoints.
 */
@Slf4j
@Component
public class ApiIngestionStrategy implements IngestionStrategy {

    @Override
    public boolean supports(DataSource source) {
        return source.getType() == DataSourceType.API;
    }

    @Override
    public List<Dataset> ingest(DataSource source) {
        log.info("API ingestion for source: {} (stub — implement API calls)", source.getName());
        // TODO: Call external metadata API and parse response into Datasets
        return new ArrayList<>();
    }
}

