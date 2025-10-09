package com.hercrentals.exception;

public class SnapPayDocUploadException extends Exception {
    private static final long serialVersionUID = 1L;

    public enum ErrorCode {
        SNAPPAY_DOCUMENT_UPLOAD_EXCEPTION
    }

    private static ErrorCode errorCode;

    public static ErrorCode getErrorCode() {
        return errorCode;
    }

    public SnapPayDocUploadException(String message, ErrorCode errorCode) {
        super(message);
        SnapPayDocUploadException.errorCode = errorCode;
    }

    public SnapPayDocUploadException(String message, ErrorCode errorCode, Throwable cause) {
        super(message, cause);
        SnapPayDocUploadException.errorCode = errorCode;
    }

}
