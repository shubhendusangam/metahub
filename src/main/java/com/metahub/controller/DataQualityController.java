package com.metahub.controller;

import com.metahub.dto.response.ApiResponse;
import com.metahub.dto.response.DataQualityScoreResponse;
import com.metahub.service.DataQualityService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("/api/v1/quality")
@RequiredArgsConstructor
public class DataQualityController {

    private final DataQualityService qualityService;

    @GetMapping("/scores")
    public ResponseEntity<ApiResponse<List<DataQualityScoreResponse>>> getAllScores() {
        return ResponseEntity.ok(ApiResponse.ok(qualityService.getAllScores()));
    }

    @GetMapping("/scores/{datasetId}")
    public ResponseEntity<ApiResponse<DataQualityScoreResponse>> getScore(@PathVariable UUID datasetId) {
        return ResponseEntity.ok(ApiResponse.ok(
                qualityService.getScoreForDataset(datasetId).orElse(null)));
    }

    @PostMapping("/compute")
    public ResponseEntity<ApiResponse<String>> computeAll() {
        qualityService.computeAllScores();
        return ResponseEntity.ok(ApiResponse.ok("Quality scores computed for all datasets", "Computation complete"));
    }
}

