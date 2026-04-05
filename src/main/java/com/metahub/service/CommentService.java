package com.metahub.service;

import com.metahub.dto.request.CommentRequest;
import com.metahub.dto.response.CommentResponse;
import com.metahub.dto.response.PagedResponse;
import com.metahub.exception.ResourceNotFoundException;
import com.metahub.model.Comment;
import com.metahub.model.Dataset;
import com.metahub.model.User;
import com.metahub.repository.CommentRepository;
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
public class CommentService {

    private final CommentRepository commentRepository;
    private final DatasetRepository datasetRepository;
    private final UserRepository userRepository;

    @Transactional(readOnly = true)
    public PagedResponse<CommentResponse> getComments(UUID datasetId, int page, int size) {
        Page<Comment> commentPage = commentRepository.findByDatasetIdOrderByCreatedAtDesc(
                datasetId, PageRequest.of(page, size));
        List<CommentResponse> content = commentPage.getContent().stream()
                .map(this::toResponse)
                .collect(Collectors.toList());
        return PagedResponse.<CommentResponse>builder()
                .content(content)
                .page(commentPage.getNumber())
                .size(commentPage.getSize())
                .totalElements(commentPage.getTotalElements())
                .totalPages(commentPage.getTotalPages())
                .last(commentPage.isLast())
                .build();
    }

    @Transactional
    public CommentResponse addComment(UUID datasetId, CommentRequest request) {
        Dataset dataset = datasetRepository.findById(datasetId)
                .orElseThrow(() -> new ResourceNotFoundException("Dataset", "id", datasetId));
        User author = userRepository.findById(request.getAuthorId())
                .orElseThrow(() -> new ResourceNotFoundException("User", "id", request.getAuthorId()));

        Comment comment = Comment.builder()
                .content(request.getContent())
                .dataset(dataset)
                .author(author)
                .build();
        return toResponse(commentRepository.save(comment));
    }

    @Transactional
    public CommentResponse updateComment(UUID commentId, String content) {
        Comment comment = commentRepository.findById(commentId)
                .orElseThrow(() -> new ResourceNotFoundException("Comment", "id", commentId));
        comment.setContent(content);
        return toResponse(commentRepository.save(comment));
    }

    @Transactional
    public void deleteComment(UUID commentId) {
        commentRepository.deleteById(commentId);
    }

    private CommentResponse toResponse(Comment comment) {
        return CommentResponse.builder()
                .id(comment.getId())
                .content(comment.getContent())
                .datasetId(comment.getDataset().getId())
                .authorId(comment.getAuthor().getId())
                .authorName(comment.getAuthor().getDisplayName())
                .createdAt(comment.getCreatedAt())
                .updatedAt(comment.getUpdatedAt())
                .build();
    }
}

