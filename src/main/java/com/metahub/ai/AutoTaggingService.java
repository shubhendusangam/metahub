package com.metahub.ai;

import com.metahub.model.Dataset;
import com.metahub.model.Tag;

import java.util.List;

/**
 * Extension point for AI/ML-based auto-tagging of datasets.
 * Implement this interface with your preferred ML model or rule engine.
 */
public interface AutoTaggingService {
    List<Tag> suggestTags(Dataset dataset);
}

