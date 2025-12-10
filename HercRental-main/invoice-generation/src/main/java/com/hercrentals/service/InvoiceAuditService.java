package com.hercrentals.service;

import java.sql.Timestamp;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.w3c.dom.Document;

import com.hercrentals.exception.XMLExtractionException;
import com.hercrentals.model.InvoiceAuditLog;
import com.hercrentals.model.InvoiceProcessingAuditLog;
import com.hercrentals.repository.InvoiceAuditRepository;
import com.hercrentals.repository.InvoiceProcessingAuditRepository;
import com.hercrentals.utils.XMLParseHelper;

import jakarta.transaction.Transactional;

@Service
public class InvoiceAuditService {

	private static final String FNSTATUS_COMPLETE = "Complete";
	private static final String FNSTATUS_FAILED = "Failed";

	@Autowired
	private InvoiceAuditRepository auditRepository;
	@Autowired
	private InvoiceProcessingAuditRepository processingAuditRepository;

	public InvoiceAuditLog insertAuditLog(byte[] xmlBytes, String requestType, String inputXML,
			Timestamp eventTimestamp, String inputBucketName, String outputBucketName) throws XMLExtractionException {
		Document doc = parseXml(xmlBytes);
		InvoiceAuditLog invoiceAudit = new InvoiceAuditLog();
		invoiceAudit.setRequestType(requestType);
		invoiceAudit.setInputXmlFile(inputXML);
		invoiceAudit.setEventTimestamp(eventTimestamp);
		invoiceAudit.setInputBucketName(inputBucketName);
		invoiceAudit.setOutputBucketName(outputBucketName);
		invoiceAudit.setOverallStatus("In Progress");
		invoiceAudit.setInvoiceNumber(XMLParseHelper.extractTagValue(doc, "InvoiceNo"));
		invoiceAudit.setCustomerNumber(XMLParseHelper.extractTagValue(doc, "CustNo"));
		invoiceAudit.setLocation(XMLParseHelper.extractTagValue(doc, "Country"));
		invoiceAudit.setInvoiceType(XMLParseHelper.extractTagValue(doc, "InvoiceType"));
		// auditlogInfo(xmlBytes, invoiceAudit);
		saveInvoiceAudit(invoiceAudit);
		return invoiceAudit;
	}

	public void invoiceAuditUpdate(InvoiceAuditLog invoiceAudit, int auditId, String status, long startTime,
			String pdfFilePath) {
		invoiceAudit.setOverallStatus(status);
		invoiceAudit.setTotalExecutionDuration((System.nanoTime() - startTime) / 1000000);
		invoiceAudit.setOutputPdfFile(pdfFilePath);
		updateInvoiceAudit(auditId, invoiceAudit);
	}

	public void insertProcessingAuditSuccess(String currentStage, String functionName, long startTime, int auditId) {
		InvoiceProcessingAuditLog processAuditlog = new InvoiceProcessingAuditLog();
		processAuditlog.setExecutionStage(currentStage);
		processAuditlog.setFunctionName(functionName);
		processAuditlog.setStatus(FNSTATUS_COMPLETE);
		processAuditlog.setExecutionDuration((System.nanoTime() - startTime) / 1000000);
		processAuditlog.setAuditId(auditId);
		saveInvoiceProcessingAudit(processAuditlog);
	}

	public void insertProcessingAuditFailure(String currentStage, String functionName, long startTime, int auditId,
			String errorType, String errorMessage, String errorStack) {
		InvoiceProcessingAuditLog processAuditlog = new InvoiceProcessingAuditLog();
		processAuditlog.setExecutionStage(currentStage);
		processAuditlog.setFunctionName(functionName);
		processAuditlog.setStatus(FNSTATUS_FAILED);
		processAuditlog.setExecutionDuration((System.nanoTime() - startTime) / 1000000);
		processAuditlog.setAuditId(auditId);
		processAuditlog.setErrorType(errorType);
		processAuditlog.setErrorMessage(errorMessage);
		processAuditlog.setErrorStack(errorStack);
		saveInvoiceProcessingAudit(processAuditlog);
	}

	// Save into Invoice Audit Log
	public int saveInvoiceAudit(InvoiceAuditLog invoiceAudit) throws XMLExtractionException {
		try {
			InvoiceAuditLog savedAudit = auditRepository.save(invoiceAudit);
			return savedAudit.getId();
		} catch (Exception e) {
			throw new XMLExtractionException(
					"Exception occured while trying to save InvoiceAuditLog into database",
					XMLExtractionException.ErrorCode.XML_TAG_MISSING_EXCEPTION);
		}
	}

	// Update into Invoice Audit Log
	public void updateInvoiceAudit(int generatedId, InvoiceAuditLog invoiceAudit) {
		Optional<InvoiceAuditLog> existingAuditOptional = auditRepository.findById(generatedId);
		if (existingAuditOptional.isPresent()) {
			invoiceAudit.setId(generatedId);
			auditRepository.save(invoiceAudit);
		}
	}

	// Save into Invoice Processing Audit Log
	@Transactional
	public void saveInvoiceProcessingAudit(InvoiceProcessingAuditLog processAuditlog) {
		processingAuditRepository.saveAndFlush(processAuditlog);
	}

	private Document parseXml(byte[] byteXmlContent) throws XMLExtractionException {
		try {
			return XMLParseHelper.parseXml(byteXmlContent);
		} catch (Exception e) {
			throw new XMLExtractionException(
					"XML_PARSING_EXCEPTION occurred while parsing input XML",
					XMLExtractionException.ErrorCode.XML_PARSING_EXCEPTION, e);
		}
	}
}
