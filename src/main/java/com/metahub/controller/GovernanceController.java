package com.metahub.controller;

import com.metahub.dto.request.GovernancePolicyRequest;
import com.metahub.dto.response.ApiResponse;
import com.metahub.dto.response.GovernancePolicyResponse;
import com.metahub.service.GovernanceService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Set;
import java.util.UUID;

@RestController
@RequestMapping("/api/v1/governance/policies")
@RequiredArgsConstructor
public class GovernanceController {

    private final GovernanceService governanceService;

    @GetMapping
    public ResponseEntity<ApiResponse<List<GovernancePolicyResponse>>> list() {
        return ResponseEntity.ok(ApiResponse.ok(governanceService.listAll()));
    }

    @GetMapping("/{id}")
    public ResponseEntity<ApiResponse<GovernancePolicyResponse>> getById(@PathVariable UUID id) {
        return ResponseEntity.ok(ApiResponse.ok(governanceService.getById(id)));
    }

    @PostMapping
    public ResponseEntity<ApiResponse<GovernancePolicyResponse>> create(
            @Valid @RequestBody GovernancePolicyRequest request) {
        GovernancePolicyResponse created = governanceService.create(request);
        return ResponseEntity.status(HttpStatus.CREATED).body(ApiResponse.ok(created, "Policy created"));
    }

    @PutMapping("/{id}")
    public ResponseEntity<ApiResponse<GovernancePolicyResponse>> update(
            @PathVariable UUID id, @Valid @RequestBody GovernancePolicyRequest request) {
        return ResponseEntity.ok(ApiResponse.ok(governanceService.update(id, request)));
    }

    @PostMapping("/{id}/attach")
    public ResponseEntity<ApiResponse<GovernancePolicyResponse>> attachDatasets(
            @PathVariable UUID id, @RequestBody Set<UUID> datasetIds) {
        return ResponseEntity.ok(ApiResponse.ok(governanceService.attachDatasets(id, datasetIds)));
    }

    @PostMapping("/{id}/detach")
    public ResponseEntity<ApiResponse<GovernancePolicyResponse>> detachDatasets(
            @PathVariable UUID id, @RequestBody Set<UUID> datasetIds) {
        return ResponseEntity.ok(ApiResponse.ok(governanceService.detachDatasets(id, datasetIds)));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<ApiResponse<Void>> delete(@PathVariable UUID id) {
        governanceService.delete(id);
        return ResponseEntity.ok(ApiResponse.ok(null, "Policy deleted"));
    }
}

