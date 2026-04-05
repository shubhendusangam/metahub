package com.metahub.dto.response;

import lombok.*;

import java.time.Instant;
import java.util.UUID;

@Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
public class DataQualityScoreResponse {
    private UUID id;
    private UUID datasetId;
    private String datasetName;
    private String qualifiedName;
    private int overallScore;
    private int completenessScore;
    private int freshnessScore;
    private int schemaCoverageScore;
    private Instant computedAt;
}

