package com.metahub.service;

import com.metahub.dto.request.DatasetRequest;
import com.metahub.dto.response.DatasetResponse;
import com.metahub.dto.response.PagedResponse;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.ActiveProfiles;

import java.util.Set;

import static org.junit.jupiter.api.Assertions.*;

@SpringBootTest
@ActiveProfiles("test")
class DatasetServiceTest {

    @Autowired
    private DatasetService datasetService;

    @Test
    void shouldCreateDatasetWithTags() {
        DatasetRequest request = DatasetRequest.builder()
                .name("service_test_ds")
                .qualifiedName("test.svc.service_test_ds")
                .description("Service test dataset")
                .tagNames(Set.of("PII", "Financial"))
                .build();

        DatasetResponse response = datasetService.createDataset(request);

        assertNotNull(response.getId());
        assertEquals("service_test_ds", response.getName());
        assertTrue(response.getTags().contains("PII"));
        assertTrue(response.getTags().contains("Financial"));
    }

    @Test
    void shouldListDatasetsWithPagination() {
        // Create a couple datasets first
        datasetService.createDataset(DatasetRequest.builder()
                .name("ds1").qualifiedName("test.svc.ds1").build());
        datasetService.createDataset(DatasetRequest.builder()
                .name("ds2").qualifiedName("test.svc.ds2").build());

        PagedResponse<DatasetResponse> page = datasetService.listDatasets(0, 10);

        assertNotNull(page);
        assertFalse(page.getContent().isEmpty());
    }
}

