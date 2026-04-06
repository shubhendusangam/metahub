package com.metahub.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.metahub.dto.request.GlossaryTermRequest;
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
class GlossaryControllerTest {

    @Autowired private MockMvc mockMvc;
    @Autowired private ObjectMapper objectMapper;

    @Test
    void shouldCreateAndRetrieveGlossaryTerm() throws Exception {
        GlossaryTermRequest request = GlossaryTermRequest.builder()
                .term("Test Term")
                .definition("A test glossary term definition")
                .category("Testing")
                .build();

        String response = mockMvc.perform(post("/api/v1/glossary")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(request)))
                .andExpect(status().isCreated())
                .andExpect(jsonPath("$.success").value(true))
                .andExpect(jsonPath("$.data.term").value("Test Term"))
                .andReturn().getResponse().getContentAsString();

        String id = objectMapper.readTree(response).path("data").path("id").asText();

        mockMvc.perform(get("/api/v1/glossary/" + id))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.data.definition").value("A test glossary term definition"));
    }

    @Test
    void shouldListGlossaryTerms() throws Exception {
        mockMvc.perform(get("/api/v1/glossary"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.success").value(true))
                .andExpect(jsonPath("$.data.content").isArray());
    }

    @Test
    void shouldDeleteGlossaryTerm() throws Exception {
        GlossaryTermRequest request = GlossaryTermRequest.builder()
                .term("Delete Me Term")
                .definition("To be deleted")
                .category("Testing")
                .build();

        String response = mockMvc.perform(post("/api/v1/glossary")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(request)))
                .andExpect(status().isCreated())
                .andReturn().getResponse().getContentAsString();

        String id = objectMapper.readTree(response).path("data").path("id").asText();

        mockMvc.perform(delete("/api/v1/glossary/" + id))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.success").value(true));
    }
}

