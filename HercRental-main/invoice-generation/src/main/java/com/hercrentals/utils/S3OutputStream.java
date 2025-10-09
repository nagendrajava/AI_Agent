package com.hercrentals.utils;

import java.io.OutputStream;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import software.amazon.awssdk.core.sync.RequestBody;
import software.amazon.awssdk.services.s3.S3Client;
import software.amazon.awssdk.services.s3.model.AbortMultipartUploadRequest;
import software.amazon.awssdk.services.s3.model.CompleteMultipartUploadRequest;
import software.amazon.awssdk.services.s3.model.CompletedMultipartUpload;
import software.amazon.awssdk.services.s3.model.CompletedPart;
import software.amazon.awssdk.services.s3.model.CreateMultipartUploadRequest;
import software.amazon.awssdk.services.s3.model.CreateMultipartUploadResponse;
import software.amazon.awssdk.services.s3.model.PutObjectRequest;
import software.amazon.awssdk.services.s3.model.UploadPartRequest;
import software.amazon.awssdk.services.s3.model.UploadPartResponse;

public class S3OutputStream extends OutputStream {

    protected static final int BUFFER_SIZE = 10_000_000; // 10MB

    private final String bucket;
    private final String path;
    private final byte[] buf;
    private int position;
    private final S3Client s3Client;
    private String uploadId;
    private final List<CompletedPart> completedParts;
    private boolean open;

    public S3OutputStream(S3Client s3Client, String bucket, String path) {
        this.s3Client = s3Client;
        this.bucket = bucket;
        this.path = path;
        this.buf = new byte[BUFFER_SIZE];
        this.position = 0;
        this.completedParts = new ArrayList<>();
        this.open = true;
    }

    @Override
    public void write(byte[] b) {
        write(b, 0, b.length);
    }

    @Override
    public void write(final byte[] byteArray, final int offset, final int length) {
        assertOpen();
        int ofs = offset, len = length;
        int size;
        while (len > (size = this.buf.length - position)) {
            System.arraycopy(byteArray, ofs, this.buf, this.position, size);
            this.position += size;
            flushBufferAndRewind();
            ofs += size;
            len -= size;
        }
        System.arraycopy(byteArray, ofs, this.buf, this.position, len);
        this.position += len;
    }

    @Override
    public synchronized void flush() {
        assertOpen();
    }

    private void flushBufferAndRewind() {
        if (uploadId == null) {
            CreateMultipartUploadRequest request = CreateMultipartUploadRequest.builder()
                    .bucket(bucket)
                    .key(path)
                    .build();
            CreateMultipartUploadResponse response = s3Client.createMultipartUpload(request);
            this.uploadId = response.uploadId();
        }
        uploadPart();
        this.position = 0;
    }

    private void uploadPart() {
        int partNumber = completedParts.size() + 1;
        UploadPartRequest uploadRequest = UploadPartRequest.builder()
                .bucket(bucket)
                .key(path)
                .uploadId(uploadId)
                .partNumber(partNumber)
                .build();

        UploadPartResponse uploadResponse = s3Client.uploadPart(uploadRequest,
                RequestBody.fromBytes(Arrays.copyOfRange(buf, 0, position)));

        completedParts.add(CompletedPart.builder()
                .partNumber(partNumber)
                .eTag(uploadResponse.eTag())
                .build());
    }

    @Override
    public void close() {
        if (this.open) {
            this.open = false;
            if (this.uploadId != null) {
                if (this.position > 0) {
                    uploadPart();
                }
                CompleteMultipartUploadRequest completeRequest = CompleteMultipartUploadRequest.builder()
                        .bucket(bucket)
                        .key(path)
                        .uploadId(uploadId)
                        .multipartUpload(CompletedMultipartUpload.builder()
                                .parts(completedParts)
                                .build())
                        .build();
                s3Client.completeMultipartUpload(completeRequest);
            } else {
                PutObjectRequest putRequest = PutObjectRequest.builder()
                        .bucket(bucket)
                        .key(path)
                        .build();
                s3Client.putObject(putRequest, RequestBody.fromBytes(Arrays.copyOfRange(buf, 0, position)));
            }
        }
    }

    public void cancel() {
        this.open = false;
        if (this.uploadId != null) {
            AbortMultipartUploadRequest abortRequest = AbortMultipartUploadRequest.builder()
                    .bucket(bucket)
                    .key(path)
                    .uploadId(uploadId)
                    .build();
            s3Client.abortMultipartUpload(abortRequest);
        }
    }

    @Override
    public void write(int b) {
        assertOpen();
        if (position >= this.buf.length) {
            flushBufferAndRewind();
        }
        this.buf[position++] = (byte) b;
    }

    private void assertOpen() {
        if (!this.open) {
            throw new IllegalStateException("Closed");
        }
    }
}
