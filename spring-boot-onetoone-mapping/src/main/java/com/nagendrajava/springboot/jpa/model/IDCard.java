package com.nagendrajava.springboot.jpa.model;

import jakarta.persistence.*;
import lombok.Data;

import java.util.UUID;

@Data
@Entity
public class IDCard {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long personId;
    @OneToOne(cascade = CascadeType.ALL, optional = false)
    @PrimaryKeyJoinColumn(name = "person_id", referencedColumnName = "id")
    private Person person;

    @Column(unique = true, nullable = false)
    private String code = UUID.randomUUID().toString();

    public IDCard(Person person) {
        this.person = person;
    }


}
