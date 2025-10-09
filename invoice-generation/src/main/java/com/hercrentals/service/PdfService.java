package com.hercrentals.service;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.core.env.Environment;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.w3c.dom.Document;

import com.hercrentals.dto.ProcessCurrentStage;
import com.hercrentals.exception.BarcodeGenerateException;
import com.hercrentals.exception.ErrorResponse;
import com.hercrentals.exception.HercSendMailException;
import com.hercrentals.exception.PDFGenerationException;
import com.hercrentals.exception.S3Exception;
import com.hercrentals.exception.SFTPException;
import com.hercrentals.exception.SnapPayDocUploadException;
import com.hercrentals.exception.SnapPayIntegrationException;
import com.hercrentals.exception.SnapPaySendPaymentLinkExecption;
import com.hercrentals.exception.XMLExtractionException;
import com.hercrentals.model.InvoiceAuditLog;
import com.hercrentals.utils.AmazonS3Helper;
import com.hercrentals.utils.XMLParseHelper;

@Service
public class PdfService {

    private final InvoiceAuditService auditService;
    private final GenerateInvoiceService invoiceService;
    private final DistributionService distributionService;

    private final Environment environment;
    private final AmazonS3Helper amazonS3Helper;

    public PdfService(InvoiceAuditService auditService, GenerateInvoiceService invoiceService,
            DistributionService distributionService, Environment environment, AmazonS3Helper amazonS3Helper) {
        this.auditService = auditService;
        this.invoiceService = invoiceService;
        this.distributionService = distributionService;
        this.environment = environment;
        this.amazonS3Helper = amazonS3Helper;
    }

