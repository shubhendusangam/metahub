package com.metahub.ai;

import lombok.*;

/**
 * Represents an AI-generated insight or recommendation.
 */
@Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
public class AIInsight {
    private String type;        // DESCRIPTION, TAG_SUGGESTION, QUALITY_ISSUE, LINEAGE_TIP, GOVERNANCE_RISK
    private String title;
    private String content;
    private String severity;    // INFO, WARNING, CRITICAL
    private double confidence;  // 0.0 - 1.0
}

