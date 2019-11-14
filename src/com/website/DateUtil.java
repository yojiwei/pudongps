// FrontEnd Plus GUI for JAD
// DeCompiled : DateUtil.class

package com.website;

import java.sql.Date;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;

public class DateUtil
{

    public DateUtil()
    {
    }

    public static java.util.Date parseDate(String dateStr, String format)
    {
        java.util.Date date = null;
        return date;
    }

    public static java.util.Date parseDate(String dateStr)
    {
        return parseDate(dateStr, "yyyy/MM/dd");
    }

    public static java.util.Date parseDate(Date date)
    {
        return date;
    }

    public static Date parseSqlDate(java.util.Date date)
    {
        if(date != null)
            return new Date(date.getTime());
        else
            return null;
    }

    public static Date parseSqlDate(String dateStr, String format)
    {
        java.util.Date date = parseDate(dateStr, format);
        return parseSqlDate(date);
    }

    public static Date parseSqlDate(String dateStr)
    {
        return parseSqlDate(dateStr, "yyyy/MM/dd");
    }

    public static Timestamp parseTimestamp(String dateStr, String format)
    {
        java.util.Date date = parseDate(dateStr, format);
        if(date != null)
        {
            long t = date.getTime();
            return new Timestamp(t);
        } else
        {
            return null;
        }
    }

    public static Timestamp parseTimestamp(String dateStr)
    {
        return parseTimestamp(dateStr, "yyyy/MM/dd  HH:mm:ss");
    }

    public static String format(java.util.Date date, String format)
    {
        String result = "";
        try
        {
            if(date != null)
            {
                DateFormat df = new SimpleDateFormat(format);
                result = df.format(date);
            }
        }
        catch(Exception exception) { }
        return result;
    }

    public static String format(java.util.Date date)
    {
        return format(date, "yyyy/MM/dd");
    }

    public static int getYear(java.util.Date date)
    {
        Calendar c = Calendar.getInstance();
        c.setTime(date);
        return c.get(1);
    }

    public static int getMonth(java.util.Date date)
    {
        Calendar c = Calendar.getInstance();
        c.setTime(date);
        return c.get(2) + 1;
    }

    public static int getDay(java.util.Date date)
    {
        Calendar c = Calendar.getInstance();
        c.setTime(date);
        return c.get(5);
    }

    public static int getHour(java.util.Date date)
    {
        Calendar c = Calendar.getInstance();
        c.setTime(date);
        return c.get(11);
    }

    public static int getMinute(java.util.Date date)
    {
        Calendar c = Calendar.getInstance();
        c.setTime(date);
        return c.get(12);
    }

    public static int getSecond(java.util.Date date)
    {
        Calendar c = Calendar.getInstance();
        c.setTime(date);
        return c.get(13);
    }

    public static long getMillis(java.util.Date date)
    {
        Calendar c = Calendar.getInstance();
        c.setTime(date);
        return c.getTimeInMillis();
    }

    public static String getDate(java.util.Date date)
    {
        return format(date, "yyyy/MM/dd");
    }

    public static String getTime(java.util.Date date)
    {
        return format(date, "HH:mm:ss");
    }

    public static String getDateTime(java.util.Date date)
    {
        return format(date, "yyyy/MM/dd  HH:mm:ss");
    }

    public static java.util.Date addDate(java.util.Date date, int day)
    {
        Calendar c = Calendar.getInstance();
        c.setTimeInMillis(getMillis(date) + (long)day * 24L * 3600L * 1000L);
        return c.getTime();
    }

    public static java.util.Date addMinute(java.util.Date date, int min)
    {
        Calendar c = Calendar.getInstance();
        c.setTimeInMillis(getMillis(date) + (long)min * 60L * 1000L);
        return c.getTime();
    }

    public static int diffDate(java.util.Date date, java.util.Date date1)
    {
        return (int)((getMillis(date) - getMillis(date1)) / 0x5265c00L);
    }

    public static boolean dAfter(java.util.Date date, java.util.Date date1)
    {
        return date.after(date1);
    }
}