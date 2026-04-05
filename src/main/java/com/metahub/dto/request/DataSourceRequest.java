package com.metahub.dto.request;

import com.metahub.model.enums.DataSourceType;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.*;

@Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
public class DataSourceRequest {

    @NotBlank(message = "Name is required")
    private String name;

    @NotNull(message = "Type is required")
    private DataSourceType type;

    private String connectionUrl;
    private String credentials;
    private String description;
}

