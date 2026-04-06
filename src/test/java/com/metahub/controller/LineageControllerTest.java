package com.metahub.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.metahub.dto.request.DatasetRequest;
import com.metahub.dto.request.LineageRequest;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.http.MediaType;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.test.web.servlet.MockMvc;

import java.util.UUID;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

@SpringBootTest
@AutoConfigureMockMvc
@ActiveProfiles("test")
class LineageControllerTest {

    @Autowired private MockMvc mockMvc;
    @Autowired private ObjectMapper objectMapper;

    private String createDataset(String name) throws Exception {
        DatasetRequest req = DatasetRequest.builder()
                .name(name)
                .qualifiedName("test.lineage." + name + "." + UUID.randomUUID())
                .description("Lineage test dataset")
                .build();
        String response = mockMvc.perform(post("/api/v1/datasets")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(req)))
                .andExpect(status().isCreated())
                .andReturn().getResponse().getContentAsString();
        return objectMapper.readTree(response).path("data").path("id").asText();
    }

    @Test
    void shouldCreateLineageEdgeAndGetGraph() throws Exception {
        String sourceId = createDataset("source_ds");
        String targetId = createDataset("target_ds");

        LineageRequest request = LineageRequest.builder()
                .sourceDatasetId(UUID.fromString(sourceId))
                .targetDatasetId(UUID.fromString(targetId))
                .transformationDescription("Test ETL")
                .jobName("test-job")
                .build();

        mockMvc.perform(post("/api/v1/lineage")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(request)))
                .andExpect(status().isCreated())
                .andExpect(jsonPath("$.success").value(true))
                .andExpect(jsonPath("$.data.jobName").value("test-job"));

        mockMvc.perform(get("/api/v1/lineage/" + sourceId + "/graph"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.success").value(true))
                .andExpect(jsonPath("$.data.nodes").isArray())
                .andExpect(jsonPath("$.data.edges").isArray());

        mockMvc.perform(get("/api/v1/lineage/" + sourceId + "/downstream"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.success").value(true));

        mockMvc.perform(get("/api/v1/lineage/" + targetId + "/upstream"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.success").value(true));
    }
}

