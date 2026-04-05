package com.metahub.repository;

import com.metahub.model.GlossaryTerm;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.Optional;
import java.util.UUID;

@Repository
public interface GlossaryTermRepository extends JpaRepository<GlossaryTerm, UUID> {
    Optional<GlossaryTerm> findByTermIgnoreCase(String term);

    Page<GlossaryTerm> findByCategoryIgnoreCase(String category, Pageable pageable);

    @Query("SELECT g FROM GlossaryTerm g WHERE " +
           "LOWER(g.term) LIKE LOWER(CONCAT('%', :query, '%')) OR " +
           "LOWER(g.definition) LIKE LOWER(CONCAT('%', :query, '%'))")
    Page<GlossaryTerm> searchByQuery(@Param("query") String query, Pageable pageable);
}

