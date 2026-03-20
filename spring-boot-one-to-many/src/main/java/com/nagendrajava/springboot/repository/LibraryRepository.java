package com.nagendrajava.springboot.repository;

import com.nagendrajava.springboot.model.Library;
import org.springframework.data.jpa.repository.JpaRepository;

public interface LibraryRepository extends JpaRepository<Library, Long> {
    // Additional query methods can be defined here if needed
}
