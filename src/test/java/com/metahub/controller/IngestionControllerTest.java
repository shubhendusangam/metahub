package com.metahub.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.metahub.dto.request.DataSourceRequest;
import com.metahub.model.enums.DataSourceType;
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
class IngestionControllerTest {

    @Autowired private MockMvc mockMvc;
    @Autowired private ObjectMapper objectMapper;

    @Test
    void shouldRunIngestionForJdbcSource() throws Exception {
        // Create a JDBC data source pointing to the in-memory H2 test DB
        DataSourceRequest request = DataSourceRequest.builder()
                .name("Ingestion Test DB")
                .type(DataSourceType.JDBC)
                .connectionUrl("jdbc:h2:mem:testdb;DB_CLOSE_DELAY=-1;USER=sa;PASSWORD=")
                .description("H2 test DB for ingestion")
                .build();

        String response = mockMvc.perform(post("/api/v1/datasources")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(request)))
                .andExpect(status().isCreated())
                .andReturn().getResponse().getContentAsString();

        String dsId = objectMapper.readTree(response).path("data").path("id").asText();

        // Trigger ingestion — should discover H2 tables
        mockMvc.perform(post("/api/v1/ingestion/run/" + dsId))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.success").value(true));
    }
}

