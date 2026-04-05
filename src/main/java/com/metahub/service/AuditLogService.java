package com.metahub.service;

import com.metahub.dto.response.AuditLogResponse;
import com.metahub.dto.response.PagedResponse;
import com.metahub.model.AuditLog;
import com.metahub.repository.AuditLogRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

@Slf4j
@Service
@RequiredArgsConstructor
public class AuditLogService {

    private final AuditLogRepository auditLogRepository;

    @Transactional
    public void record(String entityType, String entityId, String action, String changedBy, String details) {
        AuditLog entry = AuditLog.builder()
                .entityType(entityType)
                .entityId(entityId)
                .action(action)
                .changedBy(changedBy)
                .changeDetails(details)
                .build();
        auditLogRepository.save(entry);
        log.debug("Audit: {} {} {} by {}", action, entityType, entityId, changedBy);
    }

    @Transactional(readOnly = true)
    public PagedResponse<AuditLogResponse> list(String entityType, int page, int size) {
        Page<AuditLog> logPage;
        if (entityType != null && !entityType.isBlank()) {
            logPage = auditLogRepository.findByEntityTypeIgnoreCaseOrderByCreatedAtDesc(
                    entityType, PageRequest.of(page, size));
        } else {
            logPage = auditLogRepository.findAllByOrderByCreatedAtDesc(PageRequest.of(page, size));
        }
        return toPagedResponse(logPage);
    }

    private PagedResponse<AuditLogResponse> toPagedResponse(Page<AuditLog> page) {
        List<AuditLogResponse> content = page.getContent().stream()
                .map(this::toResponse)
                .collect(Collectors.toList());
        return PagedResponse.<AuditLogResponse>builder()
                .content(content)
                .page(page.getNumber())
                .size(page.getSize())
                .totalElements(page.getTotalElements())
                .totalPages(page.getTotalPages())
                .last(page.isLast())
                .build();
    }

    private AuditLogResponse toResponse(AuditLog log) {
        return AuditLogResponse.builder()
                .id(log.getId())
                .entityType(log.getEntityType())
                .entityId(log.getEntityId())
                .action(log.getAction())
                .changedBy(log.getChangedBy())
                .changeDetails(log.getChangeDetails())
                .createdAt(log.getCreatedAt())
                .build();
    }
}

