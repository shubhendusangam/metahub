package com.metahub.model;

import jakarta.persistence.*;
import lombok.*;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

@Entity
@Table(name = "glossary_terms")
@Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
public class GlossaryTerm extends BaseEntity {

    @Column(nullable = false, unique = true)
    private String term;

    @Column(nullable = false, length = 4000)
    private String definition;

    private String category;

    @ElementCollection
    @CollectionTable(name = "glossary_synonyms", joinColumns = @JoinColumn(name = "term_id"))
    @Column(name = "synonym")
    @Builder.Default
    private List<String> synonyms = new ArrayList<>();

    @ManyToMany(fetch = FetchType.LAZY)
    @JoinTable(name = "glossary_term_datasets",
            joinColumns = @JoinColumn(name = "term_id"),
            inverseJoinColumns = @JoinColumn(name = "dataset_id"))
    @Builder.Default
    private Set<Dataset> relatedDatasets = new HashSet<>();
}

