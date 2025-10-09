package com.hercrentals.utils;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import software.amazon.awssdk.auth.credentials.AwsBasicCredentials;
import software.amazon.awssdk.auth.credentials.StaticCredentialsProvider;
import software.amazon.awssdk.core.ResponseInputStream;
import software.amazon.awssdk.core.sync.RequestBody;
import software.amazon.awssdk.regions.Region;
import software.amazon.awssdk.services.s3.S3Client;
import software.amazon.awssdk.services.s3.model.CopyObjectRequest;
import software.amazon.awssdk.services.s3.model.DeleteObjectRequest;
import software.amazon.awssdk.services.s3.model.GetObjectRequest;
import software.amazon.awssdk.services.s3.model.GetObjectResponse;
import software.amazon.awssdk.services.s3.model.PutObjectRequest;

@Component
public class AmazonS3Helper {

	@Value("${s3.authKey}")
	private String authKey;

	@Value("${s3.authSecret}")
	private String authSecret;

	@Value("${s3.bucket.name}")
	private String bucketName;

	@Value("${s3.input.xml.location}")
	private String inputXMLLoc;

	@Value("${s3.rejected.xml.location}")
	private String rejectedXMLLoc;

	@Value("${s3.output.pdf.location}")
	private String outputPDFLoc;

	@Value("${s3.archive.xml.location}")
	private String archiveXMLLoc;

	@Value("${ec2.resource.location}")
	private String resourceLoc;

	private static S3Client s3Client = null;
	private static LocalDateTime lastRefreshed = LocalDateTime.MIN;

	private void checkInit() {
		long noOfHours = lastRefreshed.until(LocalDateTime.now(), ChronoUnit.HOURS);
		if (noOfHours > 1 || s3Client == null) {
			lastRefreshed = LocalDateTime.now();
			s3Client = S3Client.builder()
					.region(Region.AP_SOUTH_1)
					.credentialsProvider(StaticCredentialsProvider.create(
							AwsBasicCredentials.create(authKey, authSecret)))
					.build();
		}
	}

	public String getBucketName() {
		return bucketName;
	}

	public String getInputXMLLoc() {
		return inputXMLLoc;
	}

	public String getRejectedXMLLoc() {
		return rejectedXMLLoc;
	}

	public String getOutputPDFLoc() {
		return outputPDFLoc;
	}

	public String getArchiveXMLLoc() {
		return archiveXMLLoc;
	}

	public String getResourceLoc() {
		return resourceLoc;
	}

	public OutputStream createS3OutputStream(String outputPdfFileName) {
		checkInit();
		return new S3OutputStream(s3Client, bucketName, outputPdfFileName);

	}

	public void uploadXmlFileToS3(String fileName, byte[] content) {
		checkInit();
		try {
			PutObjectRequest putRequest = PutObjectRequest.builder()
					.bucket(bucketName)
					.key(fileName)
					.contentType("application/xml")
					.build();
			s3Client.putObject(putRequest, RequestBody.fromBytes(content));
		} catch (Exception e) {
			throw new RuntimeException("Failed to upload file to S3", e);
		}
	}

	public byte[] readS3InputStreamToByteArray(ResponseInputStream<GetObjectResponse> inputStream) throws IOException {
		ByteArrayOutputStream baos = new ByteArrayOutputStream();
		byte[] buffer = new byte[1024];
		int bytesRead;
		while ((bytesRead = inputStream.read(buffer)) != -1) {
			baos.write(buffer, 0, bytesRead);
		}
		return baos.toByteArray();
	}

	public void moveFile(String objectKey, String destinationFolder) {
		checkInit();
		try {
			String fileName = objectKey.substring(objectKey.lastIndexOf("/") + 1);
			String sourceKey = objectKey;
			String destinationKey = destinationFolder + fileName;

			CopyObjectRequest copyObjRequest = CopyObjectRequest.builder()
					.sourceBucket(bucketName)
					.sourceKey(sourceKey)
					.destinationBucket(bucketName)
					.destinationKey(destinationKey)
					.build();
			s3Client.copyObject(copyObjRequest);

			DeleteObjectRequest deleteObjRequest = DeleteObjectRequest.builder()
					.bucket(bucketName)
					.key(sourceKey)
					.build();
			s3Client.deleteObject(deleteObjRequest);
		} catch (Exception e) {
			throw new RuntimeException("Error moving file from " + objectKey + " to " + destinationFolder + ":", e);
		}
	}

	public byte[] readS3File(String bucketName, String objectKey) throws IOException {
		checkInit();
		GetObjectRequest getObjectRequest = GetObjectRequest.builder()
				.bucket(bucketName)
				.key(objectKey)
				.build();

		try (ResponseInputStream<GetObjectResponse> inputStream = s3Client.getObject(getObjectRequest)) {
			return readS3InputStreamToByteArray(inputStream);
		}
	}

}
