package com.hercrentals.service;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.w3c.dom.Document;

import com.hercrentals.dto.ProcessCurrentStage;
import com.hercrentals.exception.HercSendMailException;
import com.hercrentals.exception.SnapPayIntegrationException;
import com.hercrentals.exception.XMLExtractionException;
import com.hercrentals.utils.SendMail;
import com.hercrentals.utils.XMLParseHelper;

@Service
public class EmailService {

    private static final Logger log = LoggerFactory.getLogger(EmailService.class);

    private final SendMail sendMail;
    private final InvoiceAuditService invoiceAuditService;
    private final FiservPaymentLinkService fiservPaymentLinkService;

    public EmailService(SendMail sendMail, InvoiceAuditService invoiceAuditService,
            FiservPaymentLinkService fiservPaymentLinkService) {
        this.sendMail = sendMail;
        this.invoiceAuditService = invoiceAuditService;
        this.fiservPaymentLinkService = fiservPaymentLinkService;
    }

    void distributeEmail(byte[] pdfData, Document xmlDocument, String pdfFileName,
            String functionName, ProcessCurrentStage currentStage) throws Exception {

        currentStage.setCurrentStage(ProcessCurrentStage.ProcessStage.EMAIL_DISTRIBUTION.name());
        currentStage.setProcessStartTime(System.nanoTime());

        // Checking if any email id is present to avoid generating payment link for
        // empty email id
        Set<String> toEmailSet = new HashSet<>();
        Set<String> ccEmailSet = new HashSet<>();

        List<Map<String, String>> emailDetails = XMLParseHelper.parseMultipleTags(xmlDocument, "Email", Map.of(
                "EmailTo", "EmailTo",
                "EmailCC", "EmailCC"));

        if (emailDetails.isEmpty()) {
            log.info("No email details found for distribution.");
            return;
        }

        for (Map<String, String> emailData : emailDetails) {
            String emailTo = emailData.getOrDefault("EmailTo", "").trim();
            String emailCC = emailData.getOrDefault("EmailCC", "").trim();

            if (!emailTo.isEmpty()) {
                toEmailSet.add(emailTo);
            }

            if (!emailCC.isEmpty()) {
                ccEmailSet.add(emailCC);
            }
        }

        if (toEmailSet.isEmpty()) {
            log.info("No valid email recipients found. Skipping email distribution.");
            return;
        }

        // Generate payment link
        String paymentLink = null;
        String invoiceAmount = null;
        String name = null;
        String accountNumber = null;
        String invoiceNumber = null;
        String poNumber = "";

        try {
            String invoiceType = XMLParseHelper.extractTagValue(xmlDocument, "InvoiceType");
            if ("STATEMENT OF INVOICE".equalsIgnoreCase(invoiceType)) {
                invoiceAmount = XMLParseHelper.extractTagValue(xmlDocument, "TotalDues");
                invoiceNumber = "";
                poNumber = "";
            } else {
                invoiceAmount = XMLParseHelper.extractTagValue(xmlDocument, "InvoiceAmount");
                invoiceNumber = XMLParseHelper.extractTagValue(xmlDocument, "InvoiceNo");
                poNumber = XMLParseHelper.extractTagValueWithEmpty(xmlDocument, "PO");
            }
            name = XMLParseHelper.extractTagValue(xmlDocument, "Name");
            accountNumber = XMLParseHelper.extractTagValue(xmlDocument, "AcctNo");
            invoiceAmount = (invoiceAmount != null) ? invoiceAmount.replaceAll("[^0-9.]", "") : null;

            double amount = Double.parseDouble(invoiceAmount);

            if (amount > 0) {
                paymentLink = fiservPaymentLinkService.generatePaymentLink(xmlDocument, currentStage);
            }
        } catch (XMLExtractionException | SnapPayIntegrationException e) {
            log.error("Exception occurred while parsing XML: {}", e.getMessage());
            throw e;
        } catch (NumberFormatException e) {
            log.error("Exception occurred while parsing XML: {}", e.getMessage());
            throw new XMLExtractionException("Exception occurred while parsing XML: " + e.getMessage(),
                    XMLExtractionException.ErrorCode.XML_PARSING_EXCEPTION);
        } catch (Exception e) {
            throw e;
        }

        // Prepare email
        try {
            // Email lists
            List<String> toEmailList = new ArrayList<>(toEmailSet);
            List<String> ccEmailList = new ArrayList<>(ccEmailSet);

            // Attachment
            List<byte[]> attachments = Collections.singletonList(pdfData);

            // Message body
            StringBuilder emailBody = new StringBuilder();
            emailBody.append("<html><body>");
            emailBody.append("<h3>Herc Rentals Inc.</h3><br>");
            emailBody.append("<p>Dear <b>").append(name).append(",</b></p>");

            if (paymentLink != null) {
                emailBody.append(
                        "<p>Attached are your Invoices from Herc Rentals Inc.. You can make a payment securely with Herc Rentals Inc. online bill payments or click the below Pay Invoice Link for One Time Payments.</p>"
                                + "<a href=\"" + paymentLink + "\">Pay Invoice</a><br>");
            } else {
                emailBody.append(
                        "<p>Attached are your Invoices from Herc Rentals Inc.. You can make a payment securely with Herc Rentals Inc. online bill payments.</p><br>");
            }

            emailBody.append("<div style='padding-left:50%'>")
                    .append("<img src='cid:logo' alt='Herc Rentals Logo' style='width:150px; height:auto;'>")
                    .append("</div><br>");
            emailBody.append("<p><b>Account Number : </b>").append(accountNumber).append("</p>");
            emailBody.append("<table style='border-collapse: collapse; width: 50%; text-align: left;'>");
            emailBody.append("<tr><th>INVOICE NUMBER</th><th>PO NUMBER</th><th>AMOUNT</th></tr>");
            emailBody.append("<tr><td style='padding: 5px;'>").append(invoiceNumber).append("</td>");
            emailBody.append("<td style='padding: 5px;'>").append(poNumber).append("</td>");
            emailBody.append("<td style='padding: 5px;'>").append("$ ").append(invoiceAmount).append("</td></tr>");
            emailBody.append("</table><br><br>");
            emailBody.append("<p><b>Notes:</b></p>");
            emailBody.append(
                    "<p><small>Please Note: We use the industry standard PDF format for storing and displaying bills. This makes it very easy to print or save your bill to your PC. If you're unable to view this attachment, please click here to get the latest version of the free <a href=\"https://get.adobe.com/reader/\">Acrobat Reader</a>.</small></p><br>");
            emailBody.append("<p>Sincerely,</p>");
            emailBody.append("<p>Herc Rentals Inc.</p>");
            emailBody.append("</body></html>");

            // Calling email service
            sendMail.sendEMail(toEmailList, ccEmailList, attachments, pdfFileName, emailBody.toString());
            System.out.println("Email sent successfully to: {}" + toEmailList);

        } catch (Exception e) {
            log.error("Exception occurred while sending email: {}", e.getMessage());
            throw new HercSendMailException("Exception occurred while sending email :: " + e.getMessage(),
                    HercSendMailException.ErrorCode.MESSAGING_EXCEPTION, e);
        }

        invoiceAuditService.insertProcessingAuditSuccess(
                currentStage.getCurrentStage(), functionName, currentStage.getProcessStartTime(),
                currentStage.getAuditId());
    }

}
