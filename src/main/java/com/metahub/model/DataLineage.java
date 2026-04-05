package com.metahub.model;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "data_lineage")
@Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
public class DataLineage extends BaseEntity {

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "source_dataset_id", nullable = false)
    private Dataset sourceDataset;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "target_dataset_id", nullable = false)
    private Dataset targetDataset;

    @Column(length = 4000)
    private String transformationDescription;

    private String jobName;
}

