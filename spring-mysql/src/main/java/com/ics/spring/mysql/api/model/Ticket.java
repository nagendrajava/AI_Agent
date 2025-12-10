package com.ics.spring.mysql.api.model;

import jakarta.persistence.*;
import lombok.*;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "Ticket")
public class Ticket {
    @Id
    @GeneratedValue
    private Long id;
    private double amount;
    private String category;
}
