package com.metahub.service;

import com.metahub.exception.ResourceNotFoundException;
import com.metahub.model.User;
import com.metahub.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class UserService {

    private final UserRepository userRepository;

    @Transactional(readOnly = true)
    public List<User> listAll() {
        return userRepository.findAll();
    }

    @Transactional(readOnly = true)
    public User getById(UUID id) {
        return userRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("User", "id", id));
    }

    @Transactional
    public User create(User user) {
        return userRepository.save(user);
    }

    @Transactional
    public User update(UUID id, User updated) {
        User user = getById(id);
        user.setUsername(updated.getUsername());
        user.setEmail(updated.getEmail());
        user.setDisplayName(updated.getDisplayName());
        user.setRole(updated.getRole());
        return userRepository.save(user);
    }

    @Transactional
    public void delete(UUID id) {
        userRepository.deleteById(id);
    }
}

