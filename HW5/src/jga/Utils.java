package jga;

public class Utils {
    public static Integer parseInt(String text, Integer def) {
        try {
            return new Integer(text);
        } catch (NumberFormatException e) {
            return def;
        }
    }
    public static int parseInt(String text) {
        return parseInt(text, 0);
    }
    public static Float parseFloat(String text, Float def) {
        try {
            return new Float(text);
        } catch (NumberFormatException e) {
            return def;
        }
    }
    public static float parseFloat(String text) {
        return parseFloat(text, 0.0f);
    }
}
