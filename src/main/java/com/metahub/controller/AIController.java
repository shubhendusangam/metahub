package com.metahub.controller;

import com.metahub.ai.AIAssistantService;
import com.metahub.ai.AIInsight;
import com.metahub.dto.response.ApiResponse;
import com.metahub.service.DatasetService;
import lombok.*;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.*;

/**
 * REST controller for AI-powered features.
 */
@Slf4j
@RestController
@RequestMapping("/api/v1/ai")
@RequiredArgsConstructor
public class AIController {

    private final AIAssistantService aiAssistantService;
    private final DatasetService datasetService;

    /**
     * Process a natural language query about metadata.
     */
    @PostMapping("/query")
    public ResponseEntity<ApiResponse<AIAssistantService.NLQueryResult>> processQuery(
            @RequestBody QueryRequest request) {
        log.info("Processing NL query: {}", request.getQuery());
        var result = aiAssistantService.processNaturalLanguageQuery(request.getQuery());
        return ResponseEntity.ok(ApiResponse.ok(result));
    }

    /**
     * Get AI-powered insights for a specific dataset.
     */
    @GetMapping("/insights/{datasetId}")
    public ResponseEntity<ApiResponse<List<AIInsight>>> getInsights(
            @PathVariable UUID datasetId) {
        log.info("Generating AI insights for dataset: {}", datasetId);
        var dataset = datasetService.getDatasetEntity(datasetId);
        var insights = aiAssistantService.analyzeDataset(dataset);
        return ResponseEntity.ok(ApiResponse.ok(insights));
    }

    /**
     * Get AI-suggested tags for a dataset.
     */
    @GetMapping("/suggest-tags/{datasetId}")
    public ResponseEntity<ApiResponse<List<AIAssistantService.TagSuggestion>>> suggestTags(
            @PathVariable UUID datasetId) {
        log.info("Generating tag suggestions for dataset: {}", datasetId);
        var dataset = datasetService.getDatasetEntity(datasetId);
        var suggestions = aiAssistantService.suggestTags(dataset);
        return ResponseEntity.ok(ApiResponse.ok(suggestions));
    }

    /**
     * Generate an AI description for a dataset.
     */
    @GetMapping("/generate-description/{datasetId}")
    public ResponseEntity<ApiResponse<DescriptionResponse>> generateDescription(
            @PathVariable UUID datasetId) {
        log.info("Generating AI description for dataset: {}", datasetId);
        var dataset = datasetService.getDatasetEntity(datasetId);
        String description = aiAssistantService.generateDescription(dataset);
        return ResponseEntity.ok(ApiResponse.ok(new DescriptionResponse(description)));
    }

    /**
     * Generate AI descriptions for undocumented columns.
     */
    @GetMapping("/suggest-column-descriptions/{datasetId}")
    public ResponseEntity<ApiResponse<Map<String, String>>> suggestColumnDescriptions(
            @PathVariable UUID datasetId) {
        log.info("Generating column description suggestions for dataset: {}", datasetId);
        var dataset = datasetService.getDatasetEntity(datasetId);
        var suggestions = aiAssistantService.suggestColumnDescriptions(dataset);
        return ResponseEntity.ok(ApiResponse.ok(suggestions));
    }

    /**
     * AI Chat endpoint for conversational interactions.
     */
    @PostMapping("/chat")
    public ResponseEntity<ApiResponse<ChatResponse>> chat(@RequestBody ChatRequest request) {
        log.info("AI Chat: {}", request.getMessage());

        // Process the natural language query
        var nlResult = aiAssistantService.processNaturalLanguageQuery(request.getMessage());

        // Build a conversational response
        ChatResponse response = new ChatResponse();
        response.setIntent(nlResult.getIntent());
        response.setMessage(nlResult.getSuggestedResponse());
        response.setSearchTerms(nlResult.getSearchTerms());
        response.setEntities(nlResult.getEntities());

        // Add helpful suggestions based on intent
        List<String> suggestions = new ArrayList<>();
        switch (nlResult.getIntent()) {
            case "SEARCH":
                suggestions.add("Try searching in the Catalog");
                suggestions.add("Use the Search page for full-text search");
                break;
            case "LINEAGE":
                suggestions.add("View the Lineage graph for data flow");
                suggestions.add("Check upstream and downstream dependencies");
                break;
            case "QUALITY":
                suggestions.add("Check the Quality dashboard for scores");
                suggestions.add("Look for datasets with low freshness");
                break;
            case "COMPLIANCE":
                suggestions.add("Filter datasets by PII or GDPR tags");
                suggestions.add("Review the Governance policies");
                break;
            default:
                suggestions.add("Browse the Data Catalog");
                suggestions.add("Search for datasets by name");
                suggestions.add("Check the Glossary for definitions");
        }
        response.setSuggestions(suggestions);

        return ResponseEntity.ok(ApiResponse.ok(response));
    }

    // --- Request/Response DTOs ---

    @Getter @Setter @NoArgsConstructor @AllArgsConstructor
    public static class QueryRequest {
        private String query;
    }

    @Getter @Setter @NoArgsConstructor @AllArgsConstructor
    public static class DescriptionResponse {
        private String description;
    }

    @Getter @Setter @NoArgsConstructor @AllArgsConstructor
    public static class ChatRequest {
        private String message;
        private String conversationId;
    }

    @Getter @Setter @NoArgsConstructor
    public static class ChatResponse {
        private String intent;
        private String message;
        private List<String> searchTerms;
        private Map<String, String> entities;
        private List<String> suggestions;
    }
}

