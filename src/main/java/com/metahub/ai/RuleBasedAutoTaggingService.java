package com.metahub.ai;

import com.metahub.model.Dataset;
import com.metahub.model.Tag;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.regex.Pattern;

/**
 * Rule-based auto-tagging implementation.
 * Applies keyword/regex rules on column names and descriptions to suggest tags.
 */
@Slf4j
@Service
public class RuleBasedAutoTaggingService implements AutoTaggingService {

    private static final Map<String, Pattern> TAG_RULES = Map.of(
        "PII", Pattern.compile("(?i)(email|phone|ssn|social_security|address|name|dob|birth)"),
        "Financial", Pattern.compile("(?i)(price|amount|balance|revenue|cost|salary|payment)"),
        "Temporal", Pattern.compile("(?i)(date|time|timestamp|created_at|updated_at|expires)"),
        "Geographic", Pattern.compile("(?i)(country|city|state|zip|postal|latitude|longitude|region)"),
        "Healthcare", Pattern.compile("(?i)(patient|diagnosis|prescription|medical|health|treatment)")
    );

    @Override
    public List<Tag> suggestTags(Dataset dataset) {
        List<Tag> suggested = new ArrayList<>();
        StringBuilder text = new StringBuilder();

        // Combine all searchable text
        if (dataset.getName() != null) text.append(dataset.getName()).append(" ");
        if (dataset.getDescription() != null) text.append(dataset.getDescription()).append(" ");

        if (dataset.getSchemas() != null) {
            dataset.getSchemas().forEach(schema ->
                schema.getColumns().forEach(col -> {
                    text.append(col.getName()).append(" ");
                    if (col.getDescription() != null) text.append(col.getDescription()).append(" ");
                })
            );
        }

        String content = text.toString();

        TAG_RULES.forEach((tagName, pattern) -> {
            if (pattern.matcher(content).find()) {
                suggested.add(Tag.builder().name(tagName).category("auto-tagged").build());
            }
        });

        log.debug("Suggested {} tags for dataset: {}", suggested.size(), dataset.getQualifiedName());
        return suggested;
    }
}

