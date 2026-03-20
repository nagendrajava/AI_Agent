package com.nagendrajava.springboot.repository;

import com.nagendrajava.springboot.model.Library;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.Optional;

public interface LibraryRepository extends JpaRepository<Library, Long> {
    @Query("SELECT l FROM Library l LEFT JOIN FETCH l.books WHERE l.id = :id")
    Optional<Library> findByIdWithBooks(@Param("id") Long id);
}
