package com.ics.spring.mysql.api.controller;

import com.ics.spring.mysql.api.dao.TicketDao;
import com.ics.spring.mysql.api.model.Ticket;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/ticket")
public class TicketController {

    @Autowired
    private TicketDao ticketDao;
    @PostMapping("/bookTickets")
    public String bookTickets(@RequestBody List<Ticket> tickets) {
        String returnString ="";
        if (tickets != null && !tickets.isEmpty()) {
            ticketDao.saveAll(tickets);
            returnString = "tickets booked : "+tickets.size();
        }
      return returnString;
    }
    @GetMapping("/getTickets")
    public List<Ticket> getTickets() {
        return ticketDao.findAll();
    }


}
