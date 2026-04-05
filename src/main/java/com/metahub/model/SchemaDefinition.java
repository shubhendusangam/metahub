package com.metahub.model;

import jakarta.persistence.*;
import lombok.*;

import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "schema_definitions")
@Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
public class SchemaDefinition extends BaseEntity {

    @Column(nullable = false)
    private String name;

    private Integer version;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "dataset_id", nullable = false)
    private Dataset dataset;

    @OneToMany(mappedBy = "schema", cascade = CascadeType.ALL, orphanRemoval = true)
    @Builder.Default
    private List<ColumnDefinition> columns = new ArrayList<>();
}

