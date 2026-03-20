package com.nagendrajava.springboot.repository;

import com.nagendrajava.springboot.model.VerificationToken;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface VerificationTokenRepository extends JpaRepository<VerificationToken,Long> {
    List<VerificationToken> findByToken(String token);
    List<VerificationToken> findByUserEmail(String email);
}
