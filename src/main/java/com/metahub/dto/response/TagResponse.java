package com.metahub.dto.response;

import lombok.*;

import java.time.Instant;
import java.util.UUID;

@Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
public class TagResponse {
    private UUID id;
    private String name;
    private String category;
    private String description;
    private Instant createdAt;
}