    public ResponseEntity<?> generatePdfFromXml(byte[] xmlBytes, String functionName, String inputXmlFileSource, String apiVersion) {
        InvoiceAuditLog invoiceAudit = new InvoiceAuditLog();
        ProcessCurrentStage currentStage = new ProcessCurrentStage();
        // String rootFolderPath = System.getProperty("user.dir");
        long startTime = System.nanoTime();

        try {
            // Insert Audit Log
            invoiceAudit = auditService.insertAuditLog(xmlBytes, functionName, inputXmlFileSource,
                    new Timestamp(System.currentTimeMillis()), environment.getProperty("s3.bucket.name"), environment.getProperty("s3.bucket.name"));
            currentStage.setAuditId(invoiceAudit.getId());

            // XSD Validation
            String folderName = invoiceService.createFolderName(invoiceAudit);
            String invoiceFolder = environment.getProperty(folderName);
            // currentStage.setCurrentStage(ProcessCurrentStage.ProcessStage.SCHEMA_VALIDATION.name());
            // currentStage.setProcessStartTime(System.nanoTime());
            // byte[] xsdBytes = invoiceService.readFileToByteArray(
            //         rootFolderPath + "/fop_template/" + invoiceFolder + "/" + invoiceFolder + ".xsd");
            // // byte[] xsdBytes =
            // // invoiceService.readFileToByteArray(amazonS3Helper.getResourceLoc() + "/" +
            // // invoiceFolder + ".xsd");
            // XMLParseHelper.createSchemaAndValidateXML(xsdBytes, xmlBytes);
            // auditService.insertProcessingAuditSuccess(currentStage.getCurrentStage(), functionName,
            //         currentStage.getProcessStartTime(), currentStage.getAuditId());

            // Generate PDF
            String pdfFilePath = invoiceService.createPdfFilePath(amazonS3Helper, invoiceAudit);
            String pdfFileName = pdfFilePath.substring(pdfFilePath.lastIndexOf('/') + 1);
            // byte[] xslBytes = invoiceService.readFileToByteArray(rootFolderPath + "/fop_template/" + invoiceFolder + "/herc.xsl");
			byte[] xslBytes;
			if ("v3".equalsIgnoreCase(apiVersion) || "Lambda".equalsIgnoreCase(functionName)) {
				xslBytes = invoiceService.readFileToByteArray(amazonS3Helper.getResourceLoc() + "_v3/" + invoiceFolder + "/herc.xsl");
			} else {
				xslBytes = invoiceService.readFileToByteArray(amazonS3Helper.getResourceLoc() + "/" + invoiceFolder + "/herc.xsl");
			}
            currentStage.setCurrentStage(ProcessCurrentStage.ProcessStage.PDF_GENERATION.name());
            currentStage.setProcessStartTime(System.nanoTime());
            byte[] pdfData = invoiceService.pdfGenerator(amazonS3Helper, xmlBytes, xslBytes, invoiceFolder,
                    invoiceAudit, pdfFilePath, functionName);
            auditService.insertProcessingAuditSuccess(currentStage.getCurrentStage(), functionName,
                    currentStage.getProcessStartTime(), currentStage.getAuditId());

            // PDF Distribution
            Document xmlDocument = XMLParseHelper.parseXml(xmlBytes);
            List<String> distributionList = distributionService.parseDistributionList(xmlDocument);
            distributionService.distributePdf(pdfData, distributionList, pdfFileName, functionName, startTime,
                    currentStage, xmlDocument);
            auditService.invoiceAuditUpdate(invoiceAudit, currentStage.getAuditId(), "Completed", startTime,
                    pdfFilePath);

            // Response
            if ("Lambda".equalsIgnoreCase(functionName)) {
                Map<String, Object> response = new HashMap<>();
                response.put("status", "success");
                response.put("message", "Invoice processed successfully");
                amazonS3Helper.moveFile(inputXmlFileSource, amazonS3Helper.getArchiveXMLLoc());
                return ResponseEntity.ok().body(response);
            } else {
                HttpHeaders headers = new HttpHeaders();
                headers.setContentDispositionFormData("attachment", pdfFileName);
                headers.setContentType(MediaType.APPLICATION_PDF);

                return ResponseEntity.ok().headers(headers).body(pdfData);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            return handleException(ex, invoiceAudit, currentStage, functionName, startTime);
        }
    }

    private ResponseEntity<?> handleException(Exception ex, InvoiceAuditLog invoiceAudit,
            ProcessCurrentStage currentStage, String functionName, long startTime) {
        ErrorResponse errorResponse = new ErrorResponse(0, "", "");

        System.out.println("Exception occurred at stage : " + currentStage.getCurrentStage() + " :: " + ex);
        if (ex instanceof XMLExtractionException || ex.getCause() instanceof XMLExtractionException) {
            errorResponse.setStatus(HttpStatus.BAD_REQUEST.value());
            errorResponse.setError(XMLExtractionException.getErrorCode().toString());
            errorResponse.setMessage(ex.getMessage());
        } else if (ex instanceof BarcodeGenerateException) {
            errorResponse.setStatus(HttpStatus.INTERNAL_SERVER_ERROR.value());
            errorResponse.setError(BarcodeGenerateException.getErrorCode().toString());
            errorResponse.setMessage(ex.getMessage());
        } else if (ex instanceof PDFGenerationException) {
            errorResponse.setStatus(HttpStatus.INTERNAL_SERVER_ERROR.value());
            errorResponse.setError(PDFGenerationException.getErrorCode().toString());
            errorResponse.setMessage(ex.getMessage());
        } else if (ex instanceof S3Exception) {
            errorResponse.setStatus(HttpStatus.INTERNAL_SERVER_ERROR.value());
            errorResponse.setError(S3Exception.getErrorCode().toString());
            errorResponse.setMessage(ex.getMessage());
        } else if (ex instanceof IOException) {
            errorResponse.setStatus(HttpStatus.INTERNAL_SERVER_ERROR.value());
            errorResponse.setError("IO_EXCEPTION");
            errorResponse.setMessage(ex.getMessage());
        } else if (ex.getCause() instanceof HercSendMailException) {
            errorResponse.setStatus(HttpStatus.INTERNAL_SERVER_ERROR.value());
            errorResponse.setError(HercSendMailException.getErrorCode().toString());
            errorResponse.setMessage(ex.getMessage());
        } else if (ex.getCause() instanceof SnapPayIntegrationException cause) {
            errorResponse.setStatus(HttpStatus.INTERNAL_SERVER_ERROR.value());
            errorResponse.setError(SnapPayIntegrationException.getErrorCode().toString());
            errorResponse.setMessage(cause.getMessage());
        } else if (ex.getCause() instanceof SnapPayDocUploadException cause) {
            errorResponse.setStatus(HttpStatus.INTERNAL_SERVER_ERROR.value());
            errorResponse.setError(SnapPayDocUploadException.getErrorCode().toString());
            errorResponse.setMessage(cause.getMessage());
        } else if (ex.getCause() instanceof SnapPaySendPaymentLinkExecption cause) {
            errorResponse.setStatus(HttpStatus.INTERNAL_SERVER_ERROR.value());
            errorResponse.setError(SnapPaySendPaymentLinkExecption.getErrorCode().toString());
            errorResponse.setMessage(cause.getMessage());   
        } else if (ex.getCause() instanceof SFTPException cause) {
            errorResponse.setStatus(HttpStatus.INTERNAL_SERVER_ERROR.value());
            errorResponse.setError(SFTPException.getErrorCode().toString());
            errorResponse.setMessage(cause.getMessage());
        } else {
            errorResponse.setStatus(HttpStatus.INTERNAL_SERVER_ERROR.value());
            errorResponse.setError("GENERIC_EXCEPTION");
            errorResponse.setMessage(ex.getMessage());
        }

        auditService.invoiceAuditUpdate(invoiceAudit, currentStage.getAuditId(), "Failed", startTime, "");
        auditService.insertProcessingAuditFailure(currentStage.getCurrentStage(), functionName,
                currentStage.getProcessStartTime(), currentStage.getAuditId(), errorResponse.getError(), ex.getMessage(),
                Arrays.toString(ex.getStackTrace()));

        return ResponseEntity.status(errorResponse.getStatus()).body(errorResponse);
    }

}
