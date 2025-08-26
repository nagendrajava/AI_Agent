package com.ics.ds;


import java.util.LinkedHashMap;
import java.util.Map;

public class FirstNonRepeatingC {
    public static char firstUniqueChar(String s){
        Map<Character,Integer> countMap = new LinkedHashMap<>();

        for(char c: s.toCharArray()){
            countMap.put(c,countMap.getOrDefault(c,0)+1);
        }
        for (Map.Entry<Character,Integer> entry: countMap.entrySet()){
            if (entry.getValue()==1)
                return entry.getKey();
        }

        return '_';
    }
    public static void main(String[] args) {

        System.out.println(firstUniqueChar("aabbccdeff"));
    }
}
