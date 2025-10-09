package com.hercrentals.exception;

public class SFTPException extends Exception {
    private static final long serialVersionUID = 1L;

    public enum ErrorCode {
        SFTP_UPLOAD_EXCEPTION
    }

    private static ErrorCode errorCode;

    public static ErrorCode getErrorCode() {
        return errorCode;
    }

    public SFTPException(String message, ErrorCode errorCode) {
        super(message);
        SFTPException.errorCode = errorCode;
    }

    public SFTPException(String message, ErrorCode errorCode, Throwable cause) {
        super(message, cause);
        SFTPException.errorCode = errorCode;
    }

}
