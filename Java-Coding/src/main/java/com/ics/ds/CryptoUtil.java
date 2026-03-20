package com.ics.ds;

import javax.crypto.Cipher;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.GCMParameterSpec;
import javax.crypto.spec.PBEKeySpec;
import javax.crypto.spec.SecretKeySpec;
import java.nio.ByteBuffer;
import java.nio.charset.StandardCharsets;
import java.security.SecureRandom;
import java.util.Base64;
import java.util.Objects;

/**
 * Minimal AES-GCM encryption/decryption utility for REST-style responses.
 *
 * This class derives a 256-bit AES key from a passphrase using PBKDF2WithHmacSHA256.
 * Passphrase can be overridden by environment variable "API_ENC_PASSPHRASE" or
 * system property "api.enc.passphrase". For demo, it falls back to a default value.
 *
 * The JSON payload format returned by encryptToJson is:
 * {
 *   "alg":"AES-GCM",
 *   "iv":"base64",
 *   "cipherText":"base64"
 * }
 */
public final class CryptoUtil {
    private static final String DEFAULT_PASSPHRASE = "changeit-very-unsafe-demo"; // demo default
    private static final String SALT_CONSTANT = "JavaCodingDemoSalt-v1"; // not secret; demo only
    private static final int ITERATIONS = 50_000;
    private static final int KEY_BITS = 256;
    private static final int IV_BYTES = 12; // recommended for GCM
    private static final int TAG_BITS = 128;

    private static volatile SecretKeySpec cachedKey;

    private CryptoUtil() {}

    private static SecretKeySpec getKey() {
        SecretKeySpec k = cachedKey;
        if (k != null) return k;
        synchronized (CryptoUtil.class) {
            if (cachedKey != null) return cachedKey;
            try {
                String pass = System.getProperty("api.enc.passphrase");
                if (pass == null || pass.isBlank()) {
                    pass = System.getenv("API_ENC_PASSPHRASE");
                }
                if (pass == null || pass.isBlank()) {
                    pass = DEFAULT_PASSPHRASE;
                }
                PBEKeySpec spec = new PBEKeySpec(pass.toCharArray(), SALT_CONSTANT.getBytes(StandardCharsets.UTF_8), ITERATIONS, KEY_BITS);
                SecretKeyFactory skf = SecretKeyFactory.getInstance("PBKDF2WithHmacSHA256");
                byte[] keyBytes = skf.generateSecret(spec).getEncoded();
                cachedKey = new SecretKeySpec(keyBytes, "AES");
                return cachedKey;
            } catch (Exception e) {
                throw new RuntimeException("Failed to derive encryption key", e);
            }
        }
    }

    public static String encryptToJson(byte[] data) {
        Objects.requireNonNull(data, "data");
        try {
            byte[] iv = new byte[IV_BYTES];
            new SecureRandom().nextBytes(iv);

            Cipher cipher = Cipher.getInstance("AES/GCM/NoPadding");
            GCMParameterSpec gcm = new GCMParameterSpec(TAG_BITS, iv);
            cipher.init(Cipher.ENCRYPT_MODE, getKey(), gcm);
            byte[] cipherBytes = cipher.doFinal(data);

            String ivB64 = Base64.getEncoder().encodeToString(iv);
            String ctB64 = Base64.getEncoder().encodeToString(cipherBytes);

            StringBuilder sb = new StringBuilder(128 + ctB64.length());
            sb.append('{')
              .append("\"alg\":\"AES-GCM\",")
              .append("\"iv\":\"").append(ivB64).append("\",")
              .append("\"cipherText\":\"").append(ctB64).append("\"}");
            return sb.toString();
        } catch (Exception e) {
            throw new RuntimeException("Encryption failed", e);
        }
    }

    public static byte[] decryptFromJson(String json) {
        Objects.requireNonNull(json, "json");
        try {
            // Very small/naive JSON parsing to avoid adding dependencies
            String trimmed = json.trim();
            // Expect keys alg, iv, cipherText
            String iv = extractJsonValue(trimmed, "iv");
            String ct = extractJsonValue(trimmed, "cipherText");
            byte[] ivBytes = Base64.getDecoder().decode(iv);
            byte[] cipherBytes = Base64.getDecoder().decode(ct);

            Cipher cipher = Cipher.getInstance("AES/GCM/NoPadding");
            GCMParameterSpec gcm = new GCMParameterSpec(TAG_BITS, ivBytes);
            cipher.init(Cipher.DECRYPT_MODE, getKey(), gcm);
            return cipher.doFinal(cipherBytes);
        } catch (Exception e) {
            throw new RuntimeException("Decryption failed", e);
        }
    }

    private static String extractJsonValue(String json, String key) {
        // simplistic extractor: searches for "key":"value"
        String pattern = "\"" + key + "\"" + ":\""; // "key":"
        int idx = json.indexOf(pattern);
        if (idx < 0) throw new IllegalArgumentException("Key not found: " + key);
        int start = idx + pattern.length();
        int end = json.indexOf('"', start);
        if (end < 0) throw new IllegalArgumentException("Unterminated value for key: " + key);
        return json.substring(start, end);
    }
}
