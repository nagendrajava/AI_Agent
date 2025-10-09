package com.hercrentals.exception;

public class QRCodeGenerateException extends Exception {
	private static final long serialVersionUID = 1L;

	public enum ErrorCode {
		INVALID_PATH_ERROR, WRITE_TO_PATH_ERROR, ENCODING_WRITE_EXCEPTION, IO_WRITE_EXCEPTION, WRITE_EXCEPTION
	}

	private ErrorCode errorCode;

	public ErrorCode getErrorCode() {
		return errorCode;
	}

	public QRCodeGenerateException(String message, ErrorCode errorCode) {
		super(message);
		this.errorCode = errorCode;
	}

	public QRCodeGenerateException(String message, ErrorCode errorCode, Throwable cause) {
		super(message, cause);
		this.errorCode = errorCode;
	}

}
