package com.nagendrajava.springboot.jpa;

import com.nagendrajava.springboot.jpa.model.IDCard;
import com.nagendrajava.springboot.jpa.model.Person;
import com.nagendrajava.springboot.jpa.repository.IDCardRepository;
import com.nagendrajava.springboot.jpa.repository.PersonRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.transaction.annotation.Transactional;

import java.util.Arrays;

@RequiredArgsConstructor
@SpringBootApplication
public class SpringBootOnetooneMappingApplication implements CommandLineRunner {
	private final IDCardRepository idCardRepository;
	private final PersonRepository personRepository;

	public static void main(String[] args) {
		SpringApplication.run(SpringBootOnetooneMappingApplication.class, args);
	}

	@Override
	@Transactional
	public void run(String... args) throws Exception {
		Person p1 = new Person("Tom");
		Person p2 = new Person("Daisy");
		Person p3 = new Person("Alex");
		personRepository.saveAll(Arrays.asList(p1, p2, p3));

		idCardRepository.save(new IDCard(p1));
		idCardRepository.save(new IDCard(p2));
		idCardRepository.save(new IDCard(p3));

	}
}
