package com.metahub.model;

import jakarta.persistence.*;
import lombok.*;

import java.time.Instant;

@Entity
@Table(name = "data_quality_scores",
       uniqueConstraints = @UniqueConstraint(columnNames = "dataset_id"))
@Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
public class DataQualityScore extends BaseEntity {

    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "dataset_id", nullable = false)
    private Dataset dataset;

    @Column(nullable = false)
    private int overallScore;

    @Column(nullable = false)
    private int completenessScore;

    @Column(nullable = false)
    private int freshnessScore;

    @Column(nullable = false)
    private int schemaCoverageScore;

    @Column(nullable = false)
    private Instant computedAt;
}

