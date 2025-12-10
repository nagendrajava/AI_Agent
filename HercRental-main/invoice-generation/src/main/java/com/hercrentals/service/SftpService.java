package com.hercrentals.service;

import java.io.ByteArrayInputStream;
import java.util.Properties;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.retry.annotation.Backoff;
import org.springframework.retry.annotation.Retryable;
import org.springframework.stereotype.Service;

import com.hercrentals.dto.ProcessCurrentStage;
import com.hercrentals.exception.SFTPException;
import com.jcraft.jsch.ChannelSftp;
import com.jcraft.jsch.JSch;
import com.jcraft.jsch.Session;

@Service
public class SftpService {
    private static final Logger log = LoggerFactory.getLogger(SftpService.class);

    private final InvoiceAuditService invoiceAuditService;

    public SftpService(InvoiceAuditService invoiceAuditService) {
        this.invoiceAuditService = invoiceAuditService;
    }

    @Value("${sftp.host}")
    private String sftpHost;

    @Value("${sftp.port}")
    private int sftpPort;

    @Value("${sftp.username}")
    private String sftpUsername;

    @Value("${sftp.password}")
    private String sftpPassword;

    @Value("${sftp.remote-dir}")
    private String sftpRemoteDir;

    @Retryable(value = { SFTPException.class }, maxAttempts = 3, backoff = @Backoff(delay = 1000))
    public void uploadPdfToSftp(byte[] pdfData, String fileName, String functionName, ProcessCurrentStage currentStage)
            throws SFTPException {

        currentStage.setCurrentStage(ProcessCurrentStage.ProcessStage.SFTP_INVOICE_UPLOAD.name());
        currentStage.setProcessStartTime(System.nanoTime());

        Session session = null;
        ChannelSftp channelSftp = null;

        try {

            JSch jsch = new JSch();
            session = jsch.getSession(sftpUsername, sftpHost, sftpPort);
            session.setPassword(sftpPassword);

            Properties config = new Properties();
            config.put("StrictHostKeyChecking", "no");
            session.setConfig(config);
            session.connect();

            channelSftp = (ChannelSftp) session.openChannel("sftp");
            channelSftp.connect();
            channelSftp.cd(sftpRemoteDir);

            // Upload PDF from byte array
            ByteArrayInputStream inputStream = new ByteArrayInputStream(pdfData);
            channelSftp.put(inputStream, fileName);
            System.out.println("File uploaded successfully: " + fileName);
            log.info("File uploaded successfully: {}", fileName);

            invoiceAuditService.insertProcessingAuditSuccess(
                    currentStage.getCurrentStage(), functionName, currentStage.getProcessStartTime(),
                    currentStage.getAuditId());

        } catch (Exception e) {
            e.printStackTrace();
            log.error("Exception occurred while uploading PDF to SFTP: {}", e.getMessage());
            throw new SFTPException("Exception occurred while uploading PDF to SFTP: " + e.getMessage(),
                    SFTPException.ErrorCode.SFTP_UPLOAD_EXCEPTION, e);
        } finally {
            if (channelSftp != null && channelSftp.isConnected()) {
                channelSftp.disconnect();
            }
            if (session != null && session.isConnected()) {
                session.disconnect();
            }
        }
    }
}
