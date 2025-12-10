package com.nagendrajava.springboot.dto;

import lombok.Data;

import java.util.Set;

@Data
public class LibraryDTO {
    private Long id;
    private String name;
    private Set<BookDTO> books;
}