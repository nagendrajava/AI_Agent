package com.hercrentals.exception;

public class XMLExtractionException extends Exception {
	private static final long serialVersionUID = -1244409833777667345L;

	public enum ErrorCode {
		XML_TAG_MISSING_EXCEPTION, XML_PARSING_EXCEPTION, XML_VALIDATION_EXCEPTION, SCHEMA_CREATION_EXCEPTION
	}

	private static ErrorCode errorCode;

	public static ErrorCode getErrorCode() {
		return errorCode;
	}

	public XMLExtractionException(String message, ErrorCode errorCode) {
		super(message);
		XMLExtractionException.errorCode = errorCode;
	}

	public XMLExtractionException(String message, ErrorCode errorCode, Throwable cause) {
		super(message, cause);
		XMLExtractionException.errorCode = errorCode;
	}

}
