package com.metahub.util;

import java.util.Arrays;
import java.util.Set;
import java.util.stream.Collectors;

/**
 * String manipulation utilities.
 */
public final class StringUtils {

    private static final Set<String> STOP_WORDS = Set.of(
            "find", "search", "show", "list", "what", "is", "the", "a", "an", "for",
            "all", "with", "that", "have", "has", "are", "me", "my", "can", "you",
            "where", "which", "how", "when", "who", "this", "these", "those"
    );

    private StringUtils() {
        // Utility class - prevent instantiation
    }

    /**
     * Capitalize the first letter of a string.
     */
    public static String capitalize(String s) {
        if (s == null || s.isEmpty()) return s;
        return Character.toUpperCase(s.charAt(0)) + s.substring(1);
    }

    /**
     * Convert snake_case to Title Case.
     */
    public static String snakeToTitleCase(String s) {
        if (s == null || s.isEmpty()) return s;
        return Arrays.stream(s.split("_"))
                .map(StringUtils::capitalize)
                .collect(Collectors.joining(" "));
    }

    /**
     * Check if a string is blank (null, empty, or whitespace only).
     */
    public static boolean isBlank(String s) {
        return s == null || s.isBlank();
    }

    /**
     * Check if a string is not blank.
     */
    public static boolean isNotBlank(String s) {
        return !isBlank(s);
    }

    /**
     * Remove common stop words from a query string.
     */
    public static java.util.List<String> extractSearchTerms(String query) {
        if (isBlank(query)) return java.util.List.of();

        return Arrays.stream(query.toLowerCase().split("\\s+"))
                .filter(w -> !STOP_WORDS.contains(w) && w.length() > 2)
                .collect(Collectors.toList());
    }

    /**
     * Truncate string to max length with ellipsis.
     */
    public static String truncate(String s, int maxLength) {
        if (s == null || s.length() <= maxLength) return s;
        return s.substring(0, maxLength - 3) + "...";
    }
}

