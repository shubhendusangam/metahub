package com.metahub.dto.response;

import com.metahub.model.enums.DataSourceType;
import lombok.*;

import java.time.Instant;
import java.util.UUID;

@Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
public class DataSourceResponse {
    private UUID id;
    private String name;
    private DataSourceType type;
    private String connectionUrl;
    private String description;
    private Instant createdAt;
    private Instant updatedAt;
}

