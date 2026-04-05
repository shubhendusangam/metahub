package com.metahub.controller;

import com.metahub.dto.response.ApiResponse;
import com.metahub.model.Dataset;
import com.metahub.service.ingestion.IngestionOrchestrator;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("/api/v1/ingestion")
@RequiredArgsConstructor
public class IngestionController {

    private final IngestionOrchestrator orchestrator;

    @PostMapping("/run/{dataSourceId}")
    public ResponseEntity<ApiResponse<Integer>> runIngestion(@PathVariable UUID dataSourceId) {
        List<Dataset> ingested = orchestrator.runIngestion(dataSourceId);
        return ResponseEntity.ok(ApiResponse.ok(ingested.size(),
                "Ingestion complete. Processed " + ingested.size() + " datasets."));
    }
}

