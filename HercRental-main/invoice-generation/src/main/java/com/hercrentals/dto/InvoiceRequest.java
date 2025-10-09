package com.hercrentals.dto;

import java.io.Serializable;

import lombok.Data;

@Data
public class InvoiceRequest implements Serializable {

    private static final long serialVersionUID = 1L;

    private String bucketName;
    private String objectKey;
    private String eventTime;

}
