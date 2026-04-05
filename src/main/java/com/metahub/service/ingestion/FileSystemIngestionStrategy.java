package com.metahub.service.ingestion;

import com.metahub.model.DataSource;
import com.metahub.model.Dataset;
import com.metahub.model.enums.DataSourceType;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;

import java.io.IOException;
import java.nio.file.*;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Stream;

/**
 * Scans a directory path for files and creates dataset entries for each file.
 */
@Slf4j
@Component
public class FileSystemIngestionStrategy implements IngestionStrategy {

    @Override
    public boolean supports(DataSource source) {
        return source.getType() == DataSourceType.FILE_SYSTEM;
    }

    @Override
    public List<Dataset> ingest(DataSource source) {
        List<Dataset> datasets = new ArrayList<>();
        Path rootPath = Paths.get(source.getConnectionUrl());

        if (!Files.isDirectory(rootPath)) {
            log.warn("Path is not a directory: {}", rootPath);
            return datasets;
        }

        try (Stream<Path> files = Files.walk(rootPath, 2)) {
            files.filter(Files::isRegularFile).forEach(file -> {
                String fileName = file.getFileName().toString();
                String qualifiedName = source.getName() + "." + rootPath.relativize(file).toString();

                Dataset dataset = Dataset.builder()
                        .name(fileName)
                        .qualifiedName(qualifiedName)
                        .description("File: " + file.toAbsolutePath() + " | Size: " + fileSize(file) + " bytes")
                        .dataSource(source)
                        .build();
                datasets.add(dataset);
            });
        } catch (IOException e) {
            log.error("File system ingestion failed for: {}", source.getConnectionUrl(), e);
        }

        log.info("Ingested {} files from: {}", datasets.size(), source.getConnectionUrl());
        return datasets;
    }

    private long fileSize(Path path) {
        try { return Files.size(path); }
        catch (IOException e) { return -1; }
    }
}

