package com.ics.jpa.api.controller;

import com.ics.jpa.api.dao.PersonDao;
import com.ics.jpa.api.model.Person;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("spring-orm")
public class PersonController {

    @Autowired
    private PersonDao personDao;
    @PostMapping("/savePerson")
    public String save(@RequestBody Person person){

        personDao.savePerson(person);
  return "success";

    }
    @GetMapping("/getPersons")
    public List<Person> getPersons(){
       return personDao.getPersonS();
    }

}
