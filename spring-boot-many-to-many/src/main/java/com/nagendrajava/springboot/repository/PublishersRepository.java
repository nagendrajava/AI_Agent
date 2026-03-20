package com.nagendrajava.springboot.repository;

import com.nagendrajava.springboot.model.Publisher;
import org.springframework.data.jpa.repository.JpaRepository;

public interface PublishersRepository extends JpaRepository<Publisher,Long> {
}
