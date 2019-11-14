// Decompiled by Jad v1.5.7g. Copyright 2000 Pavel Kouznetsov.
// Jad home page: http://www.geocities.com/SiliconValley/Bridge/8617/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi 
// Source File Name:   TimeStamp.java

package net.fiyu.edit;

import java.util.Calendar;
import java.util.GregorianCalendar;

public class TimeStamp
{

    private String am_pm;
    private Calendar c;
    private String date;
    private String day;
    private String hour;
    private String minute;
    private String month;
    private String nanos;
    private String second;
    private String year;

    public TimeStamp()
    {
        c = new GregorianCalendar();
        year = Integer.toString(c.get(1));
        int i = c.get(2);
        i++;
        month = Integer.toString(i);
        day = Integer.toString(c.get(5));
        int j = c.get(10);
        minute = Integer.toString(c.get(12));
        second = Integer.toString(c.get(13));
        nanos = Integer.toString(c.get(14));
        i = c.get(9);
        if(i == 1)
            hour = hour + 12;
        hour = Integer.toString(j);
        am_pm = Integer.toString(i);
    }

    public String Time_Article()
    {
        date = add(year) + add(month) + add(day) + add(hour) + add(minute) + add(second) + add(nanos);
        return date;
    }

    public String Time_Date()
    {
        date = add(year) + "-" + add(month) + "-" + add(day) + " " + add(hour) + ":" + add(minute) + ":" + add(second);
        return date;
    }

    public String Time_Stamp()
    {
        date = add(year) + add(month) + add(day) + add(hour) + add(minute) + add(second) + add(nanos);
        return date;
    }

    public String Time_YMD()
    {
        date = add(year) + add(month) + add(day) + add(hour) + add(minute) + add(second);
        return date;
    }

    public String add(String s)
    {
        int i = s.length();
        if(i == 1)
            s = "0" + s;
        return s;
    }

    public String getAm_pm()
    {
        return add(am_pm);
    }

    public String getDay()
    {
        return add(day);
    }

    public String getHour()
    {
        return add(hour);
    }

    public String getMinute()
    {
        return add(minute);
    }

    public String getMonth()
    {
        return add(month);
    }

    public String getNanos()
    {
        return add(nanos);
    }

    public String getSecond()
    {
        return add(second);
    }

    public String getYear()
    {
        return add(year);
    }
}
