package com.metahub.dto.request;

import jakarta.validation.constraints.NotNull;
import lombok.*;

import java.util.UUID;

@Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
public class LineageRequest {

    @NotNull(message = "Source dataset ID is required")
    private UUID sourceDatasetId;

    @NotNull(message = "Target dataset ID is required")
    private UUID targetDatasetId;

    private String transformationDescription;
    private String jobName;
}

