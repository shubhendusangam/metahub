package com.metahub.ai;

import com.metahub.model.ColumnDefinition;
import com.metahub.model.Dataset;
import lombok.*;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.*;
import java.util.regex.Pattern;
import java.util.stream.Collectors;

/**
 * AI-powered assistant service providing intelligent metadata insights.
 * Implements rule-based NLP for natural language queries, description generation,
 * and smart recommendations. Can be extended with LLM integration.
 */
@Slf4j
@Service
public class AIAssistantService {

    // Patterns for sensitive data detection
    private static final Map<String, List<Pattern>> SENSITIVITY_PATTERNS = Map.of(
        "PII_HIGH", List.of(
            Pattern.compile("(?i)(ssn|social_security|passport|driver_license|national_id)"),
            Pattern.compile("(?i)(credit_card|card_number|cvv|bank_account)"),
            Pattern.compile("(?i)(password|secret|token|api_key|private_key)")
        ),
        "PII_MEDIUM", List.of(
            Pattern.compile("(?i)(email|phone|mobile|fax)"),
            Pattern.compile("(?i)(address|street|city|zip|postal)"),
            Pattern.compile("(?i)(first_name|last_name|full_name|dob|birth)")
        ),
        "PII_LOW", List.of(
            Pattern.compile("(?i)(age|gender|ethnicity|nationality)"),
            Pattern.compile("(?i)(ip_address|user_agent|device_id)")
        ),
        "FINANCIAL", List.of(
            Pattern.compile("(?i)(salary|income|revenue|profit|cost|price|amount|balance)"),
            Pattern.compile("(?i)(tax|deduction|gross|net|payment)")
        ),
        "HEALTHCARE", List.of(
            Pattern.compile("(?i)(patient|diagnosis|prescription|medication|treatment)"),
            Pattern.compile("(?i)(medical|health|symptom|allergy|blood)")
        )
    );

    // Common data patterns for type inference
    private static final Map<String, Pattern> DATA_PATTERNS = Map.of(
        "identifier", Pattern.compile("(?i)(^id$|_id$|_key$|_code$|uuid|guid)"),
        "timestamp", Pattern.compile("(?i)(created|updated|modified|deleted|timestamp|_at$|_date$|_time$)"),
        "boolean", Pattern.compile("(?i)(^is_|^has_|^can_|^should_|^was_|_flag$|_enabled$|_active$)"),
        "amount", Pattern.compile("(?i)(amount|total|sum|count|quantity|price|cost|rate)"),
        "status", Pattern.compile("(?i)(status|state|phase|stage|type|category)")
    );

    /**
     * Generate an AI-powered description for a dataset based on its schema.
     */
    public String generateDescription(Dataset dataset) {
        StringBuilder desc = new StringBuilder();
        
        // Analyze table name patterns
        String tableName = dataset.getName().toLowerCase();
        String tableType = inferTableType(tableName);
        
        desc.append(tableType);
        
        // Analyze columns
        if (dataset.getSchemas() != null && !dataset.getSchemas().isEmpty()) {
            var columns = dataset.getSchemas().get(0).getColumns();
            if (columns != null && !columns.isEmpty()) {
                List<String> keyColumns = new ArrayList<>();
                List<String> sensitiveFields = new ArrayList<>();
                List<String> timestampFields = new ArrayList<>();
                
                for (ColumnDefinition col : columns) {
                    String colName = col.getName().toLowerCase();
                    if (col.getIsPrimaryKey() || colName.endsWith("_id") || colName.equals("id")) {
                        keyColumns.add(col.getName());
                    }
                    if (isSensitive(colName)) {
                        sensitiveFields.add(col.getName());
                    }
                    if (DATA_PATTERNS.get("timestamp").matcher(colName).find()) {
                        timestampFields.add(col.getName());
                    }
                }
                
                if (!sensitiveFields.isEmpty()) {
                    desc.append(" Contains sensitive fields (").append(String.join(", ", sensitiveFields.subList(0, Math.min(3, sensitiveFields.size()))));
                    if (sensitiveFields.size() > 3) desc.append(", ...");
                    desc.append(").");
                }
                
                if (!timestampFields.isEmpty()) {
                    desc.append(" Tracks temporal data via ").append(timestampFields.get(0)).append(".");
                }
                
                desc.append(" Schema has ").append(columns.size()).append(" columns.");
            }
        }
        
        return desc.toString().trim();
    }

