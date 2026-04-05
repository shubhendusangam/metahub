package com.metahub.document;

import lombok.*;
import org.springframework.data.annotation.Id;
import org.springframework.data.elasticsearch.annotations.Document;
import org.springframework.data.elasticsearch.annotations.Field;
import org.springframework.data.elasticsearch.annotations.FieldType;

import java.util.List;

@Document(indexName = "datasets")
@Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
public class DatasetDocument {

    @Id
    private String id;

    @Field(type = FieldType.Text, analyzer = "standard")
    private String name;

    @Field(type = FieldType.Text, analyzer = "standard")
    private String description;

    @Field(type = FieldType.Keyword)
    private String qualifiedName;

    @Field(type = FieldType.Keyword)
    private List<String> tags;

    @Field(type = FieldType.Text)
    private String ownerName;

    @Field(type = FieldType.Keyword)
    private String dataSourceName;

    @Field(type = FieldType.Text)
    private List<String> columnNames;
}

