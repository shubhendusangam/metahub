package com.metahub.dto.response;

import lombok.*;

import java.time.Instant;
import java.util.UUID;

@Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
public class CommentResponse {
    private UUID id;
    private String content;
    private UUID datasetId;
    private UUID authorId;
    private String authorName;
    private Instant createdAt;
    private Instant updatedAt;
}

