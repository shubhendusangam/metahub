package com.metahub.controller;

import com.metahub.dto.response.ApiResponse;
import com.metahub.model.Tag;
import com.metahub.service.TagService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("/api/v1/tags")
@RequiredArgsConstructor
public class TagController {

    private final TagService tagService;

    @GetMapping
    public ResponseEntity<ApiResponse<List<Tag>>> list() {
        return ResponseEntity.ok(ApiResponse.ok(tagService.listAll()));
    }

    @PostMapping
    public ResponseEntity<ApiResponse<Tag>> create(@RequestBody Tag tag) {
        Tag created = tagService.create(tag);
        return ResponseEntity.status(HttpStatus.CREATED).body(ApiResponse.ok(created));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<ApiResponse<Void>> delete(@PathVariable UUID id) {
        tagService.delete(id);
        return ResponseEntity.ok(ApiResponse.ok(null, "Tag deleted"));
    }
}

