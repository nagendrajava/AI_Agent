package com.ics.ds;

import java.util.Arrays;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.function.Function;
import java.util.stream.Collectors;

public class ThreeSumWithMap {
    public static void main(String[] args) {
     int arr [] = {0, -1, 2, -3, 1};
        int target =0;
        Set<List<Integer>> triplets = findTriplets(arr, target);
        System.out.println("Triplets that sum to " + target + ": " + triplets);
    }

    public static Set<List<Integer>> findTriplets(int[] arr, int target) {
        Set<List<Integer>> result = new java.util.HashSet<>();
        Map<Integer,Long> freqMap = Arrays.stream(arr).boxed().collect(Collectors.groupingBy(Function.identity(),Collectors.counting()));
        Arrays.sort(arr);
        for (int i = 0; i < arr.length; i++) {
            for(int j=i+1;j<arr.length ; j++){
                int sum = arr[i]+arr[j];
                int complement = target - sum;
                if(freqMap.containsKey(complement)){
                    long count = freqMap.get(complement);
                    if((complement==arr[i] || complement==arr[j]) && count <2)
                        continue;
                    if(arr[i]==arr[j] && complement==arr[i] && count <3)
                        continue;
                    List<Integer> triplet = Arrays.asList(arr[i], arr[j], complement);
                    triplet.sort(Integer::compareTo);
                    result.add(triplet);
                }
            }

        }
        return result;
    }
}
