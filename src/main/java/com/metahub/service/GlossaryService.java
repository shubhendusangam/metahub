package com.metahub.service;

import com.metahub.dto.request.GlossaryTermRequest;
import com.metahub.dto.response.GlossaryTermResponse;
import com.metahub.dto.response.PagedResponse;
import com.metahub.exception.ResourceNotFoundException;
import com.metahub.model.Dataset;
import com.metahub.model.GlossaryTerm;
import com.metahub.repository.DatasetRepository;
import com.metahub.repository.GlossaryTermRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class GlossaryService {

    private final GlossaryTermRepository glossaryRepository;
    private final DatasetRepository datasetRepository;

    @Transactional(readOnly = true)
    public PagedResponse<GlossaryTermResponse> list(String category, String query, int page, int size) {
        Page<GlossaryTerm> termPage;
        PageRequest pageRequest = PageRequest.of(page, size, Sort.by("term"));

        if (query != null && !query.isBlank()) {
            termPage = glossaryRepository.searchByQuery(query, pageRequest);
        } else if (category != null && !category.isBlank()) {
            termPage = glossaryRepository.findByCategoryIgnoreCase(category, pageRequest);
        } else {
            termPage = glossaryRepository.findAll(pageRequest);
        }

        return toPagedResponse(termPage);
    }

    @Transactional(readOnly = true)
    public GlossaryTermResponse getById(UUID id) {
        GlossaryTerm term = findOrThrow(id);
        return toResponse(term);
    }

    @Transactional
    public GlossaryTermResponse create(GlossaryTermRequest request) {
        GlossaryTerm term = GlossaryTerm.builder()
                .term(request.getTerm())
                .definition(request.getDefinition())
                .category(request.getCategory())
                .synonyms(request.getSynonyms() != null ? request.getSynonyms() : new ArrayList<>())
                .build();

        if (request.getRelatedDatasetIds() != null && !request.getRelatedDatasetIds().isEmpty()) {
            Set<Dataset> datasets = new HashSet<>(datasetRepository.findAllById(request.getRelatedDatasetIds()));
            term.setRelatedDatasets(datasets);
        }

        return toResponse(glossaryRepository.save(term));
    }

    @Transactional
    public GlossaryTermResponse update(UUID id, GlossaryTermRequest request) {
        GlossaryTerm term = findOrThrow(id);
        term.setTerm(request.getTerm());
        term.setDefinition(request.getDefinition());
        term.setCategory(request.getCategory());
        if (request.getSynonyms() != null) {
            term.setSynonyms(request.getSynonyms());
        }
        if (request.getRelatedDatasetIds() != null) {
            Set<Dataset> datasets = new HashSet<>(datasetRepository.findAllById(request.getRelatedDatasetIds()));
            term.setRelatedDatasets(datasets);
        }
        return toResponse(glossaryRepository.save(term));
    }

    @Transactional
    public void delete(UUID id) {
        glossaryRepository.deleteById(id);
    }

    private GlossaryTerm findOrThrow(UUID id) {
        return glossaryRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("GlossaryTerm", "id", id));
    }

    private PagedResponse<GlossaryTermResponse> toPagedResponse(Page<GlossaryTerm> page) {
        List<GlossaryTermResponse> content = page.getContent().stream()
                .map(this::toResponse)
                .collect(Collectors.toList());
        return PagedResponse.<GlossaryTermResponse>builder()
                .content(content)
                .page(page.getNumber())
                .size(page.getSize())
                .totalElements(page.getTotalElements())
                .totalPages(page.getTotalPages())
                .last(page.isLast())
                .build();
    }

    private GlossaryTermResponse toResponse(GlossaryTerm term) {
        List<GlossaryTermResponse.RelatedDataset> datasets = term.getRelatedDatasets() != null
                ? term.getRelatedDatasets().stream()
                    .map(ds -> GlossaryTermResponse.RelatedDataset.builder()
                            .id(ds.getId())
                            .name(ds.getName())
                            .qualifiedName(ds.getQualifiedName())
                            .build())
                    .collect(Collectors.toList())
                : Collections.emptyList();

        return GlossaryTermResponse.builder()
                .id(term.getId())
                .term(term.getTerm())
                .definition(term.getDefinition())
                .category(term.getCategory())
                .synonyms(term.getSynonyms())
                .relatedDatasets(datasets)
                .createdAt(term.getCreatedAt())
                .updatedAt(term.getUpdatedAt())
                .build();
    }
}

