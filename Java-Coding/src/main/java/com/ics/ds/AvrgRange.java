package com.ics.ds;

import java.lang.reflect.Array;
import java.util.Arrays;
import java.util.Scanner;
import java.util.function.Function;
import java.util.stream.Collector;
import java.util.stream.Collectors;
import java.util.stream.IntStream;
import java.util.stream.LongStream;

public class AvrgRange {

    public static void main(String [] args) {
        Scanner scanner = new Scanner(System.in);
        int num1 = scanner.nextInt();
        int num2 = scanner.nextInt();
        System.out.println(IntStream.rangeClosed(num1, num2).filter(i -> i % 3 == 0).average().getAsDouble());
        // start coding here

        IntStream.rangeClosed(num1, num2).mapToObj(i -> i % 3 == 0 ? i % 5 == 0 ? "FizzBuzz" : "Fizz" : i % 5 == 0 ? "Buzz" : i).forEach(System.out::println);
        scanner.close();

        IntStream.rangeClosed(0, num1).filter(i->i %2 == 0).filter(j-> !((j >= 10) && (j <= 15))).forEach(System.out::print);
        LongStream.range(1,2).sum();
        double result = Math.pow(2,4);
        System.out.println(result);
        String s1 = "abvcc";// total char counting

        System.out.println(s1.chars().count());
    }
}

