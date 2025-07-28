package com.nagendrajava.springboot.security.repository;

import com.nagendrajava.springboot.security.model.User;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserRepository extends JpaRepository<User, Long> {

    User findByUsername(String username);

    // Additional query methods can be defined here if needed

}
