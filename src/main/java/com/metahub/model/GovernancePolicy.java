package com.metahub.model;

import com.metahub.model.enums.PolicyStatus;
import jakarta.persistence.*;
import lombok.*;

import java.util.HashSet;
import java.util.Set;

@Entity
@Table(name = "governance_policies")
@Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
public class GovernancePolicy extends BaseEntity {

    @Column(nullable = false)
    private String name;

    @Column(length = 4000)
    private String description;

    @Column(columnDefinition = "TEXT")
    private String rules;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private PolicyStatus status;

    @ManyToMany(fetch = FetchType.LAZY)
    @JoinTable(name = "policy_datasets",
        joinColumns = @JoinColumn(name = "policy_id"),
        inverseJoinColumns = @JoinColumn(name = "dataset_id"))
    @Builder.Default
    private Set<Dataset> applicableDatasets = new HashSet<>();
}

