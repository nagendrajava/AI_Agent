package com.example.invoice.controller;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/invoices")
public class InvoiceController {

    @GetMapping("/{id}")
    public ResponseEntity<String> getInvoice(@PathVariable String id) {
        return ResponseEntity.ok("Invoice ID: " + id + " | Status: PAID");
    }
}
