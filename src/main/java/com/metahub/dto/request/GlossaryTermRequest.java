package com.metahub.dto.request;

import jakarta.validation.constraints.NotBlank;
import lombok.*;

import java.util.List;
import java.util.Set;
import java.util.UUID;

@Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
public class GlossaryTermRequest {

    @NotBlank(message = "Term is required")
    private String term;

    @NotBlank(message = "Definition is required")
    private String definition;

    private String category;
    private List<String> synonyms;
    private Set<UUID> relatedDatasetIds;
}

