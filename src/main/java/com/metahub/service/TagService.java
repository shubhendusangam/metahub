package com.metahub.service;

import com.metahub.dto.request.TagRequest;
import com.metahub.dto.response.TagResponse;
import com.metahub.model.Tag;
import com.metahub.repository.TagRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class TagService {

    private final TagRepository tagRepository;

    @Transactional(readOnly = true)
    public List<TagResponse> listAll() {
        return tagRepository.findAll().stream()
                .map(this::toResponse)
                .collect(Collectors.toList());
    }

    @Transactional
    public Tag findOrCreate(String name) {
        return tagRepository.findByName(name)
                .orElseGet(() -> tagRepository.save(Tag.builder().name(name).build()));
    }

    @Transactional
    public TagResponse create(TagRequest request) {
        Tag tag = Tag.builder()
                .name(request.getName())
                .category(request.getCategory())
                .description(request.getDescription())
                .build();
        return toResponse(tagRepository.save(tag));
    }

    @Transactional
    public void delete(UUID id) {
        tagRepository.deleteById(id);
    }

    private TagResponse toResponse(Tag tag) {
        return TagResponse.builder()
                .id(tag.getId())
                .name(tag.getName())
                .category(tag.getCategory())
                .description(tag.getDescription())
                .createdAt(tag.getCreatedAt())
                .build();
    }
}