    /**
     * Analyze a dataset and generate AI insights.
     */
    public List<AIInsight> analyzeDataset(Dataset dataset) {
        List<AIInsight> insights = new ArrayList<>();
        
        // Sensitivity analysis
        insights.addAll(analyzeSensitivity(dataset));
        
        // Quality recommendations
        insights.addAll(analyzeQuality(dataset));
        
        // Governance recommendations
        insights.addAll(analyzeGovernance(dataset));
        
        // Schema recommendations
        insights.addAll(analyzeSchema(dataset));
        
        return insights;
    }

    /**
     * Process a natural language query about metadata.
     */
    public NLQueryResult processNaturalLanguageQuery(String query) {
        String lowerQuery = query.toLowerCase();
        NLQueryResult result = new NLQueryResult();
        
        // Intent detection
        if (lowerQuery.contains("find") || lowerQuery.contains("search") || lowerQuery.contains("show") || lowerQuery.contains("list")) {
            result.setIntent("SEARCH");
            result.setSearchTerms(extractSearchTerms(lowerQuery));
        } else if (lowerQuery.contains("what is") || lowerQuery.contains("explain") || lowerQuery.contains("describe")) {
            result.setIntent("EXPLAIN");
            result.setSearchTerms(extractSearchTerms(lowerQuery));
        } else if (lowerQuery.contains("how many") || lowerQuery.contains("count")) {
            result.setIntent("COUNT");
        } else if (lowerQuery.contains("who owns") || lowerQuery.contains("owner of")) {
            result.setIntent("OWNERSHIP");
            result.setSearchTerms(extractSearchTerms(lowerQuery));
        } else if (lowerQuery.contains("lineage") || lowerQuery.contains("upstream") || lowerQuery.contains("downstream")) {
            result.setIntent("LINEAGE");
            result.setSearchTerms(extractSearchTerms(lowerQuery));
        } else if (lowerQuery.contains("quality") || lowerQuery.contains("health")) {
            result.setIntent("QUALITY");
            result.setSearchTerms(extractSearchTerms(lowerQuery));
        } else if (lowerQuery.contains("pii") || lowerQuery.contains("sensitive") || lowerQuery.contains("gdpr")) {
            result.setIntent("COMPLIANCE");
            result.setFilters(Map.of("tags", List.of("PII", "GDPR", "Confidential")));
        } else {
            result.setIntent("GENERAL");
            result.setSearchTerms(extractSearchTerms(lowerQuery));
        }
        
        // Entity extraction
        result.setEntities(extractEntities(lowerQuery));
        
        // Generate response suggestion
        result.setSuggestedResponse(generateSuggestedResponse(result));
        
        return result;
    }

