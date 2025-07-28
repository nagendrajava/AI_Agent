package com.nagendrajava.springboot.mapper;

import com.nagendrajava.springboot.dto.LibraryDTO;
import com.nagendrajava.springboot.model.Library;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.MappingTarget;

@Mapper(componentModel = "spring", uses = {BookMapper.class})
public interface LibraryMapper {
    LibraryDTO toDto(Library library);
    Library toEntity(LibraryDTO libraryDTO);
    @Mapping(target = "id", ignore = true)
    void updateLibraryFromDto(LibraryDTO dto, @MappingTarget Library entity);
}
