package com.hercrentals.exception;

public class S3Exception extends Exception {
	private static final long serialVersionUID = 4306070191023864903L;

	public enum ErrorCode {
		S3_READ_EXCEPTION
	}

	private static ErrorCode errorCode;

	public static ErrorCode getErrorCode() {
		return errorCode;
	}

	public S3Exception(String message, ErrorCode errorCode) {
		super(message);
		S3Exception.errorCode = errorCode;
	}

	public S3Exception(String message, ErrorCode errorCode, Throwable cause) {
		super(message, cause);
		S3Exception.errorCode = errorCode;
	}

}
