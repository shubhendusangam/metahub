package com.metahub.model;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.metahub.model.enums.DataSourceType;
import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "data_sources")
@Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
@JsonIgnoreProperties({"hibernateLazyInitializer", "handler"})
public class DataSource extends BaseEntity {

    @Column(nullable = false)
    private String name;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private DataSourceType type;

    private String connectionUrl;

    @Column(length = 1024)
    private String credentials;

    @Column(length = 2000)
    private String description;
}

