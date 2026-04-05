package com.metahub.repository;

import com.metahub.model.DataSource;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.UUID;

@Repository
public interface DataSourceRepository extends JpaRepository<DataSource, UUID> {
}

