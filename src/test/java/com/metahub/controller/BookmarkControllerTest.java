package com.metahub.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.metahub.dto.request.DatasetRequest;
import com.metahub.dto.request.UserRequest;
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
class BookmarkControllerTest {

    @Autowired private MockMvc mockMvc;
    @Autowired private ObjectMapper objectMapper;

    private String createUser() throws Exception {
        UserRequest req = UserRequest.builder()
                .username("bm_user_" + UUID.randomUUID().toString().substring(0, 8))
                .email("bm_" + UUID.randomUUID().toString().substring(0, 8) + "@test.io")
                .displayName("Bookmark Tester")
                .role("VIEWER")
                .build();
        String response = mockMvc.perform(post("/api/v1/users")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(req)))
                .andExpect(status().isCreated())
                .andReturn().getResponse().getContentAsString();
        return objectMapper.readTree(response).path("data").path("id").asText();
    }

    private String createDataset() throws Exception {
        DatasetRequest req = DatasetRequest.builder()
                .name("bm_dataset")
                .qualifiedName("test.bm." + UUID.randomUUID())
                .description("Bookmark test dataset")
                .build();
        String response = mockMvc.perform(post("/api/v1/datasets")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(req)))
                .andExpect(status().isCreated())
                .andReturn().getResponse().getContentAsString();
        return objectMapper.readTree(response).path("data").path("id").asText();
    }

    @Test
    void shouldAddCheckAndRemoveBookmark() throws Exception {
        String userId = createUser();
        String datasetId = createDataset();

        // Add bookmark
        String body = objectMapper.writeValueAsString(
                java.util.Map.of("userId", userId, "datasetId", datasetId));
        mockMvc.perform(post("/api/v1/bookmarks")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(body))
                .andExpect(status().isCreated())
                .andExpect(jsonPath("$.success").value(true));

        // Check bookmark
        mockMvc.perform(get("/api/v1/bookmarks/check")
                        .param("userId", userId)
                        .param("datasetId", datasetId))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.data").value(true));

        // List bookmarks
        mockMvc.perform(get("/api/v1/bookmarks")
                        .param("userId", userId))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.success").value(true));

        // Remove bookmark
        mockMvc.perform(delete("/api/v1/bookmarks")
                        .param("userId", userId)
                        .param("datasetId", datasetId))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.success").value(true));
    }
}

