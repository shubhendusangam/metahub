package com.metahub.repository;

import com.metahub.model.AuditLog;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.UUID;

@Repository
public interface AuditLogRepository extends JpaRepository<AuditLog, UUID> {
    Page<AuditLog> findByEntityTypeIgnoreCaseOrderByCreatedAtDesc(String entityType, Pageable pageable);
    Page<AuditLog> findByEntityIdOrderByCreatedAtDesc(String entityId, Pageable pageable);
    Page<AuditLog> findAllByOrderByCreatedAtDesc(Pageable pageable);
}

