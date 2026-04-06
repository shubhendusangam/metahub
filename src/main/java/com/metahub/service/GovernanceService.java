package com.metahub.service;

import com.metahub.dto.request.GovernancePolicyRequest;
import com.metahub.dto.response.GovernancePolicyResponse;
import com.metahub.dto.response.GovernancePolicyResponse.DatasetSummary;
import com.metahub.model.Dataset;
import com.metahub.model.GovernancePolicy;
import com.metahub.model.enums.PolicyStatus;
import com.metahub.repository.DatasetRepository;
import com.metahub.repository.GovernancePolicyRepository;
import com.metahub.util.EntityUtils;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class GovernanceService {

    private static final String ENTITY_NAME = "GovernancePolicy";
    
    private final GovernancePolicyRepository policyRepository;
    private final DatasetRepository datasetRepository;

    @Transactional(readOnly = true)
    public List<GovernancePolicyResponse> listAll() {
        return policyRepository.findAll().stream()
                .map(this::toResponse)
                .collect(Collectors.toList());
    }

    @Transactional(readOnly = true)
    public GovernancePolicyResponse getById(UUID id) {
        return toResponse(findOrThrow(id));
    }

    @Transactional
    public GovernancePolicyResponse create(GovernancePolicyRequest request) {
        GovernancePolicy policy = GovernancePolicy.builder()
                .name(request.getName())
                .description(request.getDescription())
                .rules(request.getRules())
                .status(Optional.ofNullable(request.getStatus()).orElse(PolicyStatus.DRAFT))
                .build();

        attachDatasetsIfPresent(policy, request.getDatasetIds());
        return toResponse(policyRepository.save(policy));
    }

    @Transactional
    public GovernancePolicyResponse update(UUID id, GovernancePolicyRequest request) {
        GovernancePolicy policy = findOrThrow(id);
        
        policy.setName(request.getName());
        policy.setDescription(request.getDescription());
        policy.setRules(request.getRules());
        Optional.ofNullable(request.getStatus()).ifPresent(policy::setStatus);

        if (request.getDatasetIds() != null) {
            Set<Dataset> datasets = new HashSet<>(datasetRepository.findAllById(request.getDatasetIds()));
            policy.setApplicableDatasets(datasets);
        }

        return toResponse(policyRepository.save(policy));
    }

    @Transactional
    public GovernancePolicyResponse attachDatasets(UUID policyId, Set<UUID> datasetIds) {
        GovernancePolicy policy = findOrThrow(policyId);
        Set<Dataset> datasets = new HashSet<>(datasetRepository.findAllById(datasetIds));
        policy.getApplicableDatasets().addAll(datasets);
        return toResponse(policyRepository.save(policy));
    }

    @Transactional
    public GovernancePolicyResponse detachDatasets(UUID policyId, Set<UUID> datasetIds) {
        GovernancePolicy policy = findOrThrow(policyId);
        policy.getApplicableDatasets().removeIf(ds -> datasetIds.contains(ds.getId()));
        return toResponse(policyRepository.save(policy));
    }

    @Transactional
    public void delete(UUID id) {
        GovernancePolicy policy = findOrThrow(id);
        policyRepository.delete(policy);
    }

    // ========== Private Helper Methods ==========

    private GovernancePolicy findOrThrow(UUID id) {
        return EntityUtils.findOrThrow(policyRepository, id, ENTITY_NAME);
    }

    private void attachDatasetsIfPresent(GovernancePolicy policy, Set<UUID> datasetIds) {
        if (datasetIds != null && !datasetIds.isEmpty()) {
            Set<Dataset> datasets = new HashSet<>(datasetRepository.findAllById(datasetIds));
            policy.setApplicableDatasets(datasets);
        }
    }

    private GovernancePolicyResponse toResponse(GovernancePolicy policy) {
        List<DatasetSummary> datasets = Optional.ofNullable(policy.getApplicableDatasets())
                .map(ds -> ds.stream()
                        .map(this::toDatasetSummary)
                        .collect(Collectors.toList()))
                .orElse(Collections.emptyList());

        return GovernancePolicyResponse.builder()
                .id(policy.getId())
                .name(policy.getName())
                .description(policy.getDescription())
                .rules(policy.getRules())
                .status(policy.getStatus())
                .applicableDatasets(datasets)
                .createdAt(policy.getCreatedAt())
                .updatedAt(policy.getUpdatedAt())
                .build();
    }

    private DatasetSummary toDatasetSummary(Dataset ds) {
        return DatasetSummary.builder()
                .id(ds.getId())
                .name(ds.getName())
                .qualifiedName(ds.getQualifiedName())
                .build();
    }
}

