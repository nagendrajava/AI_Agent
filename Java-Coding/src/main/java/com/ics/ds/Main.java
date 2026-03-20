package com.ics.ds;
import java.util.Scanner;

public class Main {

    // Define states as constants
    public static final int RED = 0;
    public static final int YELLOW = 1;
    public static final int GREEN = 2;
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        int currentState = scanner.nextInt();
        scanner.close();
        String nextState = getNextState(currentState);
        String action = getAction(currentState);

        System.out.println(nextState);
        System.out.println(action);
    }

    // Returns the next state as a String
    public static String getNextState(int currentState) {
        return String.valueOf(switch (currentState) {
            case RED -> YELLOW;
            case YELLOW -> GREEN;
            case GREEN -> RED;
            default -> throw new IllegalArgumentException("Invalid state: " + currentState);
        });
    }


    // Returns the action as a String
    public static String getAction(int currentState) {
        return switch (currentState) {
            case RED -> "Change to Yellow";
            case YELLOW -> "Change to Green";
            case GREEN -> "Change to Red";
            default -> throw new IllegalArgumentException("Invalid state: " + currentState);
        };
    }

}
