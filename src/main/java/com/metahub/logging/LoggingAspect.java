package com.metahub.logging;

import lombok.extern.slf4j.Slf4j;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.stereotype.Component;

/**
 * Logging aspect for service layer operations.
 * Provides concise logging for key business operations only.
 */
@Slf4j
@Aspect
@Component
public class LoggingAspect {

    @Pointcut("execution(* com.metahub.service.*Service.create*(..)) || " +
              "execution(* com.metahub.service.*Service.update*(..)) || " +
              "execution(* com.metahub.service.*Service.delete*(..))")
    public void mutationOperations() {}

    @Around("mutationOperations()")
    public Object logMutations(ProceedingJoinPoint joinPoint) throws Throwable {
        String className = joinPoint.getTarget().getClass().getSimpleName();
        String methodName = joinPoint.getSignature().getName();

        long start = System.currentTimeMillis();
        try {
            Object result = joinPoint.proceed();
            long duration = System.currentTimeMillis() - start;
            log.info("{}.{} completed ({}ms)", className, methodName, duration);
            return result;
        } catch (Exception e) {
            long duration = System.currentTimeMillis() - start;
            log.error("{}.{} failed ({}ms): {}", className, methodName, duration, e.getMessage());
            throw e;
        }
    }

    @Pointcut("execution(* com.metahub.service.SearchService.search*(..))")
    public void searchOperations() {}

    @Around("searchOperations()")
    public Object logSearches(ProceedingJoinPoint joinPoint) throws Throwable {
        Object[] args = joinPoint.getArgs();
        String query = args.length > 0 ? String.valueOf(args[0]) : "";

        long start = System.currentTimeMillis();
        try {
            Object result = joinPoint.proceed();
            long duration = System.currentTimeMillis() - start;
            log.info("Search '{}' completed ({}ms)", truncate(query, 50), duration);
            return result;
        } catch (Exception e) {
            log.error("Search '{}' failed: {}", truncate(query, 50), e.getMessage());
            throw e;
        }
    }

    private String truncate(String str, int maxLen) {
        if (str == null) return "";
        return str.length() <= maxLen ? str : str.substring(0, maxLen) + "...";
    }
}

