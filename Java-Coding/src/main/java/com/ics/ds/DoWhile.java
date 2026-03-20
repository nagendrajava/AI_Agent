package com.ics.ds;

import java.util.Scanner;
import java.util.stream.IntStream;

public class DoWhile {

        public static void main(String[] args) {
            Scanner sc = new Scanner(System.in);

            // start coding here
            int maxInt = 0 ;
            do
            {
                int num = sc.nextInt();
                maxInt = maxInt > num ? maxInt : num;
            }
            while(sc.nextInt() != 0);
            System.out.println(maxInt);
        }
    }