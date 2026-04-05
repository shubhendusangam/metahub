package com.metahub.dto.request;

import jakarta.validation.constraints.NotBlank;
import lombok.*;

import java.util.Set;
import java.util.UUID;

@Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
public class DatasetRequest {

    @NotBlank(message = "Name is required")
    private String name;

    private String description;

    @NotBlank(message = "Qualified name is required")
    private String qualifiedName;

    private UUID dataSourceId;
    private UUID ownerId;
    private Set<String> tagNames;
}

