package com.hercrentals.service;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.w3c.dom.Document;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import com.hercrentals.dto.ProcessCurrentStage;
import com.hercrentals.exception.XMLExtractionException;
import com.hercrentals.utils.XMLParseHelper;

@Service
public class DistributionService {
    private static final Logger log = LoggerFactory.getLogger(DistributionService.class);

    private final EmailService emailService;
    private final SftpService sftpService;
    private final FiservDocumentUploadService fiservDocumentUploadService;
    private final PrinterService printerService;

    public DistributionService(EmailService emailService, SftpService sftpService,
            FiservDocumentUploadService fiservDocumentUploadService, PrinterService printerService) {
        this.emailService = emailService;
        this.sftpService = sftpService;
        this.fiservDocumentUploadService = fiservDocumentUploadService;
        this.printerService = printerService;
    }

    // Get the distribution list from the XML document
    public List<String> parseDistributionList(Document xmlDocument) throws XMLExtractionException {
        Set<String> distributionSet = new HashSet<>();
        NodeList distributionNodes = xmlDocument.getElementsByTagName("Distribution").item(0).getChildNodes();
        Set<String> checkYesTags = Set.of("SnapPay", "AWSS3", "Filenet", "IFSFolder", "FiservSFTP");

        for (int i = 0; i < distributionNodes.getLength(); i++) {
            Node node = distributionNodes.item(i);
            if (node.getNodeType() == Node.ELEMENT_NODE) {
                String nodeName = node.getNodeName();
                if (checkYesTags.contains(nodeName)) {
                    String nodeValue = XMLParseHelper.extractTagValue(xmlDocument, nodeName);
                    if ("yes".equalsIgnoreCase(nodeValue)) {
                        distributionSet.add(nodeName);
                    }
                } else {
                    distributionSet.add(nodeName);
                }
            }
        }
        return new ArrayList<>(distributionSet);
    }

    public void distributePdf(byte[] pdfData, List<String> distributionList, String pdfFileName, String functionName,
            long startTime, ProcessCurrentStage currentStage, Document xmlDocument) {

        try {
            for (String distributionType : distributionList) {
                switch (distributionType.toLowerCase()) {
                    case "emails":
                        emailService.distributeEmail(pdfData, xmlDocument, pdfFileName, functionName, currentStage);
                        break;
                    case "snappay":
                        fiservDocumentUploadService.uploadDocument(pdfData, xmlDocument, pdfFileName, functionName,
                                currentStage);
                        break;
                    case "fiservsftp":
                        sftpService.uploadPdfToSftp(pdfData, pdfFileName, functionName, currentStage);
                        break;
                    case "printers":
                        printerService.distributePrinter(pdfData, xmlDocument, functionName, currentStage);
                        break;
                    case "awss3":
                        break;
                    case "filenet":
                        break;
                    case "ifsfolder":
                        break;
                    case "faxes":
                        break;
                    default:
                        log.info("Unknown distribution type: {}", distributionType);
                        break;
                }
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    /*
    Distribute the PDF to the distribution list
    public void distributePdf(byte[] pdfData, List<String> distributionList, String pdfFileName, String functionName,
            long startTime, ProcessCurrentStage currentStage, Document xmlDocument) {
        List<CompletableFuture<Void>> futures = new ArrayList<>();

        for (String distributionType : distributionList) {
            CompletableFuture<Void> future = CompletableFuture.runAsync(() -> {
                try {
                    switch (distributionType) {
                        case "Email":
                            emailService.distributeEmail(pdfData, xmlDocument, pdfFileName, functionName, currentStage);
                            break;
                        case "SnapPay":
                            fiservDocumentUploadService.uploadDocument(pdfData, xmlDocument, pdfFileName, functionName, currentStage);
                            break;
                        case "sftp":
                            sftpService.uploadPdfToSftp(pdfData, pdfFileName);
                            break;
                        case "Printer":
                            distributePrinter(pdfData, xmlDocument, functionName, startTime, currentStage);
                            break;
                        default:
                            log.info("Unknown distribution type: {}", distributionType);
                            break;
                    }
                } catch (Exception e) {
                    throw new RuntimeException(e);
                }
            });
            futures.add(future);
        }

        try {
            CompletableFuture.allOf(futures.toArray(new CompletableFuture[0])).join();
        } catch (CompletionException e) {
            throw (e.getCause() instanceof RuntimeException) ? (RuntimeException) e.getCause()
                    : new RuntimeException(e.getCause());
        }
    }
    */

}
