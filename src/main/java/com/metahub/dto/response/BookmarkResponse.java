package com.metahub.dto.response;

import lombok.*;

import java.time.Instant;
import java.util.UUID;

@Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
public class BookmarkResponse {
    private UUID id;
    private UUID datasetId;
    private String datasetName;
    private String datasetQualifiedName;
    private String datasetDescription;
    private UUID userId;
    private Instant createdAt;
}

