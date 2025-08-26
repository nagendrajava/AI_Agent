package com.example.oauth2;

/**
 * Simple demo controller with public and secure endpoints.
 * Copy this class into the auth server project's matching package
 * (e.g. src/main/java/com/example/oauth2) to expose identical routes.
 */

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class HelloController {

    @GetMapping("/public")
    public String publicEndpoint() {
        return "Hello (public)!";
    }

    @GetMapping("/secure")
    public String secureEndpoint() {
        return "Hello (secure, authenticated)!";
    }
}
