package com.ics.ds;

import java.lang.reflect.Array;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;
import java.util.stream.Collectors;

public class StringSplit {
    public static void main(String[] args) {
        String [] data =  {"Math_20","Eng_50", "Hindi_20","Math_50"};
       Map<String,Integer> results =  Arrays.stream(data).map(s->s.split("_")).collect(
                Collectors.groupingBy(arr->arr[0],
                        Collectors.summingInt(arr->Integer.parseInt(arr[1])))
        );
       Map<String,Integer> result = new HashMap<>();
       Arrays.stream(data).map(s->s.split("_")).forEach(
               arr-> result.merge(arr[0],Integer.parseInt(arr[1]),Integer::sum));

       result.forEach((subject,sum)-> System.out.println(subject +" = "+sum));

    }
}
