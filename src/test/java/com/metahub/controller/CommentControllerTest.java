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

import java.util.Map;
import java.util.UUID;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

@SpringBootTest
@AutoConfigureMockMvc
@ActiveProfiles("test")
class CommentControllerTest {

    @Autowired private MockMvc mockMvc;
    @Autowired private ObjectMapper objectMapper;

    private String createUser() throws Exception {
        UserRequest req = UserRequest.builder()
                .username("cmt_user_" + UUID.randomUUID().toString().substring(0, 8))
                .email("cmt_" + UUID.randomUUID().toString().substring(0, 8) + "@test.io")
                .displayName("Comment Tester")
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
                .name("cmt_dataset")
                .qualifiedName("test.comment." + UUID.randomUUID())
                .description("Comment test dataset")
                .build();
        String response = mockMvc.perform(post("/api/v1/datasets")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(req)))
                .andExpect(status().isCreated())
                .andReturn().getResponse().getContentAsString();
        return objectMapper.readTree(response).path("data").path("id").asText();
    }

    @Test
    void shouldAddListAndDeleteComment() throws Exception {
        String userId = createUser();
        String datasetId = createDataset();

        // Add comment
        String body = objectMapper.writeValueAsString(
                Map.of("authorId", userId, "content", "Great dataset!"));
        String response = mockMvc.perform(post("/api/v1/datasets/" + datasetId + "/comments")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(body))
                .andExpect(status().isCreated())
                .andExpect(jsonPath("$.success").value(true))
                .andExpect(jsonPath("$.data.content").value("Great dataset!"))
                .andReturn().getResponse().getContentAsString();

        String commentId = objectMapper.readTree(response).path("data").path("id").asText();

        // List comments
        mockMvc.perform(get("/api/v1/datasets/" + datasetId + "/comments"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.success").value(true));

        // Delete comment
        mockMvc.perform(delete("/api/v1/datasets/" + datasetId + "/comments/" + commentId))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.success").value(true));
    }
}

