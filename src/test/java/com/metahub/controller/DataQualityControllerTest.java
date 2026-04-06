package com.metahub.controller;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.test.web.servlet.MockMvc;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

@SpringBootTest
@AutoConfigureMockMvc
@ActiveProfiles("test")
class DataQualityControllerTest {

    @Autowired private MockMvc mockMvc;

    @Test
    void shouldGetAllScores() throws Exception {
        mockMvc.perform(get("/api/v1/quality/scores"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.success").value(true));
    }

    @Test
    void shouldComputeScores() throws Exception {
        mockMvc.perform(post("/api/v1/quality/compute"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.success").value(true));
    }
}

