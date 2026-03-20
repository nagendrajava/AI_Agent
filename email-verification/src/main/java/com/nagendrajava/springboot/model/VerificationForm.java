package com.nagendrajava.springboot.model;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotEmpty;

public class VerificationForm {
    @NotEmpty
    @Email
    private String email;

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }
}