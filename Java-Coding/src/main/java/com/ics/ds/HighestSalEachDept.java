package com.ics.ds;

import java.util.*;
import java.util.stream.Collectors;

public class HighestSalEachDept {
    public static void main(String[] args) {
        Employee e1 = new Employee(11L,50000.0,"IT");
        Employee e2 = new Employee(12L,65000.0,"IT");
        Employee e3 = new Employee(14L,35000.0,"QA");
        Employee e4 = new Employee(16L,45000.0,"QA");
        Employee e5 = new Employee(17L,25000.0,"DEVOPS");
        Employee e6 = new Employee(19L,30000.0,"DEVOPS");
        List<Employee> empList = List.of(e1,e2,e3,e4,e5,e6);

       Map<String, Optional<Employee>> highestSalByEmp = empList.stream().
                collect(Collectors.groupingBy(Employee::getDepartment,
                Collectors.maxBy(Comparator.comparingDouble(Employee::getSal))));

        highestSalByEmp.forEach((dept,emp)-> System.out.println("Dep"+dept+"-->"+emp.orElse(null)));

        Map<String, Employee> highestSalEmpDept = empList.stream().collect(
                Collectors.toMap(Employee::getDepartment, e->e,
                        (e,e15)->e.getSal()>e15.getSal()?e:e15)
        );
        highestSalEmpDept.forEach((dept,emp)-> System.out.println("Dep::"+dept+"-->"+emp.getSal()));
    }
}

class Employee{
    private Long id;
    private Double sal;
    private String department;

    public Employee(Long id, Double sal, String department){
        this.id = id;
        this.sal = sal;
        this.department = department;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Double getSal() {
        return sal;
    }

    public void setSal(Double sal) {
        this.sal = sal;
    }

    public String getDepartment() {
        return department;
    }

    public void setDepartment(String department) {
        this.department = department;
    }

    @Override
    public String toString() {
        return "Employee{" +
                "id=" + id +
                ", sal=" + sal +
                ", department='" + department + '\'' +
                '}';
    }

    @Override
    public boolean equals(Object o) {
        if (o == null || getClass() != o.getClass()) return false;
        Employee employee = (Employee) o;
        return Objects.equals(id, employee.id) && Objects.equals(sal, employee.sal) && Objects.equals(department, employee.department);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, sal, department);
    }
}