    /**
     * Generate smart tag suggestions based on dataset content.
     */
    public List<TagSuggestion> suggestTags(Dataset dataset) {
        List<TagSuggestion> suggestions = new ArrayList<>();
        StringBuilder content = new StringBuilder();
        
        content.append(dataset.getName()).append(" ");
        if (dataset.getDescription() != null) content.append(dataset.getDescription()).append(" ");
        
        if (dataset.getSchemas() != null) {
            dataset.getSchemas().forEach(schema -> 
                schema.getColumns().forEach(col -> {
                    content.append(col.getName()).append(" ");
                    if (col.getDescription() != null) content.append(col.getDescription()).append(" ");
                })
            );
        }
        
        String text = content.toString().toLowerCase();
        
        // Check sensitivity patterns
        for (Map.Entry<String, List<Pattern>> entry : SENSITIVITY_PATTERNS.entrySet()) {
            for (Pattern pattern : entry.getValue()) {
                if (pattern.matcher(text).find()) {
                    String tag = mapSensitivityToTag(entry.getKey());
                    double confidence = calculateConfidence(text, pattern);
                    suggestions.add(new TagSuggestion(tag, entry.getKey(), confidence, 
                        "Detected " + entry.getKey() + " pattern in dataset metadata"));
                    break;
                }
            }
        }
        
        // Check domain patterns
        if (Pattern.compile("(?i)(customer|client|user|member|subscriber)").matcher(text).find()) {
            suggestions.add(new TagSuggestion("Customer", "Domain", 0.85, "Contains customer-related entities"));
        }
        if (Pattern.compile("(?i)(order|transaction|purchase|sale|invoice)").matcher(text).find()) {
            suggestions.add(new TagSuggestion("Financial", "Domain", 0.8, "Contains transactional data"));
        }
        if (Pattern.compile("(?i)(employee|staff|workforce|hr|payroll)").matcher(text).find()) {
            suggestions.add(new TagSuggestion("HR", "Domain", 0.85, "Contains HR/workforce data"));
        }
        if (Pattern.compile("(?i)(product|catalog|inventory|sku|item)").matcher(text).find()) {
            suggestions.add(new TagSuggestion("Product", "Domain", 0.8, "Contains product catalog data"));
        }
        if (Pattern.compile("(?i)(log|event|audit|trace|metric)").matcher(text).find()) {
            suggestions.add(new TagSuggestion("Engineering", "Domain", 0.75, "Contains operational/log data"));
        }
        
        // Check lifecycle patterns
        if (dataset.getName().toLowerCase().contains("raw") || dataset.getName().toLowerCase().contains("staging")) {
            suggestions.add(new TagSuggestion("Development", "Environment", 0.7, "Appears to be raw/staging data"));
        }
        if (dataset.getName().toLowerCase().contains("fact_") || dataset.getName().toLowerCase().contains("dim_")) {
            suggestions.add(new TagSuggestion("Production", "Environment", 0.85, "Star schema naming convention detected"));
            suggestions.add(new TagSuggestion("Stable", "Lifecycle", 0.8, "Analytical table pattern suggests stable schema"));
        }
        
        // Sort by confidence
        suggestions.sort((a, b) -> Double.compare(b.getConfidence(), a.getConfidence()));
        
        return suggestions;
    }

    /**
     * Generate column description suggestions.
     */
    public Map<String, String> suggestColumnDescriptions(Dataset dataset) {
        Map<String, String> suggestions = new HashMap<>();
        
        if (dataset.getSchemas() == null || dataset.getSchemas().isEmpty()) {
            return suggestions;
        }
        
        for (ColumnDefinition col : dataset.getSchemas().get(0).getColumns()) {
            if (col.getDescription() == null || col.getDescription().isBlank()) {
                suggestions.put(col.getName(), generateColumnDescription(col));
            }
        }
        
        return suggestions;
    }

    // --- Private helper methods ---

    private String inferTableType(String tableName) {
        if (tableName.startsWith("fact_")) {
            return "Fact table containing quantitative business metrics.";
        } else if (tableName.startsWith("dim_")) {
            return "Dimension table providing descriptive attributes for analysis.";
        } else if (tableName.startsWith("raw_")) {
            return "Raw data table containing unprocessed source data.";
        } else if (tableName.startsWith("stg_") || tableName.startsWith("staging_")) {
            return "Staging table for intermediate data transformations.";
        } else if (tableName.endsWith("_log") || tableName.endsWith("_logs")) {
            return "Log table capturing system or application events.";
        } else if (tableName.endsWith("_audit")) {
            return "Audit table tracking changes for compliance purposes.";
        } else if (tableName.endsWith("_history")) {
            return "Historical table preserving record versions over time.";
        } else if (tableName.contains("customer") || tableName.contains("user")) {
            return "Entity table storing customer/user master data.";
        } else if (tableName.contains("order") || tableName.contains("transaction")) {
            return "Transaction table recording business events.";
        } else if (tableName.contains("product") || tableName.contains("item")) {
            return "Product/item master data table.";
        } else {
            return "Data table containing " + tableName.replace("_", " ") + " information.";
        }
    }

