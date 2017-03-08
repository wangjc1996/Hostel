package nju.adrien.util.time;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.Instant;
import java.time.LocalDate;
import java.time.ZoneId;
import java.util.Calendar;
import java.util.Date;

/**
 * Created by JiachenWang on 2016/3/7.
 */
public class TimeConvert {

    public static Calendar convertDate(LocalDate localDate) {
        if (localDate == null)
            return null;

        ZoneId zone = ZoneId.systemDefault();
        Instant instant = localDate.atStartOfDay().atZone(zone).toInstant();
        Date date = Date.from(instant);
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(date);
        return calendar;
    }

    public static LocalDate convertCalendar(Calendar calendar) {
        int year = calendar.get(Calendar.YEAR);
        int month = calendar.get(Calendar.MONTH) + 1;
        int dayOfMonth = calendar.get(Calendar.DAY_OF_MONTH);
        LocalDate localDate = LocalDate.of(year, month, dayOfMonth);
        return localDate;
    }

    public static LocalDate covertString(String string) {
        String[] date = string.split("-");
        int year = Integer.valueOf(date[0]);
        int month = Integer.valueOf(date[1]);
        int dayOfMonth = Integer.valueOf(date[2]);
        LocalDate localdate = LocalDate.of(year, month, dayOfMonth);
        return localdate;
    }

    /**
     * String转化成Calendar类
     *
     * @param string
     * @return
     * @throws ParseException
     */
    public static Calendar covertToCalendar(String string) throws ParseException {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        Date date = sdf.parse(string);
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(date);
        return calendar;
    }

    public static String getDisplayDate(Calendar calendar) {
        int year = calendar.get(Calendar.YEAR);
        int month = calendar.get(Calendar.MONTH) + 1;
        int day = calendar.get(Calendar.DAY_OF_MONTH);
//
//        String y = year + "";
//        String m = month + "";
//        String d = day + "";
//
//        if(month!=10&&month!=11&&month!=12)
//            m = "0" + month;
//        if(day>=1&&day<=9)
//            d = "0" + day;
//
//        return y + "-" + m + "-" + d;
        return standardDate(year, month, day);
    }

    public static String getMonthAgoDate(Calendar calendar) {
        int year = calendar.get(Calendar.YEAR);
        int month = calendar.get(Calendar.MONTH);
        int day = calendar.get(Calendar.DAY_OF_MONTH);

        return standardDate(year, month, day);
    }

    public static String getDisplayDate(LocalDate date) {
        int year = date.getYear();
        int month = date.getMonth().getValue();
        int day = date.getDayOfMonth();
        System.out.print(standardDate(year, month, day));
        return standardDate(year, month, day);
    }

    public static String standardDate(int year, int month, int day) {
        String y = year + "";
        String m = month + "";
        String d = day + "";

        if (month != 10 && month != 11 && month != 12)
            m = "0" + month;
        if (day >= 1 && day <= 9)
            d = "0" + day;

        return y + "-" + m + "-" + d;
    }

}
