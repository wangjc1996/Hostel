package nju.adrien.util;

import java.text.DecimalFormat;

public class NumberFormater {

    private static final DecimalFormat df_double = new DecimalFormat("00.00");
    private static final DecimalFormat df_int = new DecimalFormat("#");
    private static final DecimalFormat df_id = new DecimalFormat("0000000");
    private static final DecimalFormat df_bookid = new DecimalFormat("000000000000");

    public static String formatDouble(double input) {
        return df_double.format(input);
    }

    public static String formatInteger(int input) {
        return df_int.format(input);
    }

    public static String formatId(int input) {
        return df_id.format(input);
    }

    public static String formatLongId(int input) {
        return df_bookid.format(input);
    }

    public static double string2Double(String input) {
        double result = 0;
        try {
            result = Double.parseDouble(input);
        } catch (Exception e) {
            result = 0;
        }
        return result;
    }

    public static int string2Integer(String input) {
        int result = 0;
        try {
            result = Integer.parseInt(input);
        } catch (Exception e) {
            result = 0;
        }
        return result;
    }

    public static double doubleStander(double input){
        return  NumberFormater.string2Double(df_double.format(input));
    }
}
