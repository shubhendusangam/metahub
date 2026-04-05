package com.metahub.logging;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.slf4j.MDC;

import java.util.Map;

/**
 * Centralized logging utility for consistent, concise application logging.
 * Use this for structured logging across the application.
 */
public final class AppLogger {

    private AppLogger() {}

    public static Logger get(Class<?> clazz) {
        return LoggerFactory.getLogger(clazz);
    }

    /**
     * Log an operation start (only for long-running operations).
     */
    public static void operationStart(Logger log, String operation, Object... args) {
        log.debug("Starting: {} {}", operation, formatArgs(args));
    }

    /**
     * Log an operation completion with duration.
     */
    public static void operationEnd(Logger log, String operation, long startTimeMs) {
        long duration = System.currentTimeMillis() - startTimeMs;
        log.info("{} completed ({}ms)", operation, duration);
    }

    /**
     * Log a business event concisely.
     */
    public static void event(Logger log, String event, String entityType, Object entityId) {
        log.info("{}: {} [{}]", event, entityType, entityId);
    }

    /**
     * Log an error with context.
     */
    public static void error(Logger log, String operation, Throwable e) {
        log.error("{} failed: {}", operation, e.getMessage());
    }

    /**
     * Execute with MDC context.
     */
    public static void withContext(Map<String, String> context, Runnable action) {
        context.forEach(MDC::put);
        try {
            action.run();
        } finally {
            context.keySet().forEach(MDC::remove);
        }
    }

    private static String formatArgs(Object... args) {
        if (args == null || args.length == 0) return "";
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < args.length; i += 2) {
            if (i > 0) sb.append(", ");
            if (i + 1 < args.length) {
                sb.append(args[i]).append("=").append(args[i + 1]);
            }
        }
        return sb.toString();
    }
}

