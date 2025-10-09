package com.hercrentals.exception;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNull;
import org.junit.jupiter.api.Test;

public class QRCodeGenerateExceptionTest {

	@Test
	void testConstructorWithMessageAndErrorCode() {
		// Arrange
		String message = "An error occurred";
		QRCodeGenerateException.ErrorCode errorCode = QRCodeGenerateException.ErrorCode.INVALID_PATH_ERROR;

		// Act
		QRCodeGenerateException exception = new QRCodeGenerateException(message, errorCode);

		// Assert
		assertEquals(message, exception.getMessage(), "Exception message should match");
		assertEquals(errorCode, exception.getErrorCode(), "Error code should match");
		// Assert that the cause is null since it was not provided
		assertNull(exception.getCause(), "Cause should be null by default");
	}

	@Test
	void testConstructorWithMessageErrorCodeAndCause() {
		// Arrange
		String message = "An error occurred";
		QRCodeGenerateException.ErrorCode errorCode = QRCodeGenerateException.ErrorCode.IO_WRITE_EXCEPTION;
		Throwable cause = new RuntimeException("Underlying cause");

		// Act
		QRCodeGenerateException exception = new QRCodeGenerateException(message, errorCode, cause);

		// Assert
		assertEquals(message, exception.getMessage(), "Exception message should match");
		assertEquals(errorCode, exception.getErrorCode(), "Error code should match");
		assertEquals(cause, exception.getCause(), "Cause should match");
	}

	@Test
	void testGetErrorCode() {
		// Arrange
		QRCodeGenerateException.ErrorCode errorCode = QRCodeGenerateException.ErrorCode.WRITE_EXCEPTION;
		QRCodeGenerateException exception = new QRCodeGenerateException("Some error", errorCode);

		// Act & Assert
		assertEquals(errorCode, exception.getErrorCode(), "Error code should match");
	}
}
