package com.nagendrajava.springboot.jpa.repository;

import com.nagendrajava.springboot.jpa.model.IDCard;
import com.nagendrajava.springboot.jpa.model.Person;
import org.springframework.data.jpa.repository.JpaRepository;

public interface IDCardRepository extends JpaRepository<IDCard,Long> {
}
