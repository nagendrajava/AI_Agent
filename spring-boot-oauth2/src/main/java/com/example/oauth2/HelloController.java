package com.example.oauth2;

import org.springframework.lang.Nullable;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.oauth2.server.resource.authentication.JwtAuthenticationToken;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.time.Instant;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@RestController
public class HelloController {

    @GetMapping("/public/ping")
    public Map<String, Object> ping() {
        Map<String, Object> resp = new LinkedHashMap<>();
        resp.put("status", "ok");
        resp.put("ts", Instant.now().toString());
        return resp;
    }

    @GetMapping("/api/hello")
    public Map<String, Object> hello(@Nullable JwtAuthenticationToken auth) {
        Map<String, Object> resp = new LinkedHashMap<>();
        resp.put("greeting", "Hello");
        resp.put("ts", Instant.now().toString());
        if (auth != null && auth.getToken() != null) {
            resp.put("subject", auth.getName());
            resp.put("claims", auth.getToken().getClaims());
            List<String> authorities = auth.getAuthorities().stream()
                    .map(GrantedAuthority::getAuthority)
                    .sorted()
                    .collect(Collectors.toList());
            resp.put("authorities", authorities);
        } else {
            resp.put("subject", "anonymous");
            resp.put("authorities", List.of());
        }
        return resp;
    }
}
