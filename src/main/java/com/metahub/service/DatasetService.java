package com.metahub.service;

import com.metahub.dto.request.DatasetRequest;
import com.metahub.dto.response.DatasetResponse;
import com.metahub.dto.response.PagedResponse;
import com.metahub.event.MetadataChangeEvent;
import com.metahub.exception.ResourceNotFoundException;
import com.metahub.mapper.DatasetMapper;
import com.metahub.model.*;
import com.metahub.repository.*;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.ApplicationEventPublisher;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;
import java.util.stream.Collectors;

@Slf4j
@Service
@RequiredArgsConstructor
public class DatasetService {

    private final DatasetRepository datasetRepository;
    private final DataSourceRepository dataSourceRepository;
    private final UserRepository userRepository;
    private final TagRepository tagRepository;
    private final DatasetMapper datasetMapper;
    private final ApplicationEventPublisher eventPublisher;

    @Transactional(readOnly = true)
    public PagedResponse<DatasetResponse> listDatasets(int page, int size) {
        Page<Dataset> datasetPage = datasetRepository.findAll(
                PageRequest.of(page, size, Sort.by(Sort.Direction.DESC, "createdAt")));
        return toPagedResponse(datasetPage);
    }

    @Transactional(readOnly = true)
    public DatasetResponse getDataset(UUID id) {
        Dataset dataset = findDatasetOrThrow(id);
        return datasetMapper.toResponse(dataset);
    }

    /**
     * Get the raw Dataset entity for internal use (e.g., AI services).
     */
    @Transactional(readOnly = true)
    public Dataset getDatasetEntity(UUID id) {
        return findDatasetOrThrow(id);
    }

    @Transactional
    public DatasetResponse createDataset(DatasetRequest request) {
        Dataset dataset = new Dataset();
        dataset.setName(request.getName());
        dataset.setDescription(request.getDescription());
        dataset.setQualifiedName(request.getQualifiedName());

        if (request.getDataSourceId() != null) {
            DataSource ds = dataSourceRepository.findById(request.getDataSourceId())
                    .orElseThrow(() -> new ResourceNotFoundException("DataSource", "id", request.getDataSourceId()));
            dataset.setDataSource(ds);
        }

        if (request.getOwnerId() != null) {
            User owner = userRepository.findById(request.getOwnerId())
                    .orElseThrow(() -> new ResourceNotFoundException("User", "id", request.getOwnerId()));
            dataset.setOwner(owner);
        }

        if (request.getTagNames() != null && !request.getTagNames().isEmpty()) {
            Set<Tag> tags = resolveOrCreateTags(request.getTagNames());
            dataset.setTags(tags);
        }

        Dataset saved = datasetRepository.save(dataset);
        eventPublisher.publishEvent(new MetadataChangeEvent(this, saved, MetadataChangeEvent.Action.CREATED));
        log.info("Created dataset: {}", saved.getQualifiedName());
        return datasetMapper.toResponse(saved);
    }

    @Transactional
    public DatasetResponse updateDataset(UUID id, DatasetRequest request) {
        Dataset dataset = findDatasetOrThrow(id);
        dataset.setName(request.getName());
        dataset.setDescription(request.getDescription());
        dataset.setQualifiedName(request.getQualifiedName());

        if (request.getDataSourceId() != null) {
            DataSource ds = dataSourceRepository.findById(request.getDataSourceId())
                    .orElseThrow(() -> new ResourceNotFoundException("DataSource", "id", request.getDataSourceId()));
            dataset.setDataSource(ds);
        }

        if (request.getOwnerId() != null) {
            User owner = userRepository.findById(request.getOwnerId())
                    .orElseThrow(() -> new ResourceNotFoundException("User", "id", request.getOwnerId()));
            dataset.setOwner(owner);
        }

        if (request.getTagNames() != null) {
            Set<Tag> tags = resolveOrCreateTags(request.getTagNames());
            dataset.setTags(tags);
        }

        Dataset saved = datasetRepository.save(dataset);
        eventPublisher.publishEvent(new MetadataChangeEvent(this, saved, MetadataChangeEvent.Action.UPDATED));
        return datasetMapper.toResponse(saved);
    }

    @Transactional
    public void deleteDataset(UUID id) {
        Dataset dataset = findDatasetOrThrow(id);
        datasetRepository.delete(dataset);
        eventPublisher.publishEvent(new MetadataChangeEvent(this, dataset, MetadataChangeEvent.Action.DELETED));
        log.info("Deleted dataset: {}", dataset.getQualifiedName());
    }

    @Transactional
    public DatasetResponse addTags(UUID datasetId, Set<String> tagNames) {
        Dataset dataset = findDatasetOrThrow(datasetId);
        Set<Tag> tags = resolveOrCreateTags(tagNames);
        dataset.getTags().addAll(tags);
        Dataset saved = datasetRepository.save(dataset);
        eventPublisher.publishEvent(new MetadataChangeEvent(this, saved, MetadataChangeEvent.Action.UPDATED));
        return datasetMapper.toResponse(saved);
    }

    private Dataset findDatasetOrThrow(UUID id) {
        return datasetRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Dataset", "id", id));
    }

    private Set<Tag> resolveOrCreateTags(Set<String> tagNames) {
        Set<Tag> existing = tagRepository.findByNameIn(tagNames);
        Set<String> existingNames = existing.stream().map(Tag::getName).collect(Collectors.toSet());

        Set<Tag> newTags = tagNames.stream()
                .filter(name -> !existingNames.contains(name))
                .map(name -> Tag.builder().name(name).build())
                .collect(Collectors.toSet());

        if (!newTags.isEmpty()) {
            tagRepository.saveAll(newTags);
            existing.addAll(newTags);
        }
        return existing;
    }

    private PagedResponse<DatasetResponse> toPagedResponse(Page<Dataset> page) {
        List<DatasetResponse> content = page.getContent().stream()
                .map(datasetMapper::toResponse)
                .collect(Collectors.toList());
        return PagedResponse.<DatasetResponse>builder()
                .content(content)
                .page(page.getNumber())
                .size(page.getSize())
                .totalElements(page.getTotalElements())
                .totalPages(page.getTotalPages())
                .last(page.isLast())
                .build();
    }
}

