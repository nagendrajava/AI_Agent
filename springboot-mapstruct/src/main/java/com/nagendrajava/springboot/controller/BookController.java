package com.nagendrajava.springboot.controller;

import com.nagendrajava.springboot.dto.BookDTO;
import com.nagendrajava.springboot.dto.LibraryDTO;
import com.nagendrajava.springboot.mapper.BookMapper;
import com.nagendrajava.springboot.mapper.LibraryMapper;
import com.nagendrajava.springboot.service.BookService;
import com.nagendrajava.springboot.service.LibraryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.server.ResponseStatusException;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import java.net.URI;
import java.util.List;

@RestController
@RequestMapping("api/v1/books")
public class BookController {

    private final BookService bookService;
    private final LibraryService libraryService;

    @Autowired
    public BookController(BookService bookService, LibraryService libraryService) {
        this.bookService = bookService;
        this.libraryService = libraryService;
    }

    @PostMapping
    public ResponseEntity<BookDTO> createBook(@Validated @RequestBody BookDTO bookDTO) {
        BookDTO savedBook = bookService.createBook(bookDTO);
        URI location = ServletUriComponentsBuilder.fromCurrentRequest()
                .path("/{id}")
                .buildAndExpand(savedBook.getId())
                .toUri();
        return ResponseEntity.created(location).body(savedBook);
    }

    @PutMapping("/{id}")
    public ResponseEntity<BookDTO> updateBook1(@PathVariable Long id, @Validated @RequestBody BookDTO bookDTO) {

        BookDTO existingBook = bookService.updateBook(id, bookDTO);
        if (existingBook == null) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "Book not found");
        }
        return ResponseEntity.noContent().build();
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteBook(@PathVariable Long id) {
        bookService.deleteBook(id);
        return ResponseEntity.noContent().build();
    }

    @GetMapping("/{id}")
    public ResponseEntity<BookDTO> getById(@PathVariable Long id) {
        BookDTO bookDTO = bookService.getBookById(id);
        return ResponseEntity.ok(bookDTO);
    }

    @GetMapping
    public ResponseEntity<Page<BookDTO>> getAll(Pageable pageable) {
        Page<BookDTO> bookDTOs = bookService.findAllBooks(pageable);
        return ResponseEntity.ok(bookDTOs);
    }

    @GetMapping("/library/{libraryId}")
    public ResponseEntity<Page<BookDTO>> getByLibraryId(@PathVariable Long libraryId, Pageable pageable) {
        Page<BookDTO> bookDTOs = bookService.getBooksByLibrary(libraryId, pageable);
        return ResponseEntity.ok(bookDTOs);
    }
}