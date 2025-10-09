package com.hercrentals.service;

import java.util.Collections;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.retry.annotation.Backoff;
import org.springframework.retry.annotation.Retryable;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import org.w3c.dom.Document;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.hercrentals.dto.ProcessCurrentStage;
import com.hercrentals.exception.SnapPayDocUploadException;
import com.hercrentals.exception.SnapPayIntegrationException;
import com.hercrentals.exception.XMLExtractionException;
import com.hercrentals.utils.HmacGenerator;
import com.hercrentals.utils.XMLParseHelper;

@Service
public class FiservDocumentUploadService {
    private static final Logger log = LoggerFactory.getLogger(FiservDocumentUploadService.class);

    private final InvoiceAuditService invoiceAuditService;

    public FiservDocumentUploadService(InvoiceAuditService invoiceAuditService) {
        this.invoiceAuditService = invoiceAuditService;
    }

    @Value("${snappay.documentupload.url}")
    private String documentUploadUrl;

    @Value("${snappay.uploadstatus.url}")
    private String uploadStatusUrl;

    @Value("${snappay.accountid}")
    private String accountId;

    @Value("${snappay.secretkey}")
    private String secretKey;

    @Value("${snappay.username}")
    private String username;

    @Value("${snappay.password}")
    private String password;

    @Value("${snappay.uploadstatus.maxretries}")
    private int maxRetries;

    @Value("${snappay.uploadstatus.retryinterval}")
    private long retryInterval;