    private boolean isSensitive(String columnName) {
        for (List<Pattern> patterns : SENSITIVITY_PATTERNS.values()) {
            for (Pattern pattern : patterns) {
                if (pattern.matcher(columnName).find()) {
                    return true;
                }
            }
        }
        return false;
    }

    private List<AIInsight> analyzeSensitivity(Dataset dataset) {
        List<AIInsight> insights = new ArrayList<>();
        
        if (dataset.getSchemas() == null || dataset.getSchemas().isEmpty()) {
            return insights;
        }
        
        List<String> highSensitivity = new ArrayList<>();
        List<String> mediumSensitivity = new ArrayList<>();
        
        for (ColumnDefinition col : dataset.getSchemas().get(0).getColumns()) {
            String colName = col.getName().toLowerCase();
            for (Pattern p : SENSITIVITY_PATTERNS.get("PII_HIGH")) {
                if (p.matcher(colName).find()) {
                    highSensitivity.add(col.getName());
                    break;
                }
            }
            for (Pattern p : SENSITIVITY_PATTERNS.get("PII_MEDIUM")) {
                if (p.matcher(colName).find() && !highSensitivity.contains(col.getName())) {
                    mediumSensitivity.add(col.getName());
                    break;
                }
            }
        }
        
        if (!highSensitivity.isEmpty()) {
            insights.add(AIInsight.builder()
                .type("GOVERNANCE_RISK")
                .title("High Sensitivity Data Detected")
                .content("Columns with highly sensitive data: " + String.join(", ", highSensitivity) + 
                         ". Ensure encryption at rest and strict access controls.")
                .severity("CRITICAL")
                .confidence(0.95)
                .build());
        }
        
        if (!mediumSensitivity.isEmpty()) {
            insights.add(AIInsight.builder()
                .type("GOVERNANCE_RISK")
                .title("PII Data Detected")
                .content("Columns containing PII: " + String.join(", ", mediumSensitivity) + 
                         ". Consider applying PII and GDPR tags.")
                .severity("WARNING")
                .confidence(0.85)
                .build());
        }
        
        return insights;
    }

    private List<AIInsight> analyzeQuality(Dataset dataset) {
        List<AIInsight> insights = new ArrayList<>();
        
        // Check for missing descriptions
        if (dataset.getDescription() == null || dataset.getDescription().isBlank()) {
            insights.add(AIInsight.builder()
                .type("QUALITY_ISSUE")
                .title("Missing Dataset Description")
                .content("This dataset lacks a description. Adding a clear description improves discoverability and understanding.")
                .severity("WARNING")
                .confidence(1.0)
                .build());
        }
        
        // Check for undocumented columns
        if (dataset.getSchemas() != null && !dataset.getSchemas().isEmpty()) {
            long undocumented = dataset.getSchemas().get(0).getColumns().stream()
                .filter(c -> c.getDescription() == null || c.getDescription().isBlank())
                .count();
            long total = dataset.getSchemas().get(0).getColumns().size();
            
            if (undocumented > 0) {
                double pct = (undocumented * 100.0) / total;
                insights.add(AIInsight.builder()
                    .type("QUALITY_ISSUE")
                    .title("Undocumented Columns")
                    .content(String.format("%d of %d columns (%.0f%%) lack descriptions. " +
                            "Well-documented columns improve data literacy.", undocumented, total, pct))
                    .severity(pct > 50 ? "WARNING" : "INFO")
                    .confidence(1.0)
                    .build());
            }
        }
        
        return insights;
    }

