package com.metahub.dto.response;

import lombok.*;

import java.time.Instant;
import java.util.UUID;

@Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
public class AuditLogResponse {
    private UUID id;
    private String entityType;
    private String entityId;
    private String action;
    private String changedBy;
    private String changeDetails;
    private Instant createdAt;
}

