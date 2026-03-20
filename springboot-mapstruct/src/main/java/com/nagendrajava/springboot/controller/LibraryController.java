package com.nagendrajava.springboot.controller;

import com.nagendrajava.springboot.dto.LibraryDTO;
import com.nagendrajava.springboot.model.Library;
import com.nagendrajava.springboot.repository.BookRepository;
import com.nagendrajava.springboot.repository.LibraryRepository;
import com.nagendrajava.springboot.service.BookService;
import com.nagendrajava.springboot.service.LibraryService;
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
    private LibraryService libraryService;
    private BookService bookService;

    @Autowired
    public LibraryController(LibraryService libraryService, BookService bookService) {
        this.libraryService = libraryService;
        this.bookService = bookService;
    }

    @PostMapping
    public ResponseEntity<LibraryDTO> createLibrary(@Validated @RequestBody LibraryDTO libraryDTO) {
        LibraryDTO savedLibrary = libraryService.createLibrary(libraryDTO);
        URI location = ServletUriComponentsBuilder.fromCurrentRequest()
                .path("/{id}")
                .buildAndExpand(savedLibrary.getId())
                .toUri();
        return ResponseEntity.created(location).body(savedLibrary);
    }
    @PutMapping("/{id}")
    public ResponseEntity<LibraryDTO> updateLibrary(@PathVariable Long id,@Validated @RequestBody LibraryDTO library) {
       LibraryDTO optionalLibrary = libraryService.findLibraryById(id);
       if (optionalLibrary==null){
              return ResponseEntity.unprocessableEntity().build();
         }
        library.setId(optionalLibrary.getId());
        LibraryDTO updatedLibrary = libraryService.updateLibrary(id, library);
        return ResponseEntity.noContent().build();
    }
    @DeleteMapping("/{id}")
    public ResponseEntity<LibraryDTO> deleteByLibraryId(@PathVariable Long id) {
        LibraryDTO optionalLibrary = libraryService.findLibraryById(id);
        if (optionalLibrary == null) {
            return ResponseEntity.unprocessableEntity().build();
        }
        libraryService.deleteLibrary(id);
        return ResponseEntity.noContent().build();
    }

    @GetMapping("/{id}")
   public ResponseEntity<LibraryDTO> getLibraryById(@PathVariable Long id) {
        LibraryDTO optionalDTO = libraryService.findLibraryById(id);
        if (optionalDTO==null) {
            return ResponseEntity.unprocessableEntity().build();
        }
        return ResponseEntity.ok(optionalDTO);
    }
    @GetMapping
    public ResponseEntity<Page<LibraryDTO>> getAll(Pageable pageable) {
        return ResponseEntity.ok(libraryService.findAllLibraries(pageable));
    }

}