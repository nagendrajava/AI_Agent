package com.hercrentals.dto;

public class ProcessCurrentStage {

    public enum ProcessStage {
        SCHEMA_VALIDATION, PDF_GENERATION, EMAIL_DISTRIBUTION, SNAPPAY_INVOICE_UPLOAD, SFTP_INVOICE_UPLOAD, PRINTER
    }

    private ProcessStage processStage;
    private String currentStage;
    private long processStartTime;
    private int auditId;

    public long getProcessStartTime() {
        return processStartTime;
    }

    public void setProcessStartTime(long processStartTime) {
        this.processStartTime = processStartTime;
    }

    public String getCurrentStage() {
        return currentStage;
    }

    public void setCurrentStage(String currentStage) {
        this.currentStage = currentStage;
    }

    public ProcessStage getProcessStage() {
        return processStage;
    }

    public void setProcessStage(ProcessStage processStage) {
        this.processStage = processStage;
    }

    public int getAuditId() {
        return auditId;
    }

    public void setAuditId(int auditId) {
        this.auditId = auditId;
    }

}
