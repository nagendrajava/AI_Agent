package com.nagendrajava.springboot.dto;

import com.nagendrajava.springboot.model.Library;
import lombok.Data;

@Data
public class BookDTO {
    private Long id;
    private String name;
    private Long libraryId;
}