package com.nagendrajava.springboot.service;

import com.nagendrajava.springboot.model.User;
import com.nagendrajava.springboot.model.VerificationToken;
import com.nagendrajava.springboot.repository.UserRepository;
import com.nagendrajava.springboot.repository.VerificationTokenRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;

@Service
public class VerificationTokenService {
    private UserRepository userRepository;
    private VerificationTokenRepository verificationTokenRepository;
    private SendingMailService sendingMailService;

    @Autowired
    public VerificationTokenService(UserRepository userRepository,
                                       VerificationTokenRepository verificationTokenRepository,
                                       SendingMailService sendingMailService) {
        this.userRepository = userRepository;
        this.verificationTokenRepository = verificationTokenRepository;
        this.sendingMailService = sendingMailService;
    }
    // Additional methods for handling verification tokens can be added here
    public void createVerification(String email) {
        List<User> users = userRepository.findByEmail(email);
        User user;
        if (users.isEmpty()) {
            user = new User();
            user.setEmail(email);
            userRepository.save(user);

        }
        else {
            user = users.get(0);
        }
        List<VerificationToken> verificationTokens = verificationTokenRepository.findByUserEmail(email);
        VerificationToken token;
        if (verificationTokens.isEmpty()) {
            token = new VerificationToken();
            token.setUser(user);
        } else {
            token = verificationTokens.get(0);
        }
        sendingMailService.sendVerificationMail(email, token.getToken());
    }

    public ResponseEntity<String> verifyEmail(String token) {
        List<VerificationToken> verificationTokens = verificationTokenRepository.findByToken(token);
        if (verificationTokens.isEmpty()) {
            return ResponseEntity.badRequest().body("Invalid token");
        }
        VerificationToken verificationToken = verificationTokens.get(0);
        if (verificationToken.getExpiredDateTime().isBefore(LocalDateTime.now())) {
            return ResponseEntity.unprocessableEntity().body("Token has expired");
        }
        verificationToken.setConfirmedDateTime(LocalDateTime.now());
        verificationToken.setStatus(VerificationToken.STATUS_VERIFIED);
        verificationToken.getUser().setIsActive(true);
        return ResponseEntity.ok("User verified successfully");
    }
}
