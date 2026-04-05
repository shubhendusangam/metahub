package com.metahub.dto.request;

import com.metahub.model.enums.PolicyStatus;
import jakarta.validation.constraints.NotBlank;
import lombok.*;

import java.util.Set;
import java.util.UUID;

@Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
public class GovernancePolicyRequest {

    @NotBlank(message = "Name is required")
    private String name;

    private String description;
    private String rules;
    private PolicyStatus status;
    private Set<UUID> datasetIds;
}

