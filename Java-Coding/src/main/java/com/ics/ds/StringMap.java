package com.ics.ds;

import java.util.*;
import java.util.function.Function;
import java.util.stream.Collectors;
import java.util.stream.Stream;

public class StringMap {
    public static void main(String[] args) {
        String word = "shrikantsharma";

      List<Character> maps= word.chars().mapToObj(c->(char)c).
              collect(Collectors.groupingBy(
                Function.identity(),Collectors.counting()
        )).entrySet().stream().filter(entry->entry.getValue()>1).map(
                Map.Entry::getKey).collect(Collectors.toList()
              );

      System.out.println(maps);

      Set<Character> seen = new HashSet<>();

     Set<Character> duplicateChars =  word.chars().mapToObj(c->(char)c).filter(c->!seen.add(c))
              .collect(Collectors.toSet());

     System.out.println(duplicateChars);

     Set<Character> duplicates = word.chars().mapToObj(c->(char) c).collect(Collectors.toMap(
             Function.identity(),c->1, Integer::sum)).entrySet().stream().filter(entry-> entry.getValue()>1).map(Map.Entry::getKey).collect(Collectors.toSet()
     );

    }

   }
