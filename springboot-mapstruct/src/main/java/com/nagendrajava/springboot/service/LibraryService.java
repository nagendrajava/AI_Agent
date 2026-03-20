package com.nagendrajava.springboot.service;

import com.nagendrajava.springboot.dto.LibraryDTO;
import com.nagendrajava.springboot.mapper.LibraryMapper;
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
public class LibraryService {

    private final LibraryRepository libraryRepository;
    private final BookRepository bookRepository;
    private final LibraryMapper libraryMapper;

    @Autowired
    public LibraryService(LibraryRepository libraryRepository,
                          BookRepository bookRepository,
                          LibraryMapper libraryMapper) {
        this.libraryRepository = libraryRepository;
        this.bookRepository = bookRepository;
        this.libraryMapper = libraryMapper;
    }

    //  Get all libraries as DTOs
    public Page<LibraryDTO> findAllLibraries(Pageable pageable) {
        return libraryRepository.findAll(pageable)
                .map(libraryMapper::toDto);
    }

    //  Get library by ID
    public LibraryDTO findLibraryById(Long id) {
        Library library = libraryRepository.findByIdWithBooks(id)
                .orElseThrow(() -> new IllegalArgumentException("Library not found"));
        return libraryMapper.toDto(library);
    }

    // ➕ Create library
    public LibraryDTO createLibrary(LibraryDTO libraryDTO) {
        Library library = libraryMapper.toEntity(libraryDTO);
        if (library.getBooks() != null) {
            for (Book book : library.getBooks()) {
                book.setLibrary(library);
            }
        }
        Library saved = libraryRepository.save(library);
        Library savedWithBooks = libraryRepository.findByIdWithBooks(saved.getId())
                .orElseThrow(() -> new IllegalArgumentException("Library not found"));

        return libraryMapper.toDto(savedWithBooks);

    }

    // 🔄 Update library
    public LibraryDTO updateLibrary(Long id, LibraryDTO libraryDTO) {
        Library existingLibrary = libraryRepository.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("Library not found"));

        libraryMapper.updateLibraryFromDto(libraryDTO, existingLibrary);
        existingLibrary.setId(id); // Maintain ID integrity

        Library updatedLibrary = libraryRepository.save(existingLibrary);
        return libraryMapper.toDto(updatedLibrary);
    }

    // 🗑️ Delete library
    public void deleteLibrary(Long id) {
        if (!libraryRepository.existsById(id)) {
            throw new IllegalArgumentException("Library not found");
        }
        bookRepository.deleteByLibraryId(id);
        libraryRepository.deleteById(id);
    }
}