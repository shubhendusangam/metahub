package com.metahub.service;

import com.metahub.dto.request.LineageRequest;
import com.metahub.dto.response.LineageGraphResponse;
import com.metahub.dto.response.LineageGraphResponse.LineageEdge;
import com.metahub.dto.response.LineageGraphResponse.LineageNode;
import com.metahub.exception.ResourceNotFoundException;
import com.metahub.model.DataLineage;
import com.metahub.model.Dataset;
import com.metahub.repository.DataLineageRepository;
import com.metahub.repository.DatasetRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;
import java.util.stream.Collectors;

@Slf4j
@Service
@RequiredArgsConstructor
public class LineageService {

    private final DataLineageRepository lineageRepository;
    private final DatasetRepository datasetRepository;

    @Transactional
    public DataLineage addLineage(LineageRequest request) {
        Dataset source = datasetRepository.findById(request.getSourceDatasetId())
                .orElseThrow(() -> new ResourceNotFoundException("Dataset", "id", request.getSourceDatasetId()));
        Dataset target = datasetRepository.findById(request.getTargetDatasetId())
                .orElseThrow(() -> new ResourceNotFoundException("Dataset", "id", request.getTargetDatasetId()));

        DataLineage lineage = DataLineage.builder()
                .sourceDataset(source)
                .targetDataset(target)
                .transformationDescription(request.getTransformationDescription())
                .jobName(request.getJobName())
                .build();

        return lineageRepository.save(lineage);
    }

    @Transactional(readOnly = true)
    public List<DataLineage> getUpstream(UUID datasetId) {
        return lineageRepository.findByTargetDatasetId(datasetId);
    }

    @Transactional(readOnly = true)
    public List<DataLineage> getDownstream(UUID datasetId) {
        return lineageRepository.findBySourceDatasetId(datasetId);
    }

    @Transactional(readOnly = true)
    public LineageGraphResponse getLineageGraph(UUID datasetId) {
        Set<UUID> visitedDatasets = new HashSet<>();
        Set<UUID> visitedEdgeIds = new HashSet<>();
        List<DataLineage> allEdges = new ArrayList<>();

        // BFS in both directions
        Queue<UUID> queue = new LinkedList<>();
        queue.add(datasetId);
        visitedDatasets.add(datasetId);

        while (!queue.isEmpty()) {
            UUID currentId = queue.poll();
            List<DataLineage> edges = lineageRepository.findBySourceDatasetIdOrTargetDatasetId(currentId, currentId);

            for (DataLineage edge : edges) {
                if (visitedEdgeIds.add(edge.getId())) {
                    allEdges.add(edge);
                }
                UUID sourceId = edge.getSourceDataset().getId();
                UUID targetId = edge.getTargetDataset().getId();

                if (!visitedDatasets.contains(sourceId)) {
                    visitedDatasets.add(sourceId);
                    queue.add(sourceId);
                }
                if (!visitedDatasets.contains(targetId)) {
                    visitedDatasets.add(targetId);
                    queue.add(targetId);
                }
            }
        }

        // Build response
        List<LineageNode> nodes = visitedDatasets.stream()
                .map(id -> {
                    Dataset ds = datasetRepository.findById(id).orElse(null);
                    if (ds == null) return null;
                    return LineageNode.builder()
                            .id(ds.getId())
                            .name(ds.getName())
                            .qualifiedName(ds.getQualifiedName())
                            .type(ds.getId().equals(datasetId) ? "root" : "related")
                            .build();
                })
                .filter(Objects::nonNull)
                .collect(Collectors.toList());

        List<LineageEdge> edges = allEdges.stream()
                .map(e -> LineageEdge.builder()
                        .id(e.getId())
                        .sourceId(e.getSourceDataset().getId())
                        .targetId(e.getTargetDataset().getId())
                        .transformationDescription(e.getTransformationDescription())
                        .jobName(e.getJobName())
                        .build())
                .collect(Collectors.toList());

        return LineageGraphResponse.builder().nodes(nodes).edges(edges).build();
    }

    @Transactional
    public void deleteLineage(UUID id) {
        lineageRepository.deleteById(id);
    }
}

