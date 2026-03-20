package com.nagendrajava.springboot;

import com.nagendrajava.springboot.model.Book;
import com.nagendrajava.springboot.model.Publisher;
import com.nagendrajava.springboot.repository.BookRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class SpringBootManyToManyApplication implements CommandLineRunner {
    @Autowired
	private BookRepository bookRepository;

	public static void main(String[] args) {
		SpringApplication.run(SpringBootManyToManyApplication.class, args);
	}
	@Override
	public void run(String... args) {
		// Create a couple of Book and Publisher
		bookRepository.save(new Book("Book 1", new Publisher("Publisher A"), new Publisher("Publisher B")));
	}

}
