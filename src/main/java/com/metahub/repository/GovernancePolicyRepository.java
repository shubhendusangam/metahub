package com.metahub.repository;

import com.metahub.model.GovernancePolicy;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.UUID;

@Repository
public interface GovernancePolicyRepository extends JpaRepository<GovernancePolicy, UUID> {
}

