package com.ics.ds;

import java.util.Scanner;
import java.util.stream.IntStream;

public class DivideByFourMax {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        System.out.println(
                IntStream.range(0, scanner.nextInt())
                        .map(i -> scanner.nextInt()).filter(n -> n % 4 == 0)
                        .max()
                        .getAsInt()
        );
        scanner.close();
    }

}

