package com.metahub.dto.response;

import com.metahub.model.enums.ColumnDataType;
import lombok.*;

import java.time.Instant;
import java.util.List;
import java.util.Set;
import java.util.UUID;

@Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
public class DatasetResponse {
    private UUID id;
    private String name;
    private String description;
    private String qualifiedName;
    private String dataSourceName;
    private UUID dataSourceId;
    private String ownerName;
    private UUID ownerId;
    private Set<String> tags;
    private List<SchemaResponse> schemas;
    private Instant createdAt;
    private Instant updatedAt;

    @Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
    public static class SchemaResponse {
        private UUID id;
        private String name;
        private Integer version;
        private List<ColumnResponse> columns;
    }

    @Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
    public static class ColumnResponse {
        private UUID id;
        private String name;
        private ColumnDataType dataType;
        private Boolean nullable;
        private Boolean isPrimaryKey;
        private String description;
        private Integer ordinalPosition;
    }
}

