package com.hercrentals.service;

import java.util.Collections;
import java.util.HashMap;
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
import com.hercrentals.exception.SnapPayIntegrationException;
import com.hercrentals.exception.SnapPaySendPaymentLinkExecption;
import com.hercrentals.exception.XMLExtractionException;
import com.hercrentals.utils.HmacGenerator;
import com.hercrentals.utils.XMLParseHelper;

@Service
public class FiservPaymentLinkService {
    private static final Logger log = LoggerFactory.getLogger(FiservPaymentLinkService.class);

    @Value("${snappay.sendpaymentlink.url}")
    private String sendPaymentLinkUrl;

    @Value("${snappay.accountid}")
    private String accountId;

    @Value("${snappay.secretkey}")
    private String secretKey;

    @Value("${snappay.username}")
    private String username;

    @Value("${snappay.password}")
    private String password;

    @Value("${snappay.payment.url}")
    private String paymentUrl;

    @Value("${snappay.merchantid}")
    private String merchantId;

    @Value("${snappay.email}")
    private String email;

    @Retryable(value = SnapPayIntegrationException.class, maxAttempts = 3, backoff = @Backoff(delay = 1000))
    public String generatePaymentLink(Document xmlDocument, ProcessCurrentStage currentStage)
            throws SnapPayIntegrationException, XMLExtractionException, Exception {
        currentStage.setCurrentStage(ProcessCurrentStage.ProcessStage.EMAIL_DISTRIBUTION.name());
        System.out.println(">>>>> Inside Fiserv Payment Link Service...");

        String companyCode = null;
        String currencyCode = null;
        String userId = null;
        String transactionType = null;
        String paymentMode = null;
        String transactionAmount = null;
        String customerid = null;

        try {
            companyCode = XMLParseHelper.extractTagValue(xmlDocument, "CompanyCode");
            currencyCode = XMLParseHelper.extractTagValue(xmlDocument, "Currency");
            userId = XMLParseHelper.extractTagValue(xmlDocument, "CustNo") + "CSR";
            transactionType = XMLParseHelper.extractTagValue(xmlDocument, "TransactionType");
            paymentMode = XMLParseHelper.extractTagValue(xmlDocument, "PaymentMode");
            String invoiceType = XMLParseHelper.extractTagValue(xmlDocument, "InvoiceType");
            if ("STATEMENT OF INVOICE".equalsIgnoreCase(invoiceType)) {
                transactionAmount = XMLParseHelper.extractTagValue(xmlDocument, "TotalDues");
            } else {
                transactionAmount = XMLParseHelper.extractTagValue(xmlDocument, "InvoiceAmount");
            }
            transactionAmount = (transactionAmount != null) ? transactionAmount.replaceAll("[^0-9.]", "") : null;
            customerid = XMLParseHelper.extractTagValue(xmlDocument, "CustNo");
        } catch (XMLExtractionException e) {
            throw new XMLExtractionException("Exception occurred while parsing XML: " + e.getMessage(),
                    XMLExtractionException.ErrorCode.XML_TAG_MISSING_EXCEPTION);
        }

        try {
            RestTemplate restTemplate = new RestTemplate();

            // Create request body as a JSON object
            Map<String, Object> requestBody = new HashMap<>();
            requestBody.put("accountid", accountId);
            requestBody.put("companycode", companyCode);
            requestBody.put("currencycode", currencyCode);
            requestBody.put("userid", userId);
            requestBody.put("transactiontype", transactionType);
            requestBody.put("mode", paymentMode);
            requestBody.put("email", email);
            requestBody.put("language", "en-US");
            requestBody.put("transactionamount", transactionAmount);
            requestBody.put("customerid", customerid);

            ObjectMapper objectMapper = new ObjectMapper();
            String jsonPayload = objectMapper.writeValueAsString(requestBody);

            // Generate HMAC signature
            String signature = HmacGenerator.generateHmac(sendPaymentLinkUrl, "POST", jsonPayload, secretKey,
                    accountId);
            System.out.println("Signature: " + signature);

            // Set headers
            HttpHeaders headers = new HttpHeaders();
            headers.setBasicAuth(username, password);
            headers.set("accountid", accountId);
            headers.set("signature", signature);
            headers.set("merchantid", merchantId);
            headers.setContentType(MediaType.APPLICATION_JSON);
            headers.setAccept(Collections.singletonList(MediaType.APPLICATION_JSON));

            // Create request entity
            HttpEntity<String> requestEntity = new HttpEntity<>(jsonPayload, headers);

            // Send POST request
            ResponseEntity<String> response = restTemplate.exchange(sendPaymentLinkUrl, HttpMethod.POST, requestEntity,
                    String.class);

            String responseBody = response.getBody();
            System.out.println("Response: " + response.getStatusCode());
            System.out.println("Response Body: " + response.getBody());
            Map<String, Object> responseMap = objectMapper.readValue(responseBody,
                    new TypeReference<Map<String, Object>>() {
                    });
            String status = (String) responseMap.get("status");

            if ("Y".equals(status)) {
                String requestId = (String) responseMap.get("requestid");
                return paymentUrl + requestId;
            } else {
                String message = (String) responseMap.get("message");
                throw new SnapPaySendPaymentLinkExecption(
                        "Exception occurred while generating payment link :: " + message,
                        SnapPaySendPaymentLinkExecption.ErrorCode.SNAPPAY_SEND_PAYMENT_LINK_EXCEPTION);
            }
        } catch (SnapPaySendPaymentLinkExecption e) {
            log.error("Received exception while generating payment link :: " + e.getMessage(), e);
            throw e;
        } catch (Exception e) {
            log.error("Exception occurred while generating payment link :: " + e.getMessage(), e);
            throw new SnapPayIntegrationException(
                    "Exception occurred while generating payment link :: " + e.getMessage(),
                    SnapPayIntegrationException.ErrorCode.SNAP_PAY_INTEGRATION_EXCEPTION, e);
        }
    }

}
