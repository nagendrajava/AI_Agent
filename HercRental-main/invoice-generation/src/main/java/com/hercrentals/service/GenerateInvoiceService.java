package com.hercrentals.service;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.IOException;
import java.io.OutputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Base64;

import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.sax.SAXResult;
import javax.xml.transform.stream.StreamSource;

import org.apache.commons.io.output.TeeOutputStream;
import org.apache.fop.apps.FOUserAgent;
import org.apache.fop.apps.Fop;
import org.apache.fop.apps.FopFactory;
import org.apache.fop.apps.FopFactoryBuilder;
import org.apache.fop.apps.MimeConstants;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.retry.annotation.Backoff;
import org.springframework.retry.annotation.Retryable;
import org.springframework.stereotype.Service;

import com.google.zxing.BarcodeFormat;
import com.google.zxing.client.j2se.MatrixToImageWriter;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.oned.Code39Writer;
import com.hercrentals.exception.BarcodeGenerateException;
import com.hercrentals.exception.PDFGenerationException;
import com.hercrentals.exception.PDFGenerationException.ErrorCode;
import com.hercrentals.model.InvoiceAuditLog;
import com.hercrentals.utils.AmazonS3Helper;

@Service
public class GenerateInvoiceService {

	private static final Logger log = LoggerFactory.getLogger(GenerateInvoiceService.class);

	@Retryable(value = { PDFGenerationException.class }, maxAttempts = 3, backoff = @Backoff(delay = 1000))
	public byte[] pdfGenerator(AmazonS3Helper amazonS3Helper, byte[] xmlData, byte[] xlsData, String invoiceType,
			InvoiceAuditLog invoiceAudit, String outputPdfFileName, String functionName) throws PDFGenerationException {
		try {
			File baseDir = null;
			if ("Lambda".equalsIgnoreCase(functionName)) {
				baseDir = new File(amazonS3Helper.getResourceLoc() + "_v3");
			} else {
				baseDir = new File(amazonS3Helper.getResourceLoc());
			}
			// System.out.println("baseDir: " + baseDir);
			// FopFactoryBuilder builder = new FopFactoryBuilder(new File(".").toURI());
			FopFactoryBuilder builder = new FopFactoryBuilder(baseDir.toURI());
			builder.setStrictFOValidation(false);
			FopFactory fopFactory = builder.build();

			FOUserAgent foUserAgent = fopFactory.newFOUserAgent();

			ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
			OutputStream out = new TeeOutputStream(amazonS3Helper.createS3OutputStream(outputPdfFileName),
					byteArrayOutputStream);
			Fop fop = fopFactory.newFop(MimeConstants.MIME_PDF, foUserAgent, out);

			TransformerFactory factory = TransformerFactory.newInstance();
			// factory.setFeature(XMLConstants.FEATURE_SECURE_PROCESSING, false); // Disable
			// all external entities
			StreamSource xlsSource = new StreamSource(new ByteArrayInputStream(xlsData));
			Transformer transformer = factory.newTransformer(xlsSource);

			// Embed the barcode as a base64-encoded string
			byte[] barcodeBytes = generateBarcode(invoiceAudit.getInvoiceNumber());
			String base64Barcode = Base64.getEncoder().encodeToString(barcodeBytes);
			System.out.println("Barcode Base64: " + base64Barcode);
			transformer.setParameter("barcodeBase64", "data:image/png;base64," + base64Barcode);

			StreamSource xmlSource = new StreamSource(new ByteArrayInputStream(xmlData));
			SAXResult result = new SAXResult(fop.getDefaultHandler());
			transformer.transform(xmlSource, result);

			out.close();
			byteArrayOutputStream.close();
			return byteArrayOutputStream.toByteArray();
		} catch (Exception e) {
			e.printStackTrace();
			throw new PDFGenerationException("Exception occurred during PDF Generation :: " + e.getMessage(),
					ErrorCode.PDF_GENERTION_EXCEPTION, e);
		}
	}

	// Create Folder Name
	public String createFolderName(InvoiceAuditLog audit) {
		return audit.getLocation() + "_" + audit.getInvoiceType().replace(' ', '_').toUpperCase();
	}

	// Create PDF File Path
	public String createPdfFilePath(AmazonS3Helper amazonS3Helper, InvoiceAuditLog audit) {
		if (amazonS3Helper == null || audit == null) {
			throw new IllegalArgumentException("Invalid arguments: hashMap and audit must not be null");
		}

		String outputLocation = amazonS3Helper.getOutputPDFLoc();
		if (outputLocation == null) {
			throw new IllegalArgumentException("Configuration error: s3.output.pdf.location is missing");
		}

		StringBuilder filePathBuilder = new StringBuilder(outputLocation);
		filePathBuilder.append(audit.getInvoiceNumber()).append("_").append(audit.getInvoiceType().replace(' ', '_'))
				.append(".pdf");

		return filePathBuilder.toString();
	}

	// Read File
	public byte[] readFileToByteArray(String filePath) throws IOException {
		Path path = Paths.get(filePath);
		byte[] data = Files.readAllBytes(path);

		return data;
	}

	// Generate Code39Barcode
	public byte[] generateBarcode(String text) throws BarcodeGenerateException {
		try {
			Code39Writer writer = new Code39Writer();
			BitMatrix bitMatrix = writer.encode(text, BarcodeFormat.CODE_39, 500, 30);

			ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
			MatrixToImageWriter.writeToStream(bitMatrix, "PNG", outputStream);

			return outputStream.toByteArray();
		} catch (IOException ioexception) {
			log.error("IOException occurred while trying to generate Code39Barcode PNG for Invoice number: {}", text);
			throw new BarcodeGenerateException(
					"IOException occurred while trying to generate Code39Barcode PNG for Invoice number: " + text,
					BarcodeGenerateException.ErrorCode.IO_WRITE_EXCEPTION, ioexception);
		} catch (Exception exception) {
			log.error("Exception occurred while trying to generate barcode PNG for Invoice number: {}", text);
			throw new BarcodeGenerateException(
					"Exception occurred while trying to generate barcode PNG for Invoice number: " + text,
					BarcodeGenerateException.ErrorCode.WRITE_EXCEPTION, exception);
		}
	}

}
