package com.metahub.ai;

import com.metahub.model.Dataset;
import lombok.*;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.time.Instant;
import java.util.Collections;
import java.util.List;

/**
 * Extension point for anomaly detection on metadata.
 * Currently a stub — integrate with external ML services for real detection.
 */
public interface AnomalyDetectionService {

    List<Anomaly> detect(Dataset dataset);

    @Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
    class Anomaly {
        private String type;
        private String description;
        private String severity; // LOW, MEDIUM, HIGH
        private Instant detectedAt;
    }
}

