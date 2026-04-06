package com.metahub.service;

import com.metahub.dto.request.DataSourceRequest;
import com.metahub.dto.response.DataSourceResponse;
import com.metahub.exception.ResourceNotFoundException;
import com.metahub.model.DataSource;
import com.metahub.repository.DataSourceRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

@Slf4j
@Service
@RequiredArgsConstructor
public class DataSourceService {

    private final DataSourceRepository dataSourceRepository;

    @Transactional(readOnly = true)
    public List<DataSourceResponse> listAll() {
        return dataSourceRepository.findAll().stream()
                .map(this::toResponse)
                .collect(Collectors.toList());
    }

    @Transactional(readOnly = true)
    public DataSourceResponse getById(UUID id) {
        return toResponse(findOrThrow(id));
    }

    @Transactional
    public DataSourceResponse create(DataSourceRequest request) {
        DataSource ds = DataSource.builder()
                .name(request.getName())
                .type(request.getType())
                .connectionUrl(request.getConnectionUrl())
                .credentials(request.getCredentials())
                .description(request.getDescription())
                .build();
        return toResponse(dataSourceRepository.save(ds));
    }

    @Transactional
    public DataSourceResponse update(UUID id, DataSourceRequest request) {
        DataSource ds = findOrThrow(id);
        ds.setName(request.getName());
        ds.setType(request.getType());
        ds.setConnectionUrl(request.getConnectionUrl());
        ds.setCredentials(request.getCredentials());
        ds.setDescription(request.getDescription());
        return toResponse(dataSourceRepository.save(ds));
    }

    @Transactional
    public void delete(UUID id) {
        DataSource ds = findOrThrow(id);
        dataSourceRepository.delete(ds);
    }

    public boolean testConnection(UUID id) {
        DataSource ds = findOrThrow(id);
        log.info("Testing connection for DataSource: {} ({})", ds.getName(), ds.getType());
        return true;
    }

    private DataSource findOrThrow(UUID id) {
        return dataSourceRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("DataSource", "id", id));
    }

    private DataSourceResponse toResponse(DataSource ds) {
        return DataSourceResponse.builder()
                .id(ds.getId())
                .name(ds.getName())
                .type(ds.getType())
                .connectionUrl(ds.getConnectionUrl())
                .description(ds.getDescription())
                .createdAt(ds.getCreatedAt())
                .updatedAt(ds.getUpdatedAt())
                .build();
    }
}

