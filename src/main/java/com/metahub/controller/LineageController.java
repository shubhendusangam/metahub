package com.metahub.controller;

import com.metahub.dto.request.LineageRequest;
import com.metahub.dto.response.ApiResponse;
import com.metahub.dto.response.LineageGraphResponse;
import com.metahub.dto.response.LineageGraphResponse.LineageEdge;
import com.metahub.model.DataLineage;
import com.metahub.service.LineageService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api/v1/lineage")
@RequiredArgsConstructor
public class LineageController {

    private final LineageService lineageService;

    @PostMapping
    public ResponseEntity<ApiResponse<LineageEdge>> addLineage(@Valid @RequestBody LineageRequest request) {
        DataLineage lineage = lineageService.addLineage(request);
        return ResponseEntity.status(HttpStatus.CREATED).body(ApiResponse.ok(toEdge(lineage), "Lineage edge created"));
    }

    @GetMapping("/{datasetId}/upstream")
    public ResponseEntity<ApiResponse<List<LineageEdge>>> getUpstream(@PathVariable UUID datasetId) {
        List<LineageEdge> edges = lineageService.getUpstream(datasetId).stream()
                .map(this::toEdge).collect(Collectors.toList());
        return ResponseEntity.ok(ApiResponse.ok(edges));
    }

    @GetMapping("/{datasetId}/downstream")
    public ResponseEntity<ApiResponse<List<LineageEdge>>> getDownstream(@PathVariable UUID datasetId) {
        List<LineageEdge> edges = lineageService.getDownstream(datasetId).stream()
                .map(this::toEdge).collect(Collectors.toList());
        return ResponseEntity.ok(ApiResponse.ok(edges));
    }

    @GetMapping("/{datasetId}/graph")
    public ResponseEntity<ApiResponse<LineageGraphResponse>> getGraph(@PathVariable UUID datasetId) {
        return ResponseEntity.ok(ApiResponse.ok(lineageService.getLineageGraph(datasetId)));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<ApiResponse<Void>> deleteLineage(@PathVariable UUID id) {
        lineageService.deleteLineage(id);
        return ResponseEntity.ok(ApiResponse.ok(null, "Lineage edge deleted"));
    }

    private LineageEdge toEdge(DataLineage l) {
        return LineageEdge.builder()
                .id(l.getId())
                .sourceId(l.getSourceDataset().getId())
                .targetId(l.getTargetDataset().getId())
                .transformationDescription(l.getTransformationDescription())
                .jobName(l.getJobName())
                .build();
    }
}

