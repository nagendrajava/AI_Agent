package com.ics.ds;

public class NonRepettingChar {
    public static void main(String[] args) {
        // Problem:
        //Given a string, return the first non-repeating character. If none exists, return -1. using java 8 lambda and streams
        String input = "swiss";
        char result = findFirstNonRepeatingChar(input);
        if (result != '\0') {
            System.out.println("First non-repeating character: " + result);
        } else {
            System.out.println("No non-repeating character found.");
        }

    }

    private static char findFirstNonRepeatingChar(String input) {
        // Using Java 8 Streams to find the first non-repeating character
        return input.chars()
                .mapToObj(c -> (char) c)
                .filter(c -> input.indexOf(c) == input.lastIndexOf(c))
                .findFirst()
                .orElse('\0'); // Return '\0' if no non-repeating character is found
    }

}