    private List<AIInsight> analyzeGovernance(Dataset dataset) {
        List<AIInsight> insights = new ArrayList<>();
        
        // Check for missing tags
        if (dataset.getTags() == null || dataset.getTags().isEmpty()) {
            insights.add(AIInsight.builder()
                .type("GOVERNANCE_RISK")
                .title("No Tags Applied")
                .content("This dataset has no tags. Apply appropriate classification and domain tags for better governance.")
                .severity("WARNING")
                .confidence(1.0)
                .build());
        }
        
        // Check for missing owner
        if (dataset.getOwner() == null) {
            insights.add(AIInsight.builder()
                .type("GOVERNANCE_RISK")
                .title("No Data Owner Assigned")
                .content("This dataset has no designated owner. Assign a data steward for accountability.")
                .severity("WARNING")
                .confidence(1.0)
                .build());
        }
        
        return insights;
    }

    private List<AIInsight> analyzeSchema(Dataset dataset) {
        List<AIInsight> insights = new ArrayList<>();
        
        if (dataset.getSchemas() == null || dataset.getSchemas().isEmpty()) {
            insights.add(AIInsight.builder()
                .type("QUALITY_ISSUE")
                .title("No Schema Defined")
                .content("This dataset has no schema information. Import schema metadata for better documentation.")
                .severity("WARNING")
                .confidence(1.0)
                .build());
            return insights;
        }
        
        var columns = dataset.getSchemas().get(0).getColumns();
        
        // Check for primary key
        boolean hasPK = columns.stream().anyMatch(ColumnDefinition::getIsPrimaryKey);
        if (!hasPK) {
            insights.add(AIInsight.builder()
                .type("QUALITY_ISSUE")
                .title("No Primary Key Defined")
                .content("Consider defining a primary key column for data integrity and join optimization.")
                .severity("INFO")
                .confidence(0.8)
                .build());
        }
        
        // Check for timestamp columns (audit trails)
        boolean hasCreatedAt = columns.stream().anyMatch(c -> 
            c.getName().toLowerCase().contains("created"));
        boolean hasUpdatedAt = columns.stream().anyMatch(c -> 
            c.getName().toLowerCase().contains("updated") || c.getName().toLowerCase().contains("modified"));
        
        if (!hasCreatedAt && !hasUpdatedAt) {
            insights.add(AIInsight.builder()
                .type("LINEAGE_TIP")
                .title("No Audit Timestamps")
                .content("Consider adding created_at/updated_at columns for change tracking and incremental processing.")
                .severity("INFO")
                .confidence(0.7)
                .build());
        }
        
        return insights;
    }

    private String generateColumnDescription(ColumnDefinition col) {
        String name = col.getName().toLowerCase();
        String dataType = col.getDataType() != null ? col.getDataType().name() : "";

        // Check common patterns
        if (name.equals("id") || name.endsWith("_id")) {
            return col.getIsPrimaryKey() ? "Primary key identifier" : "Foreign key reference";
        }
        if (DATA_PATTERNS.get("timestamp").matcher(name).find()) {
            if (name.contains("created")) return "Timestamp when the record was created";
            if (name.contains("updated") || name.contains("modified")) return "Timestamp when the record was last updated";
            if (name.contains("deleted")) return "Timestamp when the record was soft-deleted (if applicable)";
            return "Timestamp field for temporal tracking";
        }
        if (DATA_PATTERNS.get("boolean").matcher(name).find()) {
            return "Boolean flag: " + name.replace("_", " ").replace("is ", "indicates if ");
        }
        if (DATA_PATTERNS.get("status").matcher(name).find()) {
            return "Status/state indicator for the record";
        }
        if (DATA_PATTERNS.get("amount").matcher(name).find()) {
            return "Numeric " + name.replace("_", " ") + " value";
        }
        if (name.contains("email")) return "Email address (PII)";
        if (name.contains("phone")) return "Phone number (PII)";
        if (name.contains("name")) return "Name field (may contain PII)";
        if (name.contains("address")) return "Address information (PII)";
        
        // Default: humanize the column name
        return capitalize(name.replace("_", " "));
    }

