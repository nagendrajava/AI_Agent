package com.hercrentals.exception;

public class SnapPayIntegrationException extends Exception {
    private static final long serialVersionUID = 1L;

    public enum ErrorCode {
        SNAP_PAY_INTEGRATION_EXCEPTION
    }

    private static ErrorCode errorCode;

    public static ErrorCode getErrorCode() {
        return errorCode;
    }

    public SnapPayIntegrationException(String message) {
        super(message);
    }

    public SnapPayIntegrationException(String message, ErrorCode errorCode) {
        super(message);
        SnapPayIntegrationException.errorCode = errorCode;
    }

    public SnapPayIntegrationException(String message, ErrorCode errorCode, Throwable cause) {
        super(message, cause);
        SnapPayIntegrationException.errorCode = errorCode;
    }

}
