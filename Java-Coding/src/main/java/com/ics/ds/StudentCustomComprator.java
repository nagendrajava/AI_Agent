package com.ics.ds;

import java.util.*;

class StudentCustomComprator {
int rollno;
String name;
String address;

// Constructor
public StudentCustomComprator(int rollno, String name, String address) {
this.rollno = rollno;
this.name = name;
this.address = address;
}

// toString method to print student details
public String toString() {
return this.rollno + " " + this.name + " " + this.address;
}
}
// Comparator to sort students by roll number
class SortByRoll implements Comparator<StudentCustomComprator> {
    public int compare(StudentCustomComprator a, StudentCustomComprator b) {
        return a.rollno - b.rollno;
    }
}

// Comparator to sort students by name
class SortByName implements Comparator<StudentCustomComprator> {
    public int compare(StudentCustomComprator a, StudentCustomComprator b) {
        return a.name.compareTo(b.name);
    }
}
