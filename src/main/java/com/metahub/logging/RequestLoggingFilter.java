package com.metahub.logging;

import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.extern.slf4j.Slf4j;
import org.slf4j.MDC;
import org.springframework.core.Ordered;
import org.springframework.core.annotation.Order;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

import java.io.IOException;
import java.util.UUID;

/**
 * Centralized request logging filter.
 * Adds request context to MDC and logs request/response summary.
 */
@Slf4j
@Component
@Order(Ordered.HIGHEST_PRECEDENCE)
public class RequestLoggingFilter extends OncePerRequestFilter {

    private static final String REQUEST_ID = "requestId";
    private static final String METHOD = "method";
    private static final String URI = "uri";
    private static final String USER_ID = "userId";

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response,
                                    FilterChain filterChain) throws ServletException, IOException {
        // Skip static resources and actuator
        if (shouldSkip(request)) {
            filterChain.doFilter(request, response);
            return;
        }

        long startTime = System.currentTimeMillis();
        String requestId = UUID.randomUUID().toString().substring(0, 8);

        try {
            // Set MDC context
            MDC.put(REQUEST_ID, requestId);
            MDC.put(METHOD, request.getMethod());
            MDC.put(URI, request.getRequestURI());
            MDC.put(USER_ID, extractUserId(request));

            filterChain.doFilter(request, response);

        } finally {
            long duration = System.currentTimeMillis() - startTime;
            int status = response.getStatus();

            // Log concise request summary
            if (status >= 400) {
                log.warn("{} {} → {} ({}ms)", request.getMethod(), request.getRequestURI(), status, duration);
            } else {
                log.info("{} {} → {} ({}ms)", request.getMethod(), request.getRequestURI(), status, duration);
            }

            MDC.clear();
        }
    }

    private boolean shouldSkip(HttpServletRequest request) {
        String uri = request.getRequestURI();
        return uri.startsWith("/actuator") ||
               uri.startsWith("/swagger") ||
               uri.startsWith("/api-docs") ||
               uri.startsWith("/h2-console") ||
               uri.endsWith(".js") ||
               uri.endsWith(".css") ||
               uri.endsWith(".ico");
    }

    private String extractUserId(HttpServletRequest request) {
        // Extract from security context or header if available
        String userId = request.getHeader("X-User-Id");
        return userId != null ? userId : "anonymous";
    }
}

