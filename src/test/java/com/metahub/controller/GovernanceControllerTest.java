package com.metahub.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.metahub.dto.request.GovernancePolicyRequest;
import com.metahub.model.enums.PolicyStatus;
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
class GovernanceControllerTest {

    @Autowired private MockMvc mockMvc;
    @Autowired private ObjectMapper objectMapper;

    @Test
    void shouldCreateAndRetrievePolicy() throws Exception {
        GovernancePolicyRequest request = GovernancePolicyRequest.builder()
                .name("Test Policy")
                .description("A test governance policy")
                .rules("{\"min_quality\": 0.9}")
                .status(PolicyStatus.DRAFT)
                .build();

        String response = mockMvc.perform(post("/api/v1/governance/policies")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(request)))
                .andExpect(status().isCreated())
                .andExpect(jsonPath("$.success").value(true))
                .andExpect(jsonPath("$.data.name").value("Test Policy"))
                .andReturn().getResponse().getContentAsString();

        String id = objectMapper.readTree(response).path("data").path("id").asText();

        mockMvc.perform(get("/api/v1/governance/policies/" + id))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.data.status").value("DRAFT"));
    }

    @Test
    void shouldListPolicies() throws Exception {
        mockMvc.perform(get("/api/v1/governance/policies"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.success").value(true));
    }

    @Test
    void shouldDeletePolicy() throws Exception {
        GovernancePolicyRequest request = GovernancePolicyRequest.builder()
                .name("Delete Policy")
                .description("To be deleted")
                .rules("{}")
                .status(PolicyStatus.DRAFT)
                .build();

        String response = mockMvc.perform(post("/api/v1/governance/policies")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(request)))
                .andExpect(status().isCreated())
                .andReturn().getResponse().getContentAsString();

        String id = objectMapper.readTree(response).path("data").path("id").asText();

        mockMvc.perform(delete("/api/v1/governance/policies/" + id))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.success").value(true));
    }
}
