package com.nagendrajava.springboot.mapper;

import com.nagendrajava.springboot.dto.BookDTO;
import com.nagendrajava.springboot.model.Book;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.MappingTarget;

import java.util.List;

@Mapper(componentModel = "spring")
public interface BookMapper {

    @Mapping(source = "library.id", target = "libraryId")
    BookDTO toDto(Book book);
    @Mapping(source = "libraryId", target = "library.id")
    Book toEntity(BookDTO bookDTO);

    List<BookDTO> toDtoList(List<Book> books);
    List<Book> toEntityList(List<BookDTO> bookDTOs);
    @Mapping(target = "id", ignore = true)
    @Mapping(target = "library", ignore = true)
    void updateBookFromDto(BookDTO dto, @MappingTarget Book entity);
}

