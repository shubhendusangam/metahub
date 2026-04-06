package com.metahub.dto.request;

import jakarta.validation.constraints.NotBlank;
import lombok.*;

@Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
public class TagRequest {

    @NotBlank(message = "Tag name is required")
    private String name;

    private String category;
    private String description;
}

