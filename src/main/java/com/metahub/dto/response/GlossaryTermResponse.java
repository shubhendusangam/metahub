package com.metahub.dto.response;

import lombok.*;

import java.time.Instant;
import java.util.List;
import java.util.UUID;

@Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
public class GlossaryTermResponse {
    private UUID id;
    private String term;
    private String definition;
    private String category;
    private List<String> synonyms;
    private List<RelatedDataset> relatedDatasets;
    private Instant createdAt;
    private Instant updatedAt;

    @Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
    public static class RelatedDataset {
        private UUID id;
        private String name;
        private String qualifiedName;
    }
}

