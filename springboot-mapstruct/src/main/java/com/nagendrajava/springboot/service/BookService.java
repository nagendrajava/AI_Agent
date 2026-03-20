package com.nagendrajava.springboot.service;

import com.nagendrajava.springboot.dto.BookDTO;
import com.nagendrajava.springboot.mapper.BookMapper;
import com.nagendrajava.springboot.model.Book;
import com.nagendrajava.springboot.model.Library;
import com.nagendrajava.springboot.repository.BookRepository;
import com.nagendrajava.springboot.repository.LibraryRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;


@Service
public class BookService {

    private final BookRepository bookRepository;
    private final LibraryRepository libraryRepository;
    private final BookMapper bookMapper;

    @Autowired
    public BookService(BookRepository bookRepository,
                       LibraryRepository libraryRepository,
                       BookMapper bookMapper) {
        this.bookRepository = bookRepository;
        this.libraryRepository = libraryRepository;
        this.bookMapper = bookMapper;
    }

    // Find all books with pagination
    public Page<BookDTO> findAllBooks(Pageable pageable) {
        return bookRepository.findAll(pageable)
                             .map(bookMapper::toDto);
    }

    // Find book by ID
    public BookDTO getBookById(Long id) {
        com.nagendrajava.springboot.model.Book book = bookRepository.findById(id)
            .orElseThrow(() -> new IllegalArgumentException("Book not found"));
        return bookMapper.toDto(book);
    }

    // Create new book using DTO
    public BookDTO createBook(BookDTO bookDTO) {
        Library library = libraryRepository.findById(bookDTO.getLibraryId())
            .orElseThrow(() -> new IllegalArgumentException("Library not found"));

        Book book = bookMapper.toEntity(bookDTO);
        book.setLibrary(library);

        Book savedBook = bookRepository.save(book);
        return bookMapper.toDto(savedBook);
    }

    // Update existing book
    public BookDTO updateBook(Long id, BookDTO bookDTO) {
        Library library = libraryRepository.findById(bookDTO.getLibraryId())
            .orElseThrow(() -> new IllegalArgumentException("Library not found"));

        Book existingBook = bookRepository.findById(id)
            .orElseThrow(() -> new IllegalArgumentException("Book not found"));

        bookMapper.updateBookFromDto(bookDTO, existingBook); // Custom mapper method
        existingBook.setLibrary(library);

        Book updatedBook = bookRepository.save(existingBook);
        return bookMapper.toDto(updatedBook);
    }

    // Delete book by ID
    public void deleteBook(Long id) {
        Book book = bookRepository.findById(id)
            .orElseThrow(() -> new IllegalArgumentException("Book not found"));
        bookRepository.delete(book);
    }
    public Page<BookDTO> getBooksByLibrary(Long libraryId, Pageable pageable) {
        Page<Book> books = bookRepository.findByLibraryId(libraryId, pageable);
        return books.map(bookMapper::toDto);
    }
}