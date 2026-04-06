package com.metahub.service;

import com.metahub.dto.request.UserRequest;
import com.metahub.dto.response.UserResponse;
import com.metahub.exception.ResourceNotFoundException;
import com.metahub.model.User;
import com.metahub.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class UserService {

    private final UserRepository userRepository;

    @Transactional(readOnly = true)
    public List<UserResponse> listAll() {
        return userRepository.findAll().stream()
                .map(this::toResponse)
                .collect(Collectors.toList());
    }

    @Transactional(readOnly = true)
    public UserResponse getById(UUID id) {
        return toResponse(findOrThrow(id));
    }

    @Transactional
    public UserResponse create(UserRequest request) {
        User user = User.builder()
                .username(request.getUsername())
                .email(request.getEmail())
                .displayName(request.getDisplayName())
                .role(request.getRole())
                .build();
        return toResponse(userRepository.save(user));
    }

    @Transactional
    public UserResponse update(UUID id, UserRequest request) {
        User user = findOrThrow(id);
        user.setUsername(request.getUsername());
        user.setEmail(request.getEmail());
        user.setDisplayName(request.getDisplayName());
        user.setRole(request.getRole());
        return toResponse(userRepository.save(user));
    }

    @Transactional
    public void delete(UUID id) {
        User user = findOrThrow(id);
        userRepository.delete(user);
    }

    private User findOrThrow(UUID id) {
        return userRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("User", "id", id));
    }

    private UserResponse toResponse(User user) {
        return UserResponse.builder()
                .id(user.getId())
                .username(user.getUsername())
                .email(user.getEmail())
                .displayName(user.getDisplayName())
                .role(user.getRole())
                .createdAt(user.getCreatedAt())
                .updatedAt(user.getUpdatedAt())
                .build();
    }
}

