package com.ics.ds;
import java.util .*;

public class ReduceArr {
    // write a method here
    public static int [] getFirstAndLast(int [] arr) {
        if (arr == null || arr.length == 0) {
            // Handle empty or null array case
            return Arrays.copyOf(arr, 0); // Return an empty array of the same type
        }

        int firstElement = Arrays.stream(arr)
                .findFirst().getAsInt(); // Will not be null if arr.length > 0

        int lastElement = arr[arr.length - 1];

        // Create a new array and populate it
        int [] result = Arrays.copyOf(arr, 2); // Create a new array of size 2
        result[0] = firstElement;
        result[1] = lastElement;

        return result;
    }

    /* Do not change code below */
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        int[] array = Arrays.stream(scanner.nextLine().split(" "))
                .mapToInt(Integer::parseInt)
                .toArray();
        int[] result = getFirstAndLast(array);
        Arrays.stream(result).forEach(e -> System.out.print(e + " "));
    }
}

