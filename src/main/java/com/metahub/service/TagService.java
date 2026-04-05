package com.metahub.service;

import com.metahub.model.Tag;
import com.metahub.repository.TagRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class TagService {

    private final TagRepository tagRepository;

    @Transactional(readOnly = true)
    public List<Tag> listAll() {
        return tagRepository.findAll();
    }

    @Transactional
    public Tag findOrCreate(String name) {
        return tagRepository.findByName(name)
                .orElseGet(() -> tagRepository.save(Tag.builder().name(name).build()));
    }

    @Transactional
    public Tag create(Tag tag) {
        return tagRepository.save(tag);
    }

    @Transactional
    public void delete(UUID id) {
        tagRepository.deleteById(id);
    }
}

