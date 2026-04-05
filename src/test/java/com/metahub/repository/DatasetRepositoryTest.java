package com.metahub.repository;

import com.metahub.config.AuditingConfig;
import com.metahub.model.Dataset;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;
import org.springframework.context.annotation.Import;
import org.springframework.test.context.ActiveProfiles;

import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;

@DataJpaTest
@ActiveProfiles("test")
@Import(AuditingConfig.class)
class DatasetRepositoryTest {

    @Autowired
    private DatasetRepository datasetRepository;

    @Test
    void shouldSaveAndFindByQualifiedName() {
        Dataset dataset = Dataset.builder()
                .name("repo_test")
                .qualifiedName("repo.test.repo_test")
                .description("Repository test")
                .build();

        datasetRepository.save(dataset);

        Optional<Dataset> found = datasetRepository.findByQualifiedName("repo.test.repo_test");
        assertTrue(found.isPresent());
        assertEquals("repo_test", found.get().getName());
    }

    @Test
    void shouldSearchByQuery() {
        Dataset ds = Dataset.builder()
                .name("searchable_dataset")
                .qualifiedName("repo.test.searchable")
                .description("Contains important financial data")
                .build();
        datasetRepository.save(ds);

        var results = datasetRepository.searchByQuery("financial",
                org.springframework.data.domain.PageRequest.of(0, 10));
        assertFalse(results.isEmpty());
    }
}

