package com.ics.ds;

import java.util.List;

public class ThreeSumExample {
    public static List<List<Integer>> threeSum(int[] nums) {
        List<List<Integer>> result = new java.util.ArrayList<>();
        java.util.Arrays.sort(nums);
        int n = nums.length;

        for (int i = 0; i < n - 2; i++) {
            /*
             * Duplicate skipping logic for the FIRST element of the triplet:
             *
             * After sorting, equal numbers are adjacent. We only want to consider the FIRST
             * occurrence of any value as the fixed 'nums[i]' in order to avoid producing
             * duplicate triplets that start with the same number.
             *
             * Example (sorted input):
             *   [-4, -1, -1, 0, 1, 2]
             *   i=0 -> nums[i]=-4   (first time we see -4) -> allowed
             *   i=1 -> nums[i]=-1   (first time we see -1) -> allowed
             *   i=2 -> nums[i]=-1   (EQUAL to nums[i-1])   -> SKIPPED
             *
             * If we did NOT skip at i=2, every triplet formed starting with the second -1
             * would be identical to one already found when i=1 (because the remaining
             * search space to the right is the same or smaller, never producing new unique
             * combinations beginning with -1).
             *
             * Condition breakdown:
             *   i > 0                -> ensure there is a previous element to compare
             *   nums[i] == nums[i-1] -> current value is a duplicate of the previous
             * When both true, we continue to next i (skip processing this duplicate anchor).
             */
            if (i > 0 && nums[i] == nums[i - 1]) continue; // Skip duplicates for the first number

            int left = i + 1, right = n - 1;
            while (left < right) {
                int sum = nums[i] + nums[left] + nums[right];
                if (sum == 0) {
                    result.add(List.of(nums[i], nums[left], nums[right]));
                    /*
                     * After finding one valid triplet, we advance left and right while they
                     * still point to the same numbers as their immediate neighbors. This
                     * avoids emitting duplicate triplets that only differ by choosing the
                     * same duplicate value again for the second or third position.
                     */
                    while (left < right && nums[left] == nums[left + 1]) left++; // Skip duplicates for the second number
                    while (left < right && nums[right] == nums[right - 1]) right--; // Skip duplicates for the third number
                    left++;
                    right--;
                } else if (sum < 0) {
                    left++;
                } else {
                    right--;
                }
            }
        }

        return result;
    }

    public static void main(String[] args) {
        int[] nums = {-1, 0, 1, 2, -1, -4};
        List<List<Integer>> triplets = threeSum(nums);
        System.out.println(triplets); // Output: [[-1, -1, 2], [-1, 0, 1]]
    }
}
