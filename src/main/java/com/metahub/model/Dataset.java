package com.metahub.model;

import jakarta.persistence.*;
import lombok.*;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

@Entity
@Table(name = "datasets")
@Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
public class Dataset extends BaseEntity {

    @Column(nullable = false)
    private String name;

    @Column(length = 4000)
    private String description;

    @Column(nullable = false, unique = true)
    private String qualifiedName;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "data_source_id")
    private DataSource dataSource;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "owner_id")
    private User owner;

    @ManyToMany(fetch = FetchType.LAZY, cascade = {CascadeType.PERSIST, CascadeType.MERGE})
    @JoinTable(name = "dataset_tags",
        joinColumns = @JoinColumn(name = "dataset_id"),
        inverseJoinColumns = @JoinColumn(name = "tag_id"))
    @Builder.Default
    private Set<Tag> tags = new HashSet<>();

    @OneToMany(mappedBy = "dataset", cascade = CascadeType.ALL, orphanRemoval = true)
    @Builder.Default
    private List<SchemaDefinition> schemas = new ArrayList<>();
}

