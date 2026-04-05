package com.metahub.controller;

import com.metahub.dto.request.DatasetRequest;
import com.metahub.dto.response.ApiResponse;
import com.metahub.dto.response.DatasetResponse;
import com.metahub.dto.response.PagedResponse;
import com.metahub.service.DatasetService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Set;
import java.util.UUID;

@RestController
@RequestMapping("/api/v1/datasets")
@RequiredArgsConstructor
public class DatasetController {

    private final DatasetService datasetService;

    @GetMapping
    public ResponseEntity<ApiResponse<PagedResponse<DatasetResponse>>> list(
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "20") int size) {
        return ResponseEntity.ok(ApiResponse.ok(datasetService.listDatasets(page, size)));
    }

    @GetMapping("/{id}")
    public ResponseEntity<ApiResponse<DatasetResponse>> getById(@PathVariable UUID id) {
        return ResponseEntity.ok(ApiResponse.ok(datasetService.getDataset(id)));
    }

    @PostMapping
    public ResponseEntity<ApiResponse<DatasetResponse>> create(@Valid @RequestBody DatasetRequest request) {
        DatasetResponse created = datasetService.createDataset(request);
        return ResponseEntity.status(HttpStatus.CREATED).body(ApiResponse.ok(created, "Dataset created"));
    }

    @PutMapping("/{id}")
    public ResponseEntity<ApiResponse<DatasetResponse>> update(
            @PathVariable UUID id, @Valid @RequestBody DatasetRequest request) {
        return ResponseEntity.ok(ApiResponse.ok(datasetService.updateDataset(id, request)));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<ApiResponse<Void>> delete(@PathVariable UUID id) {
        datasetService.deleteDataset(id);
        return ResponseEntity.ok(ApiResponse.ok(null, "Dataset deleted"));
    }

    @PostMapping("/{id}/tags")
    public ResponseEntity<ApiResponse<DatasetResponse>> addTags(
            @PathVariable UUID id, @RequestBody Set<String> tagNames) {
        return ResponseEntity.ok(ApiResponse.ok(datasetService.addTags(id, tagNames)));
    }
}

