package com.nagendrajava.springboot.repository;

import com.nagendrajava.springboot.model.Book;
import jakarta.transaction.Transactional;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

public interface BookRepository extends JpaRepository<Book, Long> {
    Page<Book> findByLibraryId(Long libraryId, Pageable pageable);

    @Modifying
    @Transactional
    @Query("DELETE FROM Book b WHERE b.library.id = ?1")
    void deleteByLibraryId(Long libraryId);
}
