package com.metahub.dto.response;

import com.metahub.model.enums.PolicyStatus;
import lombok.*;

import java.time.Instant;
import java.util.List;
import java.util.UUID;

@Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
public class GovernancePolicyResponse {
    private UUID id;
    private String name;
    private String description;
    private String rules;
    private PolicyStatus status;
    private List<DatasetSummary> applicableDatasets;
    private Instant createdAt;
    private Instant updatedAt;

    @Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
    public static class DatasetSummary {
        private UUID id;
        private String name;
        private String qualifiedName;
    }
}

