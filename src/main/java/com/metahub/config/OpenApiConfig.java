package com.metahub.config;

import io.swagger.v3.oas.models.OpenAPI;
import io.swagger.v3.oas.models.info.Contact;
import io.swagger.v3.oas.models.info.Info;
import io.swagger.v3.oas.models.info.License;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class OpenApiConfig {

    @Bean
    public OpenAPI metahubOpenAPI() {
        return new OpenAPI()
            .info(new Info()
                .title("MetaHub API")
                .description("Unified Metadata Platform — dataset catalog, lineage, governance & search")
                .version("0.1.0")
                .contact(new Contact().name("MetaHub Team"))
                .license(new License().name("MIT")));
    }
}

