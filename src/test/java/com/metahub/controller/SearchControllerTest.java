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
class SearchControllerTest {

    @Autowired private MockMvc mockMvc;

    @Test
    void shouldSearchWithQuery() throws Exception {
        mockMvc.perform(get("/api/v1/search").param("q", "customer"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.success").value(true));
    }

    @Test
    void shouldHandleEmptySearch() throws Exception {
        mockMvc.perform(get("/api/v1/search"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.success").value(true));
    }
}

