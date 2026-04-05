package com.metahub.dto.response;

import lombok.*;

import java.util.List;
import java.util.UUID;

@Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
public class LineageGraphResponse {

    private List<LineageNode> nodes;
    private List<LineageEdge> edges;

    @Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
    public static class LineageNode {
        private UUID id;
        private String name;
        private String qualifiedName;
        private String type; // "source", "target", "root"
    }

    @Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
    public static class LineageEdge {
        private UUID id;
        private UUID sourceId;
        private UUID targetId;
        private String transformationDescription;
        private String jobName;
    }
}

