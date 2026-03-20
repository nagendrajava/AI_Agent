package com.example.demo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class RedirectController {
    @PostMapping("/redirect")
    public String handleRedirect(
            @RequestParam("return_url") String returnUrl,
            @RequestParam("erorr_url") String errorUrl,
            @RequestParam("sessionToken") String sessionToken,
            RedirectAttributes redirectAttributes) {

        // Simulated accountNo and routingNo values
        String accountNo = "1234567891";
        String routingNo = "987654322";

        // Validate required parameters
        if (returnUrl == null || returnUrl.isEmpty() || sessionToken == null || sessionToken.isEmpty()) {
            return "redirect:" + errorUrl + "?error=Missing parameters";
        }

        // Construct the redirect URL with parameters
        String redirectUrl = returnUrl + "?accountNo=" + accountNo + "&routingNo=" + routingNo;
        return "redirect:" + redirectUrl;
    }
}
