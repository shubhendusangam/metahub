package com.metahub.repository;

import com.metahub.model.SchemaDefinition;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.UUID;

@Repository
public interface SchemaRepository extends JpaRepository<SchemaDefinition, UUID> {
    List<SchemaDefinition> findByDatasetId(UUID datasetId);
}

