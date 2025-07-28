package com.ics.spring.mysql.api.dao;

import com.ics.spring.mysql.api.model.Ticket;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface TicketDao  extends JpaRepository<Ticket,Long> {
}
