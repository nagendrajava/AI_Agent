package com.hercrentals.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.hercrentals.dto.InvoiceRequest;
import com.hercrentals.service.PdfService;
import com.hercrentals.utils.AmazonS3Helper;

@Controller
@RequestMapping("herc")
public class GenerateInvoiceController {
	private static final Logger log = LoggerFactory.getLogger(GenerateInvoiceController.class.getName());

	private final PdfService pdfService;
	private final AmazonS3Helper amazonS3Helper;
	private static final String API = "API";
	private static final String LAMBDA = "Lambda";
	String inputXmlFileSource = "XML received from API request";

	public GenerateInvoiceController(PdfService pdfService, AmazonS3Helper amazonS3Helper) {
		this.pdfService = pdfService;
		this.amazonS3Helper = amazonS3Helper;
	}

	// API for multipart xml input file
	@PostMapping("/api/invoice/generate")
	public ResponseEntity<?> handleFileUpload(@RequestParam("xmlFile") MultipartFile xmlFile) {
		try {
			return pdfService.generatePdfFromXml(xmlFile.getBytes(), API, inputXmlFileSource, "v1");
		} catch (Exception e) {
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(e.getMessage());
		}
	}

	// API for String xml input
	@PostMapping("/api/v2/invoice/generate")
	public ResponseEntity<?> handleFileUploadv2(@RequestParam("xmlFile") String xmlFile) {
		try {
			return pdfService.generatePdfFromXml(xmlFile.getBytes(), API, inputXmlFileSource, "v2");
		} catch (Exception e) {
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(e.getMessage());
		}
	}

	// API for latest XSL & XML changes
	@PostMapping("/api/v3/invoice/generate")
	public ResponseEntity<?> handleFileUploadv3(@RequestParam("xmlFile") String xmlFile) {
		try {
			return pdfService.generatePdfFromXml(xmlFile.getBytes(), API, inputXmlFileSource, "v3");
		} catch (Exception e) {
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(e.getMessage());
		}
	}

	@PostMapping("/lambda/generateInvoice")
	public ResponseEntity<?> generateInvoice(@RequestBody InvoiceRequest invoiceRequest) {
		try {
			log.info("Inside Lambda function, invoiceRequest: " + invoiceRequest.toString());
			byte[] xmlBytes = amazonS3Helper.readS3File(invoiceRequest.getBucketName(), invoiceRequest.getObjectKey());
			return pdfService.generatePdfFromXml(xmlBytes, LAMBDA, invoiceRequest.getObjectKey(), "v3");
		} catch (Exception e) {
			amazonS3Helper.moveFile(invoiceRequest.getObjectKey(), amazonS3Helper.getRejectedXMLLoc());
			e.printStackTrace();
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(e.getMessage());
		}
	}
}
