package com.ics.ds;

import java.util.HashMap;
import java.util.Map;

public class FirstNonRepettingChar {
    public static void main(String[] args) {
        // Problem:
        //Given a string, return the first non-repeating character. If none exists, return -1. best Order O(n)
        String input = "swiss";
        char result = findFirstNonRepeatingChar(input);
        if (result != '\0') {
            System.out.println("First non-repeating character: " + result);
        } else {
            System.out.println("No non-repeating character found.");
        }

    }

    private static char findFirstNonRepeatingChar(String input) {
        Map<Character, Integer> charCountMap = new HashMap<>();
        for(char c : input.toCharArray()) {
            charCountMap.put(c, charCountMap.getOrDefault(c, 0) + 1);
        }
        for(Map.Entry<Character,Integer> entry: charCountMap.entrySet()) {
            if (entry.getValue() == 1) {
              return   entry.getKey(); // Return the first non-repeating character
            }
        }
        return '\0'; // Return '\0' if no non-repeating character is found
    }

}
