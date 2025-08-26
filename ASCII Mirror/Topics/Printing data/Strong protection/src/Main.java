class Main {
    public static void main(String[] args) {
        int num = 1;
        for (int i = 0; i < 3; i++) {
            for (int j = 0; j < 3; j++) {
                System.out.print(num++);
            }
            System.out.println();
        }
        System.out.println("*0#");
    }
}
