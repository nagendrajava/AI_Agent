package com.example.oauth2;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.nio.charset.StandardCharsets;
import java.time.Instant;
import java.util.Base64;
import java.util.HashMap;
import java.util.Map;

/**
 * DEBUG / TEST ONLY:
 * Simple endpoints to (1) decode JWT header & payload WITHOUT signature verification
 * and (2) report basic expiration info. Do NOT use this for production validation logic.
 *
 * Usage:
 *   GET /jwt/claims?token=eyJ...   or send Authorization: Bearer eyJ...
 *   GET /jwt/validate?token=eyJ...
 */
@RestController
@RequestMapping("/jwt")
public class JwtTestController {

    @GetMapping("/claims")
    public ResponseEntity<?> claims(@RequestParam(value = "token", required = false) String token,
                                    @RequestHeader(value = "Authorization", required = false) String authHeader) {
        String raw = extractToken(token, authHeader);
        if (raw == null) {
            return ResponseEntity.badRequest().body(Map.of("error", "Missing token (provide ?token= or Authorization header)"));
        }
        try {
            Map<String, Object> decoded = decode(raw);
            return ResponseEntity.ok(decoded);
        } catch (IllegalArgumentException ex) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(Map.of("error", "Invalid JWT format", "detail", ex.getMessage()));
        }
    }

    @GetMapping("/validate")
    public ResponseEntity<?> validate(@RequestParam(value = "token", required = false) String token,
                                      @RequestHeader(value = "Authorization", required = false) String authHeader) {
        String raw = extractToken(token, authHeader);
        if (raw == null) {
            return ResponseEntity.badRequest().body(Map.of("error", "Missing token"));
        }
        try {
            Map<String, Object> decoded = decode(raw);
            Map<String, Object> payload = (Map<String, Object>) decoded.get("payload");
            Long exp = payload != null && payload.get("exp") instanceof Number ? ((Number) payload.get("exp")).longValue() : null;
            Instant now = Instant.now();
            Map<String, Object> result = new HashMap<>();
            result.put("issuedAt(now)", now.getEpochSecond());
            result.put("exp", exp);
            if (exp != null) {
                result.put("isExpired", now.getEpochSecond() >= exp);
                result.put("secondsUntilExpiry", exp - now.getEpochSecond());
            } else {
                result.put("warning", "No exp claim present");
            }
            return ResponseEntity.ok(result);
        } catch (IllegalArgumentException ex) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(Map.of("error", "Invalid JWT format", "detail", ex.getMessage()));
        }
    }

    private String extractToken(String paramToken, String authHeader) {
        if (paramToken != null && !paramToken.isBlank()) return paramToken.trim();
        if (authHeader != null && authHeader.toLowerCase().startsWith("bearer ")) {
            return authHeader.substring(7).trim();
        }
        return null;
    }

    /**
     * Decodes (does NOT verify) a JWT into header & payload maps.
     */
    private Map<String, Object> decode(String token) {
        String[] parts = token.split("\\.");
        if (parts.length < 2) throw new IllegalArgumentException("Token must have at least 2 parts");
        Map<String, Object> out = new HashMap<>();
        out.put("headerRaw", parts[0]);
        out.put("payloadRaw", parts[1]);
        out.put("signaturePresent", parts.length > 2 && !parts[2].isEmpty());
        out.put("header", parseJson(b64Url(parts[0])));
        out.put("payload", parseJson(b64Url(parts[1])));
        return out;
    }

    private String b64Url(String segment) {
        byte[] decoded = Base64.getUrlDecoder().decode(segment);
        return new String(decoded, StandardCharsets.UTF_8);
    }

    @SuppressWarnings("unchecked")
    private Map<String, Object> parseJson(String json) {
        // Simple minimal parser using Jackson if available, else fallback to empty map.
        try {
            // Lazy load to avoid hard dependency here.
            Class<?> omClass = Class.forName("com.fasterxml.jackson.databind.ObjectMapper");
            Object mapper = omClass.getDeclaredConstructor().newInstance();
            return (Map<String, Object>) omClass.getMethod("readValue", String.class, Class.class)
                    .invoke(mapper, json, Map.class);
        } catch (Exception e) {
            Map<String, Object> fallback = new HashMap<>();
            fallback.put("_raw", json);
            fallback.put("_warning", "Jackson not found - returning raw JSON string");
            return fallback;
        }
    }
}

