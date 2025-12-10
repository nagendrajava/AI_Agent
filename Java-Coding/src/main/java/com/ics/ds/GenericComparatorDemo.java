package com.ics.ds;

import java.util.*;

public class GenericComparatorDemo {
    public static void main(String[] args) {
        List<Integer> numbers = Arrays.asList(5, 2, 9, 1, 7);
        Collections.sort(numbers, new GenricComparator<>(Integer::compareTo));
        System.out.println("Sorted Numbers::" + numbers);
        List<String> words = Arrays.asList("banana", "apple", "cherry");
        Collections.sort(words, new GenricComparator<>((a, b) -> b.compareTo(a)));
        System.out.println("Sorted Words : " + words);
        List<Student> students = Arrays.asList(new Student(101, "Alice"),
                new Student(103, "Bob"),
                new Student(102, "Charlie"));

        Collections.sort(students, new GenricComparator<>(
                Comparator.comparingInt(Student::getRollNo).thenComparing(Student::getName)));

    }

}

    class Student{
        private int rollNo;
        private String name;

        public Student(int rollNo, String name){
            this.rollNo=rollNo;
            this.name= name;
        }
        @Override
        public String toString(){
            return rollNo+ "-"+name;
        }

        public int getRollNo() {
            return rollNo;
        }

        public String getName() {
            return name;
        }
    }

