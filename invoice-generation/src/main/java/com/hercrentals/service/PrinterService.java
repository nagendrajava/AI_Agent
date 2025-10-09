package com.hercrentals.service;

import java.util.List;
import java.util.Map;
import java.util.logging.Logger;

import org.springframework.stereotype.Service;
import org.w3c.dom.Document;

import com.hercrentals.dto.ProcessCurrentStage;
import com.hercrentals.exception.PDFGenerationException;
import com.hercrentals.utils.XMLParseHelper;

@Service
public class PrinterService {
    private static final Logger log = Logger.getLogger(PrinterService.class.getName());
    private final InvoiceAuditService invoiceAuditService;

    public PrinterService(InvoiceAuditService invoiceAuditService) {
        this.invoiceAuditService = invoiceAuditService;
    }

    public void distributePrinter(byte[] pdfData, Document xmlDocument, String functionName,
            ProcessCurrentStage currentStage) throws PDFGenerationException {
        currentStage.setCurrentStage(ProcessCurrentStage.ProcessStage.PRINTER.name());
        currentStage.setProcessStartTime(System.nanoTime());

        List<Map<String, String>> printerDetails = XMLParseHelper.parseMultipleTags(xmlDocument, "Printer", Map.of(
                "PrinterIP", "PrinterIP"));
        for (Map<String, String> printerData : printerDetails) {
            String printerIP = printerData.get("PrinterIP");
            try {
                log.info("Printed successfully: " + printerIP);
                // distributionService.printPdf(pdfData, printerIP);
            } catch (Exception e) {
                e.printStackTrace();
                throw new PDFGenerationException("Exception occurred while generating pdf :: " + e.getMessage(),
                        PDFGenerationException.ErrorCode.PDF_GENERTION_EXCEPTION, e);
            }
        }
        invoiceAuditService.insertProcessingAuditSuccess(currentStage.getCurrentStage(), functionName,
                currentStage.getProcessStartTime(), currentStage.getAuditId());
    }

}
