package com.example.demo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class TestController {
    @GetMapping("/")
    public String showTestPage() {
        // Renders test.html from the templates folder
        return "test";
    }
}
