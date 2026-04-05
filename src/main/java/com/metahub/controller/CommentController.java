package com.metahub.controller;

import com.metahub.dto.request.CommentRequest;
import com.metahub.dto.response.ApiResponse;
import com.metahub.dto.response.CommentResponse;
import com.metahub.dto.response.PagedResponse;
import com.metahub.service.CommentService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Map;
import java.util.UUID;

@RestController
@RequestMapping("/api/v1/datasets/{datasetId}/comments")
@RequiredArgsConstructor
public class CommentController {

    private final CommentService commentService;

    @GetMapping
    public ResponseEntity<ApiResponse<PagedResponse<CommentResponse>>> list(
            @PathVariable UUID datasetId,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "20") int size) {
        return ResponseEntity.ok(ApiResponse.ok(commentService.getComments(datasetId, page, size)));
    }

    @PostMapping
    public ResponseEntity<ApiResponse<CommentResponse>> add(
            @PathVariable UUID datasetId,
            @Valid @RequestBody CommentRequest request) {
        CommentResponse comment = commentService.addComment(datasetId, request);
        return ResponseEntity.status(HttpStatus.CREATED)
                .body(ApiResponse.ok(comment, "Comment added"));
    }

    @PutMapping("/{commentId}")
    public ResponseEntity<ApiResponse<CommentResponse>> update(
            @PathVariable UUID datasetId,
            @PathVariable UUID commentId,
            @RequestBody Map<String, String> body) {
        return ResponseEntity.ok(ApiResponse.ok(
                commentService.updateComment(commentId, body.get("content"))));
    }

    @DeleteMapping("/{commentId}")
    public ResponseEntity<ApiResponse<Void>> delete(
            @PathVariable UUID datasetId,
            @PathVariable UUID commentId) {
        commentService.deleteComment(commentId);
        return ResponseEntity.ok(ApiResponse.ok(null, "Comment deleted"));
    }
}

