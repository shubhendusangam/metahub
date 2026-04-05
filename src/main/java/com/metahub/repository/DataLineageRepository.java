package com.metahub.repository;

import com.metahub.model.DataLineage;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.UUID;

@Repository
public interface DataLineageRepository extends JpaRepository<DataLineage, UUID> {
    List<DataLineage> findBySourceDatasetId(UUID sourceDatasetId);
    List<DataLineage> findByTargetDatasetId(UUID targetDatasetId);
    List<DataLineage> findBySourceDatasetIdOrTargetDatasetId(UUID sourceId, UUID targetId);
}

