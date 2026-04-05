package com.metahub.repository;

import com.metahub.model.Bookmark;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;
import java.util.UUID;

@Repository
public interface BookmarkRepository extends JpaRepository<Bookmark, UUID> {
    Page<Bookmark> findByUserIdOrderByCreatedAtDesc(UUID userId, Pageable pageable);
    Optional<Bookmark> findByUserIdAndDatasetId(UUID userId, UUID datasetId);
    boolean existsByUserIdAndDatasetId(UUID userId, UUID datasetId);
    void deleteByUserIdAndDatasetId(UUID userId, UUID datasetId);
}

