package com.hercrentals.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.hercrentals.model.InvoiceProcessingAuditLog;

@Repository
public interface InvoiceProcessingAuditRepository extends JpaRepository<InvoiceProcessingAuditLog, Integer> {

}
