package com.metahub.service;

import com.metahub.dto.response.BookmarkResponse;
import com.metahub.dto.response.PagedResponse;
import com.metahub.exception.ResourceNotFoundException;
import com.metahub.model.Bookmark;
import com.metahub.model.Dataset;
import com.metahub.model.User;
import com.metahub.repository.BookmarkRepository;
import com.metahub.repository.DatasetRepository;
import com.metahub.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class BookmarkService {

    private final BookmarkRepository bookmarkRepository;
    private final DatasetRepository datasetRepository;
    private final UserRepository userRepository;

    @Transactional
    public BookmarkResponse addBookmark(UUID userId, UUID datasetId) {
        if (bookmarkRepository.existsByUserIdAndDatasetId(userId, datasetId)) {
            Bookmark existing = bookmarkRepository.findByUserIdAndDatasetId(userId, datasetId).get();
            return toResponse(existing);
        }
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new ResourceNotFoundException("User", "id", userId));
        Dataset dataset = datasetRepository.findById(datasetId)
                .orElseThrow(() -> new ResourceNotFoundException("Dataset", "id", datasetId));

        Bookmark bookmark = Bookmark.builder().user(user).dataset(dataset).build();
        return toResponse(bookmarkRepository.save(bookmark));
    }

    @Transactional
    public void removeBookmark(UUID userId, UUID datasetId) {
        bookmarkRepository.deleteByUserIdAndDatasetId(userId, datasetId);
    }

    @Transactional(readOnly = true)
    public PagedResponse<BookmarkResponse> listBookmarks(UUID userId, int page, int size) {
        Page<Bookmark> bookmarkPage = bookmarkRepository.findByUserIdOrderByCreatedAtDesc(
                userId, PageRequest.of(page, size));
        List<BookmarkResponse> content = bookmarkPage.getContent().stream()
                .map(this::toResponse)
                .collect(Collectors.toList());
        return PagedResponse.<BookmarkResponse>builder()
                .content(content)
                .page(bookmarkPage.getNumber())
                .size(bookmarkPage.getSize())
                .totalElements(bookmarkPage.getTotalElements())
                .totalPages(bookmarkPage.getTotalPages())
                .last(bookmarkPage.isLast())
                .build();
    }

    @Transactional(readOnly = true)
    public boolean isBookmarked(UUID userId, UUID datasetId) {
        return bookmarkRepository.existsByUserIdAndDatasetId(userId, datasetId);
    }

    private BookmarkResponse toResponse(Bookmark b) {
        return BookmarkResponse.builder()
                .id(b.getId())
                .datasetId(b.getDataset().getId())
                .datasetName(b.getDataset().getName())
                .datasetQualifiedName(b.getDataset().getQualifiedName())
                .datasetDescription(b.getDataset().getDescription())
                .userId(b.getUser().getId())
                .createdAt(b.getCreatedAt())
                .build();
    }
}

