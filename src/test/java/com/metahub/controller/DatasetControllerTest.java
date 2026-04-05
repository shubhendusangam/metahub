package com.metahub.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.metahub.dto.request.DatasetRequest;
import com.metahub.service.DatasetService;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.http.MediaType;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.test.web.servlet.MockMvc;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

@SpringBootTest
@AutoConfigureMockMvc
@ActiveProfiles("test")
class DatasetControllerTest {

    @Autowired
    private MockMvc mockMvc;

    @Autowired
    private ObjectMapper objectMapper;

    @Test
    void shouldCreateAndRetrieveDataset() throws Exception {
        DatasetRequest request = DatasetRequest.builder()
                .name("test_dataset")
                .qualifiedName("test.public.test_dataset")
                .description("A test dataset")
                .build();

        // Create
        String response = mockMvc.perform(post("/api/v1/datasets")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(request)))
                .andExpect(status().isCreated())
                .andExpect(jsonPath("$.success").value(true))
                .andExpect(jsonPath("$.data.name").value("test_dataset"))
                .andReturn().getResponse().getContentAsString();

        // Extract ID
        String id = objectMapper.readTree(response).path("data").path("id").asText();

        // Retrieve
        mockMvc.perform(get("/api/v1/datasets/" + id))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.data.qualifiedName").value("test.public.test_dataset"));
    }

    @Test
    void shouldReturnPagedDatasets() throws Exception {
        mockMvc.perform(get("/api/v1/datasets")
                        .param("page", "0")
                        .param("size", "10"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.success").value(true));
    }

    @Test
    void shouldReturn404ForMissingDataset() throws Exception {
        mockMvc.perform(get("/api/v1/datasets/00000000-0000-0000-0000-000000000099"))
                .andExpect(status().isNotFound());
    }
}

