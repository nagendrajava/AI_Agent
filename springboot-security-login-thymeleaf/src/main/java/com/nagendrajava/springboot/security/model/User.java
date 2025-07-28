package com.nagendrajava.springboot.security.model;

import jakarta.persistence.*;
import lombok.*;

import java.util.Set;
@Data

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@EqualsAndHashCode(onlyExplicitlyIncluded = true)

@Entity
@Table(name = "user")
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String username;
    private String password;

    @Transient
    private String passwordConfirm;
    @ManyToMany
    private Set <Role> roles;


}
