package com.ics.ds;

import java.util.ArrayList;
import java.util.Collections;

public class CustomCompratorMain {
    public static void main(String[] args) {
        ArrayList<StudentCustomComprator> ar = new ArrayList<StudentCustomComprator>();
        ar.add(new StudentCustomComprator(111, "Mayank", "London"));
        ar.add(new StudentCustomComprator(131, "Anshul", "NYC"));
        ar.add(new StudentCustomComprator(121, "Solanki", "Jaipur"));
        ar.add(new StudentCustomComprator(101, "Aggarwal", "Hongkong"));

        System.out.println("Unsorted");
        for (int i = 0; i < ar.size(); i++)
            System.out.println(ar.get(i));

        Collections.sort(ar, new SortByRoll());
        System.out.println("\nSorted by roll number");
        for (int i = 0; i < ar.size(); i++)
            System.out.println(ar.get(i));

        Collections.sort(ar, new SortByName());
        System.out.println("\nSorted by name");
        for (int i = 0; i < ar.size(); i++)
            System.out.println(ar.get(i));
    }
}
