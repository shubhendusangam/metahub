package com.metahub.model;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "bookmarks",
       uniqueConstraints = @UniqueConstraint(columnNames = {"user_id", "dataset_id"}))
@Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
public class Bookmark extends BaseEntity {

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "dataset_id", nullable = false)
    private Dataset dataset;
}

