package com.hercrentals.exception;

public class PropertiesLoadingException extends Exception {
	private static final long serialVersionUID = 6337564732172133989L;

	public enum ErrorCode {
	}

	private ErrorCode errorCode;

	public PropertiesLoadingException(String message, ErrorCode errorCode) {
		super(message);
		this.errorCode = errorCode;
		this.printStackTrace(); // Print stack trace when exception is created
	}

	public PropertiesLoadingException(String message, ErrorCode errorCode, Throwable cause) {
		super(message, cause);
		this.errorCode = errorCode;
		this.printStackTrace(); // Print stack trace when exception is created
	}

	public PropertiesLoadingException(String message, Throwable cause) {
		super(message, cause);
		this.printStackTrace(); // Print stack trace when exception is created
	}

	public ErrorCode getErrorCode() {
		return errorCode;
	}
}
