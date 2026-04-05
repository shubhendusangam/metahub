package com.metahub.model;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "tags")
@Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
@JsonIgnoreProperties({"hibernateLazyInitializer", "handler"})
public class Tag extends BaseEntity {

    @Column(nullable = false, unique = true)
    private String name;

    private String category;

    @Column(length = 1000)
    private String description;
}

