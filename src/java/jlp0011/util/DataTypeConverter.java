/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package jlp0011.util;

import java.text.Normalizer;
import java.util.regex.Pattern;

/**
 *
 * @author DELL
 */
public class DataTypeConverter {

    public static String convertVietnamese(String originalString) {
        String temp = Normalizer.normalize(originalString, Normalizer.Form.NFD);
        Pattern pattern = Pattern.compile(temp).compile("\\p{InCombiningDiacriticalMarks}+");
        return pattern.matcher(temp).replaceAll("").replace('đ', 'd').replace('Đ', 'D');
    }

}
