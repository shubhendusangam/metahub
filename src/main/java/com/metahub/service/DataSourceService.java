package com.metahub.service;

import com.metahub.dto.request.DataSourceRequest;
import com.metahub.exception.ResourceNotFoundException;
import com.metahub.model.DataSource;
import com.metahub.repository.DataSourceRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.UUID;

@Slf4j
@Service
@RequiredArgsConstructor
public class DataSourceService {

    private final DataSourceRepository dataSourceRepository;

    @Transactional(readOnly = true)
    public List<DataSource> listAll() {
        return dataSourceRepository.findAll();
    }

    @Transactional(readOnly = true)
    public DataSource getById(UUID id) {
        return dataSourceRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("DataSource", "id", id));
    }

    @Transactional
    public DataSource create(DataSourceRequest request) {
        DataSource ds = DataSource.builder()
                .name(request.getName())
                .type(request.getType())
                .connectionUrl(request.getConnectionUrl())
                .credentials(request.getCredentials())
                .description(request.getDescription())
                .build();
        return dataSourceRepository.save(ds);
    }

    @Transactional
    public DataSource update(UUID id, DataSourceRequest request) {
        DataSource ds = getById(id);
        ds.setName(request.getName());
        ds.setType(request.getType());
        ds.setConnectionUrl(request.getConnectionUrl());
        ds.setCredentials(request.getCredentials());
        ds.setDescription(request.getDescription());
        return dataSourceRepository.save(ds);
    }

    @Transactional
    public void delete(UUID id) {
        DataSource ds = getById(id);
        dataSourceRepository.delete(ds);
    }

    public boolean testConnection(UUID id) {
        DataSource ds = getById(id);
        // Stub: In production, attempt actual connection based on type
        log.info("Testing connection for DataSource: {} ({})", ds.getName(), ds.getType());
        return true;
    }
}

