package com.ics.ds;

import java.util.HashMap;
import java.util.Map;

public class LongestSubArraySum {
    public static void main(String[] args) {
       // Given an array of integers, find the length of the longest subarray with a sum of 0.
        int[] arr = {1, -1, 2, -2, 3, -3, 6, -4};
        int result = longestSubArrayWithSumZero(arr);
        System.out.println("Length of the longest subarray with sum 0: " + result);
    }

    private static int longestSubArrayWithSumZero(int[] arr) {
        int maxLength = 0;
        int sum = 0;
        Map<Integer, Integer> sumIndexMap = new HashMap<>();

        for (int i = 0; i < arr.length; i++) {
            sum += arr[i];

            // If the sum is zero, update maxLength
            if (sum == 0) {
                maxLength = i + 1; // Length from start to current index
            }

            // If this sum has been seen before, calculate the length of the subarray
            if (sumIndexMap.containsKey(sum)) {
                int length = i - sumIndexMap.get(sum);
                maxLength = Math.max(maxLength, length);
            } else {
                // Store the first occurrence of this sum
                sumIndexMap.put(sum, i);
            }
        }
        return maxLength;
    }
}
