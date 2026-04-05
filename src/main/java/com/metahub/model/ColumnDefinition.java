package com.metahub.model;

import com.metahub.model.enums.ColumnDataType;
import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "column_definitions")
@Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
public class ColumnDefinition extends BaseEntity {

    @Column(nullable = false)
    private String name;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private ColumnDataType dataType;

    @Column(nullable = false)
    @Builder.Default
    private Boolean nullable = true;

    @Column(nullable = false)
    @Builder.Default
    private Boolean isPrimaryKey = false;

    @Column(length = 2000)
    private String description;

    private Integer ordinalPosition;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "schema_id", nullable = false)
    private SchemaDefinition schema;
}