    @Retryable(value = { SnapPayIntegrationException.class }, maxAttempts = 3, backoff = @Backoff(delay = 1000))
    public void uploadDocument(byte[] pdfData, Document xmlDocument, String pdfFileName, String functionName,
            ProcessCurrentStage currentStage) throws Exception {

        currentStage.setCurrentStage(ProcessCurrentStage.ProcessStage.SNAPPAY_INVOICE_UPLOAD.name());
        currentStage.setProcessStartTime(System.nanoTime());

        System.out.println(">>>>> Inside SnapPay Dcoument Upload...");
        String invoiceNumber = "";
        String customerid = null;
        String documentType = null;
        String companyCode = null;
        String documentName = null;
        String documentCode = null;
        String fiscalYear = null;

        try {
            String invoiceType = XMLParseHelper.extractTagValue(xmlDocument, "InvoiceType");
            if ("STATEMENT OF INVOICE".equalsIgnoreCase(invoiceType)) {
                invoiceNumber = "";
            } else {
                invoiceNumber = XMLParseHelper.extractTagValue(xmlDocument, "InvoiceNo");
            }
            customerid = XMLParseHelper.extractTagValue(xmlDocument, "CustNo");
            documentType = XMLParseHelper.extractTagValue(xmlDocument, "DocumentType");
            companyCode = XMLParseHelper.extractTagValue(xmlDocument, "CompanyCode");
            documentCode = XMLParseHelper.extractTagValue(xmlDocument, "DocumentCode");
            fiscalYear = XMLParseHelper.extractTagValue(xmlDocument, "FiscalYear");
        } catch (XMLExtractionException e) {
            throw new XMLExtractionException("Exception occurred while parsing XML: " + e.getMessage(),
                    XMLExtractionException.ErrorCode.XML_TAG_MISSING_EXCEPTION);
        }

        try {
            RestTemplate restTemplate = new RestTemplate();

            // Convert PDF bytes to Base64
            // String pdfBase64 = Base64.getEncoder().encodeToString(pdfData);
            documentName = removeFileNameSpecialCharacters(pdfFileName);

            // Create request body as a JSON object
            Map<String, Object> requestBody = new LinkedHashMap<>();
            requestBody.put("accountid", accountId);
            requestBody.put("documentid", invoiceNumber);
            requestBody.put("customerid", customerid);
            requestBody.put("documenttype", documentType);
            requestBody.put("companycode", companyCode);
            requestBody.put("documentname", documentName);
            requestBody.put("invoiceorstatement", documentCode);
            requestBody.put("fiscalyear", fiscalYear);
            // requestBody.put("size", 0);
            // requestBody.put("url", "");
            // requestBody.put("filename", "");
            requestBody.put("content", pdfData);

            ObjectMapper objectMapper = new ObjectMapper();
            String jsonPayload = objectMapper.writeValueAsString(requestBody);

            // Generate HMAC signature
            String signature = HmacGenerator.generateHmac(documentUploadUrl, "POST", jsonPayload, secretKey, accountId);
            System.out.println("Doc upload Signature: " + signature);

            // Set headers
            HttpHeaders headers = new HttpHeaders();
            headers.setBasicAuth(username, password);
            headers.set("accountid", accountId);
            headers.set("signature", signature);
            headers.setContentType(MediaType.APPLICATION_JSON);
            headers.setAccept(Collections.singletonList(MediaType.APPLICATION_JSON));

            // Create request entity
            HttpEntity<String> requestEntity = new HttpEntity<>(jsonPayload, headers);

            // Send POST request
            ResponseEntity<String> response = restTemplate.exchange(documentUploadUrl, HttpMethod.POST, requestEntity,
                    String.class);
            String responseBody = response.getBody();
            System.out.println("Doc upload Response Body: " + response.getBody());
            Map<String, Object> responseMap = objectMapper.readValue(responseBody,
                    new TypeReference<Map<String, Object>>() {
                    });
            Boolean hasErrors = (Boolean) responseMap.get("HasErrors");
            String requestId = (String) responseMap.get("RequestId");

            if (hasErrors) {
                List<Map<String, Object>> errors = (List<Map<String, Object>>) responseMap.get("Errors");

                String errorMessage = "Unknown error occurred";
                if (errors != null && !errors.isEmpty()) {
                    errorMessage = (String) errors.get(0).get("Error"); // Extracting the first error message
                }
                log.error("Having error while uploading document to SnapPay :: {}", errorMessage);
                throw new SnapPayDocUploadException(
                        "Error while uploading document to SnapPay :: " + errorMessage,
                        SnapPayDocUploadException.ErrorCode.SNAPPAY_DOCUMENT_UPLOAD_EXCEPTION);
            }

            // int maxRetries = 3;
            // long retryInterval = 1000; // 1 seconds interval
            int attempt = 0;

            while (attempt < maxRetries) {
                attempt++;

                Map<String, Object> statusRequestBody = new LinkedHashMap<>();
                statusRequestBody.put("accountid", accountId);
                statusRequestBody.put("requestid", requestId);
                String statusPayload = objectMapper.writeValueAsString(statusRequestBody);

                // Generate HMAC signature
                signature = HmacGenerator.generateHmac(uploadStatusUrl, "POST", statusPayload, secretKey,
                        accountId);
                System.out.println("Status Signature: " + signature);

                // Set headers
                HttpHeaders statusHeaders = new HttpHeaders();
                statusHeaders.setBasicAuth(username, password);
                statusHeaders.set("accountid", accountId);
                statusHeaders.set("signature", signature);
                statusHeaders.setContentType(MediaType.APPLICATION_JSON);
                statusHeaders.setAccept(Collections.singletonList(MediaType.APPLICATION_JSON));

                // Create request entity
                HttpEntity<String> statusRequestEntity = new HttpEntity<>(statusPayload, statusHeaders);

                // Send POST request
                ResponseEntity<String> statusResponse = restTemplate.exchange(uploadStatusUrl, HttpMethod.POST,
                        statusRequestEntity,
                        String.class);
                String statusResponseBody = statusResponse.getBody();
                responseMap = objectMapper.readValue(statusResponseBody,
                        new TypeReference<Map<String, Object>>() {
                        });
                String status = (String) responseMap.get("status");

                if (!"F".equals(status)) {
                    System.out.println("Invoice uploaded successfully to SnapPay");
                    log.info("Invoice uploaded successfully to SnapPay");
                    invoiceAuditService.insertProcessingAuditSuccess(
                            currentStage.getCurrentStage(), functionName, currentStage.getProcessStartTime(),
                            currentStage.getAuditId());
                    return;
                }

                if (attempt < maxRetries) {
                    System.out.println("Retrying status check in " + retryInterval / 1000 + " seconds...");
                    log.info("Retrying status check in " + retryInterval / 1000 + " seconds...");
                    Thread.sleep(retryInterval); // Wait before retrying
                }
            }
            log.error("Getting document upload status failed after " + maxRetries + " attempts also.");
            throw new SnapPayDocUploadException(
                    "Document upload status failed.",
                    SnapPayDocUploadException.ErrorCode.SNAPPAY_DOCUMENT_UPLOAD_EXCEPTION);
        } catch (SnapPayDocUploadException e) {
            log.error("Received exception while uploading document to SnapPay :: " + e.getMessage(), e);
            throw e;
        } catch (Exception e) {
            log.error("Exception occurred while uploading document to SnapPay :: " + e.getMessage(), e);
            throw new SnapPayIntegrationException(
                    "Exception occurred while uploading document to SnapPay :: " + e.getMessage(),
                    SnapPayIntegrationException.ErrorCode.SNAP_PAY_INTEGRATION_EXCEPTION, e);
        }
    }

    private String removeFileNameSpecialCharacters(String pdfFileName) {
        int lastDotIndex = pdfFileName.lastIndexOf('.');
        String name = pdfFileName.substring(0, lastDotIndex);
        String extension = pdfFileName.substring(lastDotIndex);

        // Remove all special characters from name
        String cleanedName = name.replaceAll("[^a-zA-Z0-9]", "");

        // Combine cleaned name & extension
        return cleanedName + extension;
    }
}
