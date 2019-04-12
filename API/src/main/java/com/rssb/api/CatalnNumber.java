package com.rssb.api;

public class CatalnNumber {

    // A recursive function to find nth catalan numberst
    static int[] c = new int[100];
    static int calls = 0;
    static int count = 0;

    static int bracket1s(int number) {
        return bracket1s(number, 0, "");
    }

    private static int bracket1s(int open, int close, String s) {

        if (open == 0 && close == 0) {
            return 1;
        }
        int x = 0, y = 0;

        if (open > 0)
            x = bracket1s(open - 1, close + 1, s + "(");
        if (close > 0)
            y = bracket1s(open, close - 1, s + ")");
        return x + y;
    }

    int catalan(int n) {

        ++calls;
        int res = 0;

        // Base case
        if (n <= 1) {
            return 1;
        }
        if (c[n] != 0)
            return c[n];

        for (int i = 0; i < n; i++) {
            System.out.println(i + "  " + (n - i - 1));
            res += catalan(i) * catalan(n - i - 1);
        }
        c[n] = res;
        return res;
    }

    static void brackets(int number) {
        brackets(number, 0, "");
    }

    static void brackets(int openStock, int closeStock, String s) {
        if (openStock == 0 && closeStock == 0) {
            System.out.println(s);
            ++count;
        }
        if (openStock > 0) {
            brackets(openStock - 1, closeStock + 1, s + "{");
        }
        if (closeStock > 0) {
            brackets(openStock, closeStock - 1, s + "}");
        }
    }

    static int bracketsCount(int openStock, int closeStock, String s) {
        if (openStock == 0 && closeStock == 0) {
            return 1;
        }

        int countL = 0, countR = 0;
        if (openStock > 0) {
            countL = bracketsCount(openStock - 1, closeStock + 1, s + "{");
        }
        if (closeStock > 0) {
            countR = bracketsCount(openStock, closeStock - 1, s + "}");
        }
        return countL + countR;
    }

    public static void anagrams(String str) {

        anagrams(str.toCharArray(), str.length(), 0);
    }

    private static void anagrams(char[] str, int length, int k) {

        if (k == length) {
            System.out.println(str);
            return;
        }

        for (int i = k; i < length; i++) {
            str = swap(str, k, i);
            anagrams(str, length, k + 1 );
            str = swap(str, k, i);
        }
    }

    public static char[] swap(char[] charArray, int i, int j) {
        char temp = charArray[i];
        charArray[i] = charArray[j];
        charArray[j] = temp;
        return charArray;
    }

    public static void main(String[] args) {

//        brackets(5);
//        System.out.println(count);
//
//        int z = bracket1s(5);
//        System.out.println(z);
//        System.out.println(bracketsCount(5, 0, ""));
        anagrams("cat");

    }
}