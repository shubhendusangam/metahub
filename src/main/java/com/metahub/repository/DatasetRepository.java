package com.metahub.repository;

import com.metahub.model.Dataset;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.Optional;
import java.util.UUID;

@Repository
public interface DatasetRepository extends JpaRepository<Dataset, UUID> {

    Optional<Dataset> findByQualifiedName(String qualifiedName);

    @Query("SELECT DISTINCT d FROM Dataset d LEFT JOIN d.tags t WHERE " +
           "LOWER(d.name) LIKE LOWER(CONCAT('%', :query, '%')) OR " +
           "LOWER(d.description) LIKE LOWER(CONCAT('%', :query, '%')) OR " +
           "LOWER(d.qualifiedName) LIKE LOWER(CONCAT('%', :query, '%')) OR " +
           "LOWER(t.name) LIKE LOWER(CONCAT('%', :query, '%'))")
    Page<Dataset> searchByQuery(@Param("query") String query, Pageable pageable);

    Page<Dataset> findByDataSourceId(UUID dataSourceId, Pageable pageable);
}

