package com.ics.ds;

public class FindTripletSum0 {
    public static void main(String[] args) {
        int[] arr = {0, -1, 2, -3, 1};
        int n = arr.length;
        boolean found = false;

        for (int i = 0; i < n - 2; i++) {
            for (int j = i + 1; j < n - 1; j++) {
                for (int k = j + 1; k < n; k++) {
                    if (arr[i] + arr[j] + arr[k] == 0) {
                        System.out.println("Triplet: " + arr[i] + ", " + arr[j] + ", " + arr[k]);
                        found = true;
                    }
                }
            }
        }

        if (!found) {
            System.out.println("No triplets found");
        }
    }
}
