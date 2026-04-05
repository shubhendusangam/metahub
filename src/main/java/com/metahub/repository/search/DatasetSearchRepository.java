package com.metahub.repository.search;

import com.metahub.document.DatasetDocument;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.data.elasticsearch.repository.ElasticsearchRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@ConditionalOnProperty(name = "metahub.search.engine", havingValue = "elasticsearch")
public interface DatasetSearchRepository extends ElasticsearchRepository<DatasetDocument, String> {
    List<DatasetDocument> findByNameContainingOrDescriptionContaining(String name, String description);
}

