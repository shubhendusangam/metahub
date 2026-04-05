package com.metahub.service.ingestion;

import com.metahub.model.DataSource;
import com.metahub.model.Dataset;

import java.util.List;

/**
 * Strategy interface for metadata ingestion from various data source types.
 */
public interface IngestionStrategy {
    List<Dataset> ingest(DataSource source);
    boolean supports(DataSource source);
}

