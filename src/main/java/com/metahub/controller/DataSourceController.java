package com.metahub.controller;

import com.metahub.dto.request.DataSourceRequest;
import com.metahub.dto.response.ApiResponse;
import com.metahub.dto.response.DataSourceResponse;
import com.metahub.service.DataSourceService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("/api/v1/datasources")
@RequiredArgsConstructor
public class DataSourceController {

    private final DataSourceService dataSourceService;

    @GetMapping
    public ResponseEntity<ApiResponse<List<DataSourceResponse>>> list() {
        return ResponseEntity.ok(ApiResponse.ok(dataSourceService.listAll()));
    }

    @GetMapping("/{id}")
    public ResponseEntity<ApiResponse<DataSourceResponse>> getById(@PathVariable UUID id) {
        return ResponseEntity.ok(ApiResponse.ok(dataSourceService.getById(id)));
    }

    @PostMapping
    public ResponseEntity<ApiResponse<DataSourceResponse>> create(@Valid @RequestBody DataSourceRequest request) {
        DataSourceResponse created = dataSourceService.create(request);
        return ResponseEntity.status(HttpStatus.CREATED).body(ApiResponse.ok(created, "DataSource created"));
    }

    @PutMapping("/{id}")
    public ResponseEntity<ApiResponse<DataSourceResponse>> update(
            @PathVariable UUID id, @Valid @RequestBody DataSourceRequest request) {
        return ResponseEntity.ok(ApiResponse.ok(dataSourceService.update(id, request)));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<ApiResponse<Void>> delete(@PathVariable UUID id) {
        dataSourceService.delete(id);
        return ResponseEntity.ok(ApiResponse.ok(null, "DataSource deleted"));
    }

    @PostMapping("/{id}/test-connection")
    public ResponseEntity<ApiResponse<Boolean>> testConnection(@PathVariable UUID id) {
        boolean result = dataSourceService.testConnection(id);
        return ResponseEntity.ok(ApiResponse.ok(result, result ? "Connection successful" : "Connection failed"));
    }
}

