package com.hercrentals.model;

import java.io.Serializable;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import lombok.Data;

@Data
@Entity
public class InvoiceProcessingAuditLog implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	private int auditId;
	private String functionName;
	private String executionStage;
	private String status;
	private Long executionDuration;
	private String errorType;
	private String errorMessage;
	private String errorStack;
}