    private List<String> extractSearchTerms(String query) {
        // Remove common stop words and extract meaningful terms
        String[] stopWords = {"find", "search", "show", "list", "what", "is", "the", "a", "an", "for", 
                              "all", "with", "that", "have", "has", "are", "me", "my", "can", "you"};
        Set<String> stopSet = Set.of(stopWords);
        
        return Arrays.stream(query.toLowerCase().split("\\s+"))
            .filter(w -> !stopSet.contains(w) && w.length() > 2)
            .collect(Collectors.toList());
    }

    private Map<String, String> extractEntities(String query) {
        Map<String, String> entities = new HashMap<>();
        
        // Extract table/dataset names (words with underscores or qualified names)
        Pattern tablePattern = Pattern.compile("\\b([a-z_]+\\.[a-z_]+|[a-z]+_[a-z_]+)\\b");
        var matcher = tablePattern.matcher(query.toLowerCase());
        while (matcher.find()) {
            entities.put("table", matcher.group(1));
        }
        
        // Extract tag mentions
        String[] knownTags = {"pii", "gdpr", "hipaa", "financial", "customer", "production", "deprecated"};
        for (String tag : knownTags) {
            if (query.toLowerCase().contains(tag)) {
                entities.put("tag", tag.toUpperCase());
            }
        }
        
        return entities;
    }

    private String generateSuggestedResponse(NLQueryResult result) {
        switch (result.getIntent()) {
            case "SEARCH":
                return "I'll search for datasets matching: " + String.join(", ", result.getSearchTerms());
            case "EXPLAIN":
                return "Let me explain the dataset/term you're asking about.";
            case "COUNT":
                return "I'll count the matching records for you.";
            case "OWNERSHIP":
                return "I'll find the owner information for that dataset.";
            case "LINEAGE":
                return "I'll show you the data lineage (upstream/downstream dependencies).";
            case "QUALITY":
                return "I'll check the data quality scores for matching datasets.";
            case "COMPLIANCE":
                return "I'll find datasets with compliance-related tags (PII, GDPR, etc.).";
            default:
                return "I'll try to help you find what you're looking for.";
        }
    }

    private String mapSensitivityToTag(String sensitivityLevel) {
        switch (sensitivityLevel) {
            case "PII_HIGH": return "Restricted";
            case "PII_MEDIUM": return "PII";
            case "PII_LOW": return "Internal";
            case "FINANCIAL": return "Financial";
            case "HEALTHCARE": return "PHI";
            default: return "Internal";
        }
    }

    private double calculateConfidence(String text, Pattern pattern) {
        var matcher = pattern.matcher(text);
        int matches = 0;
        while (matcher.find()) matches++;
        return Math.min(0.5 + (matches * 0.1), 0.95);
    }

    private String capitalize(String s) {
        if (s == null || s.isEmpty()) return s;
        return Character.toUpperCase(s.charAt(0)) + s.substring(1);
    }

    // --- Inner classes ---

    @Getter @Setter @NoArgsConstructor @AllArgsConstructor
    public static class NLQueryResult {
        private String intent;
        private List<String> searchTerms = new ArrayList<>();
        private Map<String, String> entities = new HashMap<>();
        private Map<String, List<String>> filters = new HashMap<>();
        private String suggestedResponse;
    }

    @Getter @Setter @NoArgsConstructor @AllArgsConstructor
    public static class TagSuggestion {
        private String tagName;
        private String category;
        private double confidence;
        private String reason;
    }
}

