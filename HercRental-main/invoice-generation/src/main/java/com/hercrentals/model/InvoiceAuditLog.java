package com.hercrentals.model;

import java.io.Serializable;
import java.sql.Timestamp;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import lombok.Data;

@Data
@Entity
public class InvoiceAuditLog implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	private String invoiceType;
	private String invoiceNumber;
	private String customerNumber;
	private String location;
	private Timestamp eventTimestamp;
	private String inputBucketName;
	private String outputBucketName;
	private String inputXmlFile;
	private String outputPdfFile;
	private String overallStatus;
	private String requestType;
	private Long totalExecutionDuration;

}
