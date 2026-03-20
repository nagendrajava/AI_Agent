package com.nagendrajava.springboot.model;

import jakarta.persistence.*;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.util.HashSet;
import java.util.Set;
import java.util.concurrent.Flow;
import java.util.stream.Collectors;
import java.util.stream.Stream;

@Data
@EqualsAndHashCode(exclude = "publishers")
@Entity
public class Book {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @Column(name = "name")

    private String name;
    @ManyToMany(cascade = CascadeType.ALL)
    @JoinTable(name = "book_publisher",
            joinColumns = @JoinColumn(name = "book_id", referencedColumnName = "id"),
            inverseJoinColumns = @JoinColumn(name = "publisher_id",referencedColumnName = "id"))
    private Set<Publisher> publishers = new HashSet<>();

    public Book(String name,Publisher... publishers ) {
        this.name = name;
        if (publishers != null) {
            this.publishers= Stream.of(publishers).collect(Collectors.toSet());
            this.publishers.forEach(publisher -> publisher.getBooks().add(this));
        }
    }

}
