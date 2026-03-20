package com.nagendrajava.springboot.model;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;

import java.util.HashSet;
import java.util.Set;
@Entity
public class Library {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @NotNull
    private String name;

    @OneToMany(mappedBy = "library", cascade = {CascadeType.PERSIST,CascadeType.MERGE})
    private Set<Book> books = new HashSet<>();

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

   /* public Set<Book> getBooks() {
        return books;
    }*/

    public void setBooks(Set<Book> books) {
        this.books = books;

        for(Book b : books) {
            b.setLibrary(this);
        }
    }
}
