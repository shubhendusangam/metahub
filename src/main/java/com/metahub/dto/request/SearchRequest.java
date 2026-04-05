package com.metahub.dto.request;

import lombok.*;

@Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
public class SearchRequest {
    private String query;
    private String dataSourceFilter;
    private String tagFilter;
    private int page = 0;
    private int size = 20;
}

