package com.metahub.ai;

import java.util.List;
import java.util.Map;
import java.util.regex.Pattern;

/**
 * Constants for AI pattern matching and sensitivity detection.
 * Centralized location for all AI-related patterns.
 */
public final class AIPatterns {

    private AIPatterns() {
        // Constants class - prevent instantiation
    }

    // ========== Sensitivity Patterns ==========

    public static final Map<SensitivityLevel, List<Pattern>> SENSITIVITY_PATTERNS = Map.of(
        SensitivityLevel.PII_HIGH, List.of(
            Pattern.compile("(?i)(ssn|social_security|passport|driver_license|national_id)"),
            Pattern.compile("(?i)(credit_card|card_number|cvv|bank_account)"),
            Pattern.compile("(?i)(password|secret|token|api_key|private_key)")
        ),
        SensitivityLevel.PII_MEDIUM, List.of(
            Pattern.compile("(?i)(email|phone|mobile|fax)"),
            Pattern.compile("(?i)(address|street|city|zip|postal)"),
            Pattern.compile("(?i)(first_name|last_name|full_name|dob|birth)")
        ),
        SensitivityLevel.PII_LOW, List.of(
            Pattern.compile("(?i)(age|gender|ethnicity|nationality)"),
            Pattern.compile("(?i)(ip_address|user_agent|device_id)")
        ),
        SensitivityLevel.FINANCIAL, List.of(
            Pattern.compile("(?i)(salary|income|revenue|profit|cost|price|amount|balance)"),
            Pattern.compile("(?i)(tax|deduction|gross|net|payment)")
        ),
        SensitivityLevel.HEALTHCARE, List.of(
            Pattern.compile("(?i)(patient|diagnosis|prescription|medication|treatment)"),
            Pattern.compile("(?i)(medical|health|symptom|allergy|blood)")
        )
    );

    // ========== Data Type Patterns ==========

    public static final Pattern IDENTIFIER_PATTERN =
        Pattern.compile("(?i)(^id$|_id$|_key$|_code$|uuid|guid)");

    public static final Pattern TIMESTAMP_PATTERN =
        Pattern.compile("(?i)(created|updated|modified|deleted|timestamp|_at$|_date$|_time$)");

    public static final Pattern BOOLEAN_PATTERN =
        Pattern.compile("(?i)(^is_|^has_|^can_|^should_|^was_|_flag$|_enabled$|_active$)");

    public static final Pattern AMOUNT_PATTERN =
        Pattern.compile("(?i)(amount|total|sum|count|quantity|price|cost|rate)");

    public static final Pattern STATUS_PATTERN =
        Pattern.compile("(?i)(status|state|phase|stage|type|category)");

    // ========== Domain Patterns ==========

    public static final Pattern CUSTOMER_PATTERN =
        Pattern.compile("(?i)(customer|client|user|member|subscriber)");

    public static final Pattern FINANCIAL_DOMAIN_PATTERN =
        Pattern.compile("(?i)(order|transaction|purchase|sale|invoice)");

    public static final Pattern HR_PATTERN =
        Pattern.compile("(?i)(employee|staff|workforce|hr|payroll)");

    public static final Pattern PRODUCT_PATTERN =
        Pattern.compile("(?i)(product|catalog|inventory|sku|item)");

    public static final Pattern ENGINEERING_PATTERN =
        Pattern.compile("(?i)(log|event|audit|trace|metric)");

    // ========== Table Name Patterns ==========

    public static final Pattern TABLE_NAME_PATTERN =
        Pattern.compile("\\b([a-z_]+\\.[a-z_]+|[a-z]+_[a-z_]+)\\b");

    // ========== Known Tags ==========

    public static final String[] KNOWN_TAGS = {
        "pii", "gdpr", "hipaa", "financial", "customer", "production", "deprecated"
    };

    // ========== Sensitivity Level Enum ==========

    public enum SensitivityLevel {
        PII_HIGH("Restricted"),
        PII_MEDIUM("PII"),
        PII_LOW("Internal"),
        FINANCIAL("Financial"),
        HEALTHCARE("PHI");

        private final String tagName;

        SensitivityLevel(String tagName) {
            this.tagName = tagName;
        }

        public String getTagName() {
            return tagName;
        }
    }

    // ========== Helper Methods ==========

    /**
     * Check if a column name matches any sensitivity pattern.
     */
    public static boolean isSensitive(String columnName) {
        for (List<Pattern> patterns : SENSITIVITY_PATTERNS.values()) {
            for (Pattern pattern : patterns) {
                if (pattern.matcher(columnName).find()) {
                    return true;
                }
            }
        }
        return false;
    }

    /**
     * Get the sensitivity level for a column name.
     */
    public static SensitivityLevel getSensitivityLevel(String columnName) {
        for (Map.Entry<SensitivityLevel, List<Pattern>> entry : SENSITIVITY_PATTERNS.entrySet()) {
            for (Pattern pattern : entry.getValue()) {
                if (pattern.matcher(columnName).find()) {
                    return entry.getKey();
                }
            }
        }
        return null;
    }
}

