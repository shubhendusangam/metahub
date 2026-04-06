package com.metahub.dto.request;

import jakarta.validation.constraints.NotNull;
import lombok.*;

import java.util.UUID;

@Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
public class BookmarkRequest {

    @NotNull(message = "User ID is required")
    private UUID userId;

    @NotNull(message = "Dataset ID is required")
    private UUID datasetId;
}

