package com.metahub.ai;

import com.metahub.model.Dataset;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.Collections;
import java.util.List;

/**
 * No-op stub implementation. Replace with real ML-based anomaly detection.
 */
@Slf4j
@Service
public class StubAnomalyDetectionService implements AnomalyDetectionService {

    @Override
    public List<Anomaly> detect(Dataset dataset) {
        log.debug("Anomaly detection stub called for dataset: {}", dataset.getQualifiedName());
        // TODO: Integrate with external ML service (e.g., Python microservice, SageMaker)
        return Collections.emptyList();
    }
}

