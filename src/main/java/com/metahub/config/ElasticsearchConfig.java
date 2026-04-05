package com.metahub.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Profile;
import org.springframework.data.elasticsearch.repository.config.EnableElasticsearchRepositories;

@Configuration
@Profile("prod")
@EnableElasticsearchRepositories(basePackages = "com.metahub.repository.search")
public class ElasticsearchConfig {
}

