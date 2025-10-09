package com.hercrentals.exception;

public class PDFGenerationException extends Exception {
	private static final long serialVersionUID = 1L;

	public enum ErrorCode {
		PDF_GENERTION_EXCEPTION
	}

	private static ErrorCode errorCode;

	public static ErrorCode getErrorCode() {
		return errorCode;
	}

	public PDFGenerationException(String message, ErrorCode errorCode) {
		super(message);
		PDFGenerationException.errorCode = errorCode;
	}

	public PDFGenerationException(String message, ErrorCode errorCode, Throwable cause) {
		super(message, cause);
		PDFGenerationException.errorCode = errorCode;
	}

}
