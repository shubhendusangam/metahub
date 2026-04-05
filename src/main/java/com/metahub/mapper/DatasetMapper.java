package com.metahub.mapper;

import com.metahub.dto.response.DatasetResponse;
import com.metahub.model.ColumnDefinition;
import com.metahub.model.Dataset;
import com.metahub.model.SchemaDefinition;
import com.metahub.model.Tag;
import org.springframework.stereotype.Component;

import java.util.Collections;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

@Component
public class DatasetMapper {

    public DatasetResponse toResponse(Dataset dataset) {
        if (dataset == null) return null;

        return DatasetResponse.builder()
                .id(dataset.getId())
                .name(dataset.getName())
                .description(dataset.getDescription())
                .qualifiedName(dataset.getQualifiedName())
                .dataSourceName(dataset.getDataSource() != null ? dataset.getDataSource().getName() : null)
                .dataSourceId(dataset.getDataSource() != null ? dataset.getDataSource().getId() : null)
                .ownerName(dataset.getOwner() != null ? dataset.getOwner().getDisplayName() : null)
                .ownerId(dataset.getOwner() != null ? dataset.getOwner().getId() : null)
                .tags(mapTags(dataset.getTags()))
                .schemas(mapSchemas(dataset.getSchemas()))
                .createdAt(dataset.getCreatedAt())
                .updatedAt(dataset.getUpdatedAt())
                .build();
    }

    private Set<String> mapTags(Set<Tag> tags) {
        if (tags == null) return Collections.emptySet();
        return tags.stream().map(Tag::getName).collect(Collectors.toSet());
    }

    private List<DatasetResponse.SchemaResponse> mapSchemas(List<SchemaDefinition> schemas) {
        if (schemas == null) return Collections.emptyList();
        return schemas.stream().map(this::mapSchema).collect(Collectors.toList());
    }

    private DatasetResponse.SchemaResponse mapSchema(SchemaDefinition schema) {
        return DatasetResponse.SchemaResponse.builder()
                .id(schema.getId())
                .name(schema.getName())
                .version(schema.getVersion())
                .columns(mapColumns(schema.getColumns()))
                .build();
    }

    private List<DatasetResponse.ColumnResponse> mapColumns(List<ColumnDefinition> columns) {
        if (columns == null) return Collections.emptyList();
        return columns.stream().map(col ->
                DatasetResponse.ColumnResponse.builder()
                        .id(col.getId())
                        .name(col.getName())
                        .dataType(col.getDataType())
                        .nullable(col.getNullable())
                        .isPrimaryKey(col.getIsPrimaryKey())
                        .description(col.getDescription())
                        .ordinalPosition(col.getOrdinalPosition())
                        .build()
        ).collect(Collectors.toList());
    }
}

