package com.metahub.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.metahub.dto.request.UserRequest;
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
class UserControllerTest {

    @Autowired private MockMvc mockMvc;
    @Autowired private ObjectMapper objectMapper;

    @Test
    void shouldCreateAndRetrieveUser() throws Exception {
        UserRequest request = UserRequest.builder()
                .username("testuser")
                .email("testuser@metahub.io")
                .displayName("Test User")
                .role("VIEWER")
                .build();

        String response = mockMvc.perform(post("/api/v1/users")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(request)))
                .andExpect(status().isCreated())
                .andExpect(jsonPath("$.success").value(true))
                .andExpect(jsonPath("$.data.username").value("testuser"))
                .andExpect(jsonPath("$.data.role").value("VIEWER"))
                .andReturn().getResponse().getContentAsString();

        String id = objectMapper.readTree(response).path("data").path("id").asText();

        mockMvc.perform(get("/api/v1/users/" + id))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.data.email").value("testuser@metahub.io"));
    }

    @Test
    void shouldListUsers() throws Exception {
        mockMvc.perform(get("/api/v1/users"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.success").value(true));
    }

    @Test
    void shouldReturn404ForMissingUser() throws Exception {
        mockMvc.perform(get("/api/v1/users/00000000-0000-0000-0000-000000000099"))
                .andExpect(status().isNotFound());
    }

    @Test
    void shouldRejectInvalidUserRequest() throws Exception {
        UserRequest request = UserRequest.builder().username("").email("").role("").build();

        mockMvc.perform(post("/api/v1/users")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(request)))
                .andExpect(status().isBadRequest());
    }
}

