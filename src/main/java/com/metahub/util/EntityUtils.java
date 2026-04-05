package com.metahub.util;

import com.metahub.exception.ResourceNotFoundException;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.UUID;
import java.util.function.Supplier;

/**
 * Common utility methods for entity operations.
 */
public final class EntityUtils {

    private EntityUtils() {
        // Utility class - prevent instantiation
    }

    /**
     * Find an entity by ID or throw ResourceNotFoundException.
     *
     * @param repository   The JPA repository
     * @param id           The entity ID
     * @param entityName   The entity name for error messages
     * @param <T>          The entity type
     * @return The found entity
     * @throws ResourceNotFoundException if entity not found
     */
    public static <T> T findOrThrow(JpaRepository<T, UUID> repository, UUID id, String entityName) {
        return repository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException(entityName, "id", id));
    }

    /**
     * Find an entity by ID or throw a custom exception.
     *
     * @param repository       The JPA repository
     * @param id               The entity ID
     * @param exceptionSupplier Supplier for the exception to throw
     * @param <T>              The entity type
     * @param <X>              The exception type
     * @return The found entity
     * @throws X if entity not found
     */
    public static <T, X extends Throwable> T findOrThrow(
            JpaRepository<T, UUID> repository,
            UUID id,
            Supplier<X> exceptionSupplier) throws X {
        return repository.findById(id).orElseThrow(exceptionSupplier);
    }
}

