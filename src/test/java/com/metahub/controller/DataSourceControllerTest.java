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
class DataSourceControllerTest {

    @Autowired private MockMvc mockMvc;
    @Autowired private ObjectMapper objectMapper;

    @Test
    void shouldCreateAndRetrieveDataSource() throws Exception {
        DataSourceRequest request = DataSourceRequest.builder()
                .name("Test DB")
                .type(DataSourceType.JDBC)
                .connectionUrl("jdbc:h2:mem:testds")
                .description("A test data source")
                .build();

        String response = mockMvc.perform(post("/api/v1/datasources")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(request)))
                .andExpect(status().isCreated())
                .andExpect(jsonPath("$.success").value(true))
                .andExpect(jsonPath("$.data.name").value("Test DB"))
                .andExpect(jsonPath("$.data.type").value("JDBC"))
                .andReturn().getResponse().getContentAsString();

        String id = objectMapper.readTree(response).path("data").path("id").asText();

        mockMvc.perform(get("/api/v1/datasources/" + id))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.data.connectionUrl").value("jdbc:h2:mem:testds"));
    }

    @Test
    void shouldListDataSources() throws Exception {
        mockMvc.perform(get("/api/v1/datasources"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.success").value(true));
    }

    @Test
    void shouldTestConnection() throws Exception {
        DataSourceRequest request = DataSourceRequest.builder()
                .name("Connection Test DS")
                .type(DataSourceType.API)
                .connectionUrl("https://example.com/api")
                .build();

        String response = mockMvc.perform(post("/api/v1/datasources")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(request)))
                .andExpect(status().isCreated())
                .andReturn().getResponse().getContentAsString();

        String id = objectMapper.readTree(response).path("data").path("id").asText();

        mockMvc.perform(post("/api/v1/datasources/" + id + "/test-connection"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.data").value(true));
    }

    @Test
    void shouldDeleteDataSource() throws Exception {
        DataSourceRequest request = DataSourceRequest.builder()
                .name("Delete Me DS")
                .type(DataSourceType.FILE_SYSTEM)
                .connectionUrl("/tmp/test")
                .build();

        String response = mockMvc.perform(post("/api/v1/datasources")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(request)))
                .andExpect(status().isCreated())
                .andReturn().getResponse().getContentAsString();

        String id = objectMapper.readTree(response).path("data").path("id").asText();

        mockMvc.perform(delete("/api/v1/datasources/" + id))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.success").value(true));
    }

    @Test
    void shouldNotExposeCredentials() throws Exception {
        DataSourceRequest request = DataSourceRequest.builder()
                .name("Creds Test DS")
                .type(DataSourceType.JDBC)
                .connectionUrl("jdbc:h2:mem:creds")
                .credentials("secret-password")
                .build();

        mockMvc.perform(post("/api/v1/datasources")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(request)))
                .andExpect(status().isCreated())
                .andExpect(jsonPath("$.data.credentials").doesNotExist());
    }
}

