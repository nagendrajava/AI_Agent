package com.nagendrajava.springboot.security.service;

import com.nagendrajava.springboot.security.model.User;

public interface UserService {
    void save(User user);
    User findByUsername(String username);
}
