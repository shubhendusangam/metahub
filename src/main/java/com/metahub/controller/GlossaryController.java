package com.metahub.controller;

import com.metahub.dto.request.GlossaryTermRequest;
import com.metahub.dto.response.ApiResponse;
import com.metahub.dto.response.GlossaryTermResponse;
import com.metahub.dto.response.PagedResponse;
import com.metahub.service.GlossaryService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.UUID;

@RestController
@RequestMapping("/api/v1/glossary")
@RequiredArgsConstructor
public class GlossaryController {

    private final GlossaryService glossaryService;

    @GetMapping
    public ResponseEntity<ApiResponse<PagedResponse<GlossaryTermResponse>>> list(
            @RequestParam(required = false) String category,
            @RequestParam(required = false) String q,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "20") int size) {
        return ResponseEntity.ok(ApiResponse.ok(glossaryService.list(category, q, page, size)));
    }

    @GetMapping("/{id}")
    public ResponseEntity<ApiResponse<GlossaryTermResponse>> getById(@PathVariable UUID id) {
        return ResponseEntity.ok(ApiResponse.ok(glossaryService.getById(id)));
    }

    @PostMapping
    public ResponseEntity<ApiResponse<GlossaryTermResponse>> create(
            @Valid @RequestBody GlossaryTermRequest request) {
        GlossaryTermResponse created = glossaryService.create(request);
        return ResponseEntity.status(HttpStatus.CREATED)
                .body(ApiResponse.ok(created, "Glossary term created"));
    }

    @PutMapping("/{id}")
    public ResponseEntity<ApiResponse<GlossaryTermResponse>> update(
            @PathVariable UUID id, @Valid @RequestBody GlossaryTermRequest request) {
        return ResponseEntity.ok(ApiResponse.ok(glossaryService.update(id, request)));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<ApiResponse<Void>> delete(@PathVariable UUID id) {
        glossaryService.delete(id);
        return ResponseEntity.ok(ApiResponse.ok(null, "Glossary term deleted"));
    }
}

