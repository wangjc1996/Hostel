package nju.adrien.util;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Date;
import java.util.Random;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class Utils {

    public static boolean isMobileNumber(String phone) {
        Pattern p = Pattern.compile("^\\d{11}$");
        Matcher m = p.matcher(phone);
        return m.matches();
    }

    public static String md5(String str) {
        try {
            MessageDigest md = MessageDigest.getInstance("MD5");
            md.update(str.getBytes());
            byte b[] = md.digest();
            int i;
            StringBuffer buf = new StringBuffer("");
            for (int offset = 0; offset < b.length; offset++) {
                i = b[offset];
                if (i < 0)
                    i += 256;
                if (i < 16)
                    buf.append("0");
                buf.append(Integer.toHexString(i));
            }
            //32位加密
            return buf.toString();
            // 16位的加密
            //return buf.toString().substring(8, 24);
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
            return null;
        }
    }

    public static boolean compareTime(Date record, Date current){
        return record.before(current);
    }
}
