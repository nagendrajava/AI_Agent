package com.nagendrajava.springboot.jpa.repository;

import com.nagendrajava.springboot.jpa.model.Person;
import org.springframework.data.jpa.repository.JpaRepository;

public interface PersonRepository extends JpaRepository<Person,Long> {
}
