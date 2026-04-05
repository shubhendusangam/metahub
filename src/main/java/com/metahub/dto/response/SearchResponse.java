package com.metahub.dto.response;

import lombok.*;

import java.util.List;

@Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
public class SearchResponse {
    private List<SearchHit> hits;
    private long totalHits;
    private int page;
    private int size;

    @Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
    public static class SearchHit {
        private String id;
        private String name;
        private String qualifiedName;
        private String description;
        private String dataSourceName;
        private List<String> tags;
        private double score;
    }
}

