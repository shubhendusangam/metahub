package com.metahub.controller;

import com.metahub.dto.response.ApiResponse;
import com.metahub.dto.response.BookmarkResponse;
import com.metahub.dto.response.PagedResponse;
import com.metahub.service.BookmarkService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.UUID;

@RestController
@RequestMapping("/api/v1/bookmarks")
@RequiredArgsConstructor
public class BookmarkController {

    private final BookmarkService bookmarkService;

    @GetMapping
    public ResponseEntity<ApiResponse<PagedResponse<BookmarkResponse>>> list(
            @RequestParam UUID userId,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "20") int size) {
        return ResponseEntity.ok(ApiResponse.ok(bookmarkService.listBookmarks(userId, page, size)));
    }

    @PostMapping
    public ResponseEntity<ApiResponse<BookmarkResponse>> add(
            @Valid @RequestBody com.metahub.dto.request.BookmarkRequest request) {
        BookmarkResponse bookmark = bookmarkService.addBookmark(request.getUserId(), request.getDatasetId());
        return ResponseEntity.status(HttpStatus.CREATED).body(ApiResponse.ok(bookmark, "Bookmarked"));
    }

    @DeleteMapping
    public ResponseEntity<ApiResponse<Void>> remove(
            @RequestParam UUID userId,
            @RequestParam UUID datasetId) {
        bookmarkService.removeBookmark(userId, datasetId);
        return ResponseEntity.ok(ApiResponse.ok(null, "Bookmark removed"));
    }

    @GetMapping("/check")
    public ResponseEntity<ApiResponse<Boolean>> check(
            @RequestParam UUID userId,
            @RequestParam UUID datasetId) {
        return ResponseEntity.ok(ApiResponse.ok(bookmarkService.isBookmarked(userId, datasetId)));
    }
}

