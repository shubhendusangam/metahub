package com.metahub.dto.response;

import lombok.*;

import java.time.Instant;
import java.util.UUID;

@Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
public class UserResponse {
    private UUID id;
    private String username;
    private String email;
    private String displayName;
    private String role;
    private Instant createdAt;
    private Instant updatedAt;
}

