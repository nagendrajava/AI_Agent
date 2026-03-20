package com.ics.ds;

import java.util.*;
import java.util.stream.*;

public class ThreeSumStream {
    public static void main(String[] args) {
        int [] arr = {0, -1, 2, -3, 1};

        Arrays.sort(arr); // Sorting helps with deterministic output and canonical ordering.

        int n = arr.length;

        // Generate all index combinations i<j<k using IntStream (Java 8 compatible).
        Set<List<Integer>> zeroSumTriplets = IntStream.range(0, n - 2).boxed()
                .flatMap(i -> IntStream.range(i + 1, n - 1).boxed()
                        .flatMap(j -> IntStream.range(j + 1, n)
                                .mapToObj(k -> new int[]{arr[i], arr[j], arr[k]})))
                .filter(t -> t[0] + t[1] + t[2] == 0)
                .map(t -> {
                    Arrays.sort(t); // Ensure canonical order for de-duplication by value.
                    return Arrays.asList(t[0], t[1], t[2]); // Java 8 compatible.
                })
                .collect(Collectors.toCollection(LinkedHashSet::new)); // Remove duplicates while keeping order.

        System.out.println("Zero-sum triplets (unique, sorted): " + zeroSumTriplets);
        // Expected output for input {0, -1, 2, -3, 1} after sorting [-3,-1,0,1,2]: [[-3,1,2], [-1,0,1]]
    }
}
