package com.metahub.dto.request;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.*;

import java.util.UUID;

@Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
public class CommentRequest {

    @NotBlank(message = "Content is required")
    private String content;

    @NotNull(message = "Author ID is required")
    private UUID authorId;
}

