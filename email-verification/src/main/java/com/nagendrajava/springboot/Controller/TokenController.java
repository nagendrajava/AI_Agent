package com.nagendrajava.springboot.Controller;

import com.nagendrajava.springboot.model.VerificationForm;
import com.nagendrajava.springboot.service.VerificationTokenService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class TokenController {
    @Autowired
    private VerificationTokenService verificationTokenService;

    @GetMapping("/")
    public  String index(){
        return " redirect:/email-verification";
    }
    @GetMapping("/email-verification")
    public  String emailVerification(Model model){
        model.addAttribute("verificationForm", new VerificationForm());
        return "verification-form";
    }
    @PostMapping("/email-verification")
    public String verifyEmail(@Valid VerificationForm verificationForm, BindingResult bindingResult, Model model) {

        if (!bindingResult.hasErrors()) {
            model.addAttribute("noErrors", true);
        }
        model.addAttribute("verificationForm", verificationForm);
        String email = verificationForm.getEmail();
        verificationTokenService.createVerification(email);
        model.addAttribute("message", "Verification email sent to " + email);
        return "verification-form";
    }

    @GetMapping("/verify-email")
    @ResponseBody
    public String verifyEmail(String code) {
        return verificationTokenService.verifyEmail(code).getBody();
    }

}
