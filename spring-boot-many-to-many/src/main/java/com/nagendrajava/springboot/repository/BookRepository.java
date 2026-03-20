package com.nagendrajava.springboot.repository;

import com.nagendrajava.springboot.model.Book;
import org.springframework.data.jpa.repository.JpaRepository;

public interface BookRepository extends JpaRepository<Book,Long> {
}
