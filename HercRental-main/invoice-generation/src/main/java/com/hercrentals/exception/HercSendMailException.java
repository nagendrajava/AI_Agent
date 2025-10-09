package com.hercrentals.exception;

public class HercSendMailException extends Exception {
	private static final long serialVersionUID = 1L;

	public enum ErrorCode {
		MESSAGING_EXCEPTION
	}

	private static ErrorCode errorCode;

	public static ErrorCode getErrorCode() {
		return errorCode;
	}

	public HercSendMailException(String message, ErrorCode errorCode) {
		super(message);
		HercSendMailException.errorCode = errorCode;
	}

	public HercSendMailException(String message, ErrorCode errorCode, Throwable cause) {
		super(message, cause);
		HercSendMailException.errorCode = errorCode;
	}
}
