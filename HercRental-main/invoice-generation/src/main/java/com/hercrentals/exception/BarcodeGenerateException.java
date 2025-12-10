package com.hercrentals.exception;

public class BarcodeGenerateException extends Exception {
	private static final long serialVersionUID = 1L;

	public enum ErrorCode {
		INVALID_PATH_ERROR, WRITE_TO_PATH_ERROR, ENCODING_WRITE_EXCEPTION, IO_WRITE_EXCEPTION, WRITE_EXCEPTION
	}

	private static ErrorCode errorCode;

	public static ErrorCode getErrorCode() {
		return errorCode;
	}

	public BarcodeGenerateException(String message, ErrorCode errorCode) {
		super(message);
		BarcodeGenerateException.errorCode = errorCode;
	}

	public BarcodeGenerateException(String message, ErrorCode errorCode, Throwable cause) {
		super(message, cause);
		BarcodeGenerateException.errorCode = errorCode;
	}
}
