package com.nagendrajava.springboot.controller;

import com.nagendrajava.springboot.model.Library;
import com.nagendrajava.springboot.repository.BookRepository;
import com.nagendrajava.springboot.repository.LibraryRepository;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import java.net.URI;
import java.util.Optional;
@RequestMapping("/api/v1/libraries")
@RestController
public class LibraryController {
    private LibraryRepository libraryRepository;
    private BookRepository bookRepository;

    @Autowired
    public LibraryController(LibraryRepository libraryRepository, BookRepository bookRepository) {
        this.libraryRepository = libraryRepository;
        this.bookRepository = bookRepository;
    }

    @PostMapping
    public ResponseEntity<Library> createLibrary(@Validated @RequestBody Library library) {
        Library savedLibrary = libraryRepository.save(library);
        URI location = ServletUriComponentsBuilder.fromCurrentRequest()
                .path("/{id}")
                .buildAndExpand(savedLibrary.getId())
                .toUri();
        return ResponseEntity.created(location).body(savedLibrary);
    }
    @PutMapping("/{id}")
    public ResponseEntity<Library> updateLibrary(@PathVariable Long id,@Validated @RequestBody Library library) {
       Optional<Library> optionalLibrary = libraryRepository.findById(id);
       if (!optionalLibrary.isPresent()){
              return ResponseEntity.unprocessableEntity().build();
         }
         library.setId(optionalLibrary.get().getId());
         libraryRepository.save(library);

        return ResponseEntity.noContent().build();
    }
    @DeleteMapping("/{id}")
    public ResponseEntity<Library> deleteByLibraryId(@PathVariable Long id) {
        Optional<Library> optionalLibrary = libraryRepository.findById(id);
        if (!optionalLibrary.isPresent()) {
            return ResponseEntity.unprocessableEntity().build();
        }

        deleteLibraryInTransaction(optionalLibrary.get());

        return ResponseEntity.noContent().build();
    }

    @Transactional
    public void deleteLibraryInTransaction(Library library) {
        bookRepository.deleteByLibraryId(library.getId());
        libraryRepository.delete(library);
    }
    @GetMapping("/{id}")
   public ResponseEntity<Library> getLibraryById(@PathVariable Long id) {
        Optional<Library> optionalLibrary = libraryRepository.findById(id);
        if (!optionalLibrary.isPresent()) {
            return ResponseEntity.unprocessableEntity().build();
        }
        return ResponseEntity.ok(optionalLibrary.get());
    }
    @GetMapping
    public ResponseEntity<Page<Library>> getAll(Pageable pageable) {
        return ResponseEntity.ok(libraryRepository.findAll(pageable));
    }

}