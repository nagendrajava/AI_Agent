package com.hercrentals.utils;

import java.util.UUID;
import java.util.concurrent.TimeUnit;

import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;
import javax.xml.bind.DatatypeConverter;

public class HmacGenerator {

    public static String generateHmac(String reqUrl, String reqMethod, String reqPayload, String secretKey,
            String accountId) throws Exception {
        String hmacValue = "";
        String requestUri = reqUrl;
        String requestContentBase64String = reqPayload;
        String requestTimeStamp = Long.toString(TimeUnit.MILLISECONDS.toSeconds(System.currentTimeMillis()));

        UUID uuid = UUID.randomUUID();
        String nonce = uuid.toString();

        // if (!reqMethod.equalsIgnoreCase("GET")) {
        // byte[] payload = reqPayload.getBytes(StandardCharsets.UTF_8);
        // MessageDigest md = MessageDigest.getInstance("MD5");
        // md.update(payload);
        // requestContentBase64String = new
        // String(DatatypeConverter.printBase64Binary(md.digest()));
        // }
        String signatureRawData = accountId + reqMethod + requestUri + requestTimeStamp + nonce
                + requestContentBase64String;
        byte[] secretKeyByteArray = DatatypeConverter.parseBase64Binary(secretKey);
        byte[] signature;
        signature = signatureRawData.getBytes("UTF-8");
        String requestSignatureBase64String = "";
        Mac sha256_HMAC = Mac.getInstance("HmacSHA256");
        SecretKeySpec secret_key = new SecretKeySpec(secretKeyByteArray, "HmacSHA256");
        sha256_HMAC.init(secret_key);
        byte[] Signaturebytes = sha256_HMAC.doFinal(signature);
        requestSignatureBase64String = new String(DatatypeConverter.printBase64Binary(Signaturebytes));
        String hmacData = accountId + ":" + requestSignatureBase64String + ":" + nonce + ":" + requestTimeStamp;
        hmacValue = new String(DatatypeConverter.printBase64Binary(hmacData.getBytes()));

        return "Hmac " + hmacValue;
    }
}
