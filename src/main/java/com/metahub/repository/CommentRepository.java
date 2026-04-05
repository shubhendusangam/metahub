package com.metahub.repository;

import com.metahub.model.Comment;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.UUID;

@Repository
public interface CommentRepository extends JpaRepository<Comment, UUID> {
    Page<Comment> findByDatasetIdOrderByCreatedAtDesc(UUID datasetId, Pageable pageable);
    long countByDatasetId(UUID datasetId);
}

