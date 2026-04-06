package com.metahub.controller;

import com.metahub.dto.request.TagRequest;
import com.metahub.dto.response.ApiResponse;
import com.metahub.dto.response.TagResponse;
import com.metahub.service.TagService;
import jakarta.validation.Valid;
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
    public ResponseEntity<ApiResponse<List<TagResponse>>> list() {
        return ResponseEntity.ok(ApiResponse.ok(tagService.listAll()));
    }

    @PostMapping
    public ResponseEntity<ApiResponse<TagResponse>> create(@Valid @RequestBody TagRequest request) {
        TagResponse created = tagService.create(request);
        return ResponseEntity.status(HttpStatus.CREATED).body(ApiResponse.ok(created, "Tag created"));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<ApiResponse<Void>> delete(@PathVariable UUID id) {
        tagService.delete(id);
        return ResponseEntity.ok(ApiResponse.ok(null, "Tag deleted"));
    }
}

