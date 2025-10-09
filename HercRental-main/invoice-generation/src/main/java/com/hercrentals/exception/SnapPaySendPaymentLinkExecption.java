package com.hercrentals.exception;

public class SnapPaySendPaymentLinkExecption extends Exception {
    private static final long serialVersionUID = 1L;

    public enum ErrorCode {
        SNAPPAY_SEND_PAYMENT_LINK_EXCEPTION
    }

    private static ErrorCode errorCode;

    public static ErrorCode getErrorCode() {
        return errorCode;
    }

    public SnapPaySendPaymentLinkExecption(String message) {
        super(message);
    }

    public SnapPaySendPaymentLinkExecption(String message, ErrorCode errorCode) {
        super(message);
        SnapPaySendPaymentLinkExecption.errorCode = errorCode;
    }

    public SnapPaySendPaymentLinkExecption(String message, ErrorCode errorCode, Throwable cause) {
        super(message, cause);
        SnapPaySendPaymentLinkExecption.errorCode = errorCode;
    }

}
