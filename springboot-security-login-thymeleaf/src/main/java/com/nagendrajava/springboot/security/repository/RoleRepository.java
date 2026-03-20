package com.nagendrajava.springboot.security.repository;

import com.nagendrajava.springboot.security.model.Role;
import org.springframework.data.jpa.repository.JpaRepository;

public interface RoleRepository extends JpaRepository<Role, Long> {
}
