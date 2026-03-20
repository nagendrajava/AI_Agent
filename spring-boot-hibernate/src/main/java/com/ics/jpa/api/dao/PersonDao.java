package com.ics.jpa.api.dao;

import com.ics.jpa.api.model.Person;
import jakarta.persistence.criteria.CriteriaBuilder;
import jakarta.persistence.criteria.CriteriaQuery;
import jakarta.transaction.Transactional;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.repository.CrudRepository;
import org.springframework.orm.hibernate5.LocalSessionFactoryBean;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class PersonDao  {
    @Autowired
    private SessionFactory sessionFactory;
   @Transactional
   public void savePerson(Person person){
        getSession().save(person);
    }
    @Transactional
    public List<Person> getPersonS(){
        CriteriaQuery<Person> criteriaQuery = getSession().getCriteriaBuilder().createQuery(Person.class);
        criteriaQuery.from(Person.class);
        List<Person> persons = getSession().createQuery(criteriaQuery).getResultList();
        getSession().close();
        return persons;
    }

    public Session getSession(){
        Session session = sessionFactory.getCurrentSession();
        if(session==null){
            session = sessionFactory.openSession();
        }
        return session;
    }

}
