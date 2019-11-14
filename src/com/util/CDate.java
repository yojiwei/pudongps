// Decompiled by Jad v1.5.7g. Copyright 2000 Pavel Kouznetsov.
// Jad home page: http://www.geocities.com/SiliconValley/Bridge/8617/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi 
// Source File Name:   CDate.java

package com.util;


import java.text.SimpleDateFormat;
import java.util.*;

// Referenced classes of package com.util:
//            CTools

public class CDate
{

    public static final int FORMAT_DATEONLY = 1;
    public static final int FORMAT_TIMEONLY = 2;
    public static final int FORMAT_DATETIME = 3;
    public static final int FORMAT_HOUR_MINUTE = 4;
    public static final int FORMAT_DATEONLY_CHINESE = 5;
    public static final int FORMAT_TIMEONLY_CHINESE = 6;
    public static final int FORMAT_DATETIME_CHINESE = 7;
    public static final int FORMAT_MONTH_DAY_HOUR_MINUTE_CHINESE = 8;
    public static final int FORMAT_MONTH_DAY_HOUR_MINUTE = 9;
    public static final int FORMAT_MONTH_DAY = 10;
    public static final int FORMAT_YEAR_MONTH = 11;
    //Date today;
    Calendar calendar = Calendar.getInstance();

    public CDate()
    {
    	calendar = Calendar.getInstance();
    }

    public static final int getNowYear()
    {
        int nowyear = Calendar.getInstance().get(Calendar.YEAR);
        return nowyear;
    }

    public static final int getNowMonth()
    {
        int nowmonth = Calendar.getInstance().get(Calendar.MONTH) + 1;
        return nowmonth;
    }

    public static final int getNowDay()
    {
        int nowday = Calendar.getInstance().get(Calendar.DAY_OF_MONTH);
        return nowday;
    }

    public static String getNowWeek()
    {
        String weekName = "星期";
        String arrWeekName[] = {
        		"六","日", "一", "二", "三", "四", "五"
        };
        return weekName + arrWeekName[Calendar.getInstance().get(Calendar.DAY_OF_WEEK)];
    }

    public static final String getNowHour()
    {
        String nowhour = String.valueOf((Calendar.getInstance().get(Calendar.HOUR_OF_DAY)));
        if(nowhour.length() == 1)
            nowhour = "0" + nowhour;
        return nowhour;
    }

    public static final String getNowMinute()
    {
        String nowminute = String.valueOf((Calendar.getInstance().get(Calendar.MINUTE)));
        if(nowminute.length() == 1)
            nowminute = "0" + nowminute;
        return nowminute;
    }

    public static final String getTheTime()
    {
        String thetime = getNowHour() + ":" + getNowMinute();
        return thetime;
    }

    public static final int getThisTime()
    {
        String thistime = getNowHour() + getNowMinute();
        int thetime = Integer.parseInt(thistime);
        return thetime;
    }

    public static final String getNowTime()
    {
        String nowtime = getNowYear() + "-" + getNowMonth() + "-"+getNowDay() + " " 
        		+ getNowHour() + ":" + getNowMinute() + ":" + getNowSecond();
        return nowtime;
    }

    public static final String getThisday()
    {
        String nyear = String.valueOf(getNowYear());
        String nmonth = String.valueOf(getNowMonth());
        if(nmonth.length() == 1)
            nmonth = "0" + nmonth;
        String nday = String.valueOf(getNowDay());
        if(nday.length() == 1)
            nday = "0" + nday;
        String thisday = nyear + "-" + nmonth + "-" + nday;
        return thisday;
    }

    public static final int getWeekDay(Date _date)
    {
        int _weekday = 0;
        return _weekday;
    }

    public static final int getYear(Date _date)
    {
        int year = _date.getYear() + 1900;
        return year;
    }

    public static final int getMonth(Date _date)
    {
        int month = _date.getMonth() + 1;
        return month;
    }

    public static final int getDay(Date _date)
    {
        int day = _date.getDate();
        return day;
    }

    public static final String getHour(Date _date)
    {
        String hour = String.valueOf(_date.getHours());
        if(hour.length() == 1)
            hour = "0" + hour;
        return hour;
    }

    public static final String getMinute(Date _date)
    {
        String minute = String.valueOf(_date.getMinutes());
        if(minute.length() == 1)
            minute = "0" + minute;
        return minute;
    }

    public static final String getSecond(Date _date)
    {
        String second = String.valueOf(_date.getSeconds());
        if(second.length() == 1)
            second = "0" + second;
        return second;
    }

    public static final String getTheTime(Date _date)
    {
        String thetime = getHour(_date) + ":" + getMinute(_date);
        return thetime;
    }

    public static final String getTime(Date _date)
    {
    	
        String time = (_date.getYear() + 1900) + "-" + (_date.getMonth() + 1) + "-" + _date.getDate() + " " + 
        		_date.getHours() + ":" + _date.getMinutes()	+ ":" + _date.getSeconds();;
        return time;
    }

    public static final Date toDate(String strDate)
    {
    	return new Date(CTools.replace(CTools.replace(strDate, "-", "/"), ".0", ""));
    }

    public static final String getday(Date _date)
    {
        String nyear = String.valueOf(getYear(_date));
        String nmonth = String.valueOf(getMonth(_date));
        if(nmonth.length() == 1)
            nmonth = "0" + nmonth;
        String nday = String.valueOf(getDay(_date));
        if(nday.length() == 1)
            nday = "0" + nday;
        String day = nyear + "-" + nmonth + "-" + nday;
        return day;
    }

    public static final String Format(Date date, int flag)
    {
        String str = "";
        if(date == null)
            return "";
        switch(flag)
        {
        case 1: // '\001'
            str = getday(date);
            break;

        case 2: // '\002'
            str = CTools.split(getTime(date), " ")[1];
            break;

        case 3: // '\003'
            str = getTime(date);
            break;

        case 4: // '\004'
            str = getTheTime(date);
            break;

        case 5: // '\005'
            str = getYear(date) + "年" + getMonth(date) + "月" + getDay(date) + "日";
            break;

        case 6: // '\006'
            str = getHour(date) + "时" + getMinute(date) + "分" + getSecond(date) + "秒";
            break;

        case 7: // '\007'
            str = Format(date, 5) + Format(date, 6);
            break;

        case 8: // '\b'
            str = getMonth(date) + "月" + getDay(date) + "日" + getHour(date) + "时" + getMinute(date) + "分";
            break;

        case 9: // '\t'
            str = getMonth(date) + "/" + getDay(date) + " " + getHour(date) + ":" + getMinute(date);
            break;

        case 10: // '\n'
            str = getMonth(date) + "/" + getDay(date);
            break;

        case 11: // '\013'
            str = getYear(date) + "年" + getMonth(date) + "月";
            break;
        }
        return str;
    }

    public static final int getMonthDays(int year, int month)
    {
        int _arrDays[] = {
            0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 
            31, 30, 31
        };
        int _monthDays = _arrDays[month];
        if(year % 4 == 0 && month == 2)
            _monthDays = 29;
        return _monthDays;
    }

    public static final int getQuarter(int month)
    {
        int quarter = 1;
        if(month > 0 && month < 4)
            quarter = 1;
        else
        if(7 > month && month > 3)
            quarter = 2;
        else
        if(10 > month && month > 6)
            quarter = 3;
        else
            quarter = 4;
        return quarter;
    }

    public static long dateDiff(String strType, Date startDate, Date endDate)
    {
        long diff = startDate.getTime() - endDate.getTime();
        if(strType.equals("ss"))
            diff /= 1000L;
        if(strType.equals("mi"))
            diff = diff / 1000L / 60L;
        if(strType.equals("hh"))
            diff = diff / 1000L / 60L / 60L;
        if(strType.equals("dd"))
            diff = diff / 1000L / 60L / 60L / 24L;
        if(strType.equals("mm"))
            diff = diff / 1000L / 60L / 60L / 24L / 30L;
        return diff;
    }

    public static String FilterDate(String myD)
    {
        if(myD.equals("1950-01-01") || myD.equals("1950年1月1日"))
            return "";
        else
            return myD;
    }

    public int getDayCount(int year, int month)
    {
        int dayCount = -1;
        boolean isLeapYear = false;
        if(year <= 0 || month <= 0)
            return dayCount;
        if(year % 4 == 0 && year % 100 != 0 || year % 400 == 0)
            isLeapYear = true;
        switch(month)
        {
        default:
            break;

        case 1: // '\001'
        case 3: // '\003'
        case 5: // '\005'
        case 7: // '\007'
        case 8: // '\b'
        case 10: // '\n'
        case 12: // '\f'
            dayCount = 31;
            break;

        case 4: // '\004'
        case 6: // '\006'
        case 9: // '\t'
        case 11: // '\013'
            dayCount = 30;
            break;

        case 2: // '\002'
            if(isLeapYear)
                dayCount = 29;
            else
                dayCount = 28;
            break;
        }
        return dayCount;
    }

    public static String getNowSecond()
    {
        String nowSecond = String.valueOf(Calendar.getInstance().get(Calendar.SECOND));
        if(nowSecond.length() == 1)
            nowSecond = "0" + nowSecond;
        return nowSecond;
    }

    public String getFullTime()
    {
        String fullTime = getDay() + getThisTime() + getNowSecond();
        return fullTime;
    }

    public String getDay()
    {
        String nyear = String.valueOf(getNowYear());
        String nmonth = String.valueOf(getNowMonth());
        if(nmonth.length() == 1)
            nmonth = "0" + nmonth;
        String nday = String.valueOf(getNowDay());
        if(nday.length() == 1)
            nday = "0" + nday;
        String thisday = nyear + nmonth + nday;
        return thisday;
    }

    public String getMonthDay()
    {
        String nmonth = String.valueOf(getNowMonth());
        if(nmonth.length() == 1)
            nmonth = "0" + nmonth;
        String nday = String.valueOf(getNowDay());
        if(nday.length() == 1)
            nday = "0" + nday;
        String thisday = nmonth + nday;
        return thisday;
    }

    public String getYearMonthDay()
    {
        String nyear = String.valueOf(getNowYear());
        String nmonth = String.valueOf(getNowMonth());
        if(nmonth.length() == 1)
            nmonth = "0" + nmonth;
        String nday = String.valueOf(getNowDay());
        if(nday.length() == 1)
            nday = "0" + nday;
        String thisday = nyear + nmonth + nday;
        return thisday;
    }

    public Date addDay(Date myDate, int difDay)
    {
        GregorianCalendar cal = (GregorianCalendar)Calendar.getInstance();
        cal.setTime(myDate);
        cal.add(5, difDay);
        return cal.getTime();
    }

    public Date addMonth(Date myDate, int difMonth)
    {
        Calendar cal = Calendar.getInstance();
        cal.setTime(myDate);
        cal.add(2, difMonth);
        return cal.getTime();
    }

    public Date addYear(Date myDate, int difYear)
    {
        Calendar cal = Calendar.getInstance();
        cal.setTime(myDate);
        cal.add(1, difYear);
        return cal.getTime();
    }

    public int getDaysOfMonth(Date myDate)
    {
        GregorianCalendar gcal = new GregorianCalendar();
        gcal.setTime(myDate);
        int days = gcal.getActualMaximum(5);
        return days;
    }

    public String getFirstDayOfMonth(Date myDate)
    {
        GregorianCalendar gcal = new GregorianCalendar();
        gcal.setTime(myDate);
        SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-");
        return sf.format(gcal.getTime()) + "01";
    }

    public String getEndDayOfMonth(Date myDate)
    {
        GregorianCalendar gcal = new GregorianCalendar();
        gcal.setTime(myDate);
        int days = getDaysOfMonth(myDate);
        SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-");
        return sf.format(gcal.getTime()) + Integer.toString(days);
    }

    public String getFirstDayOfYear(Date myDate)
    {
        GregorianCalendar gcal = new GregorianCalendar();
        gcal.setTime(myDate);
        SimpleDateFormat sf = new SimpleDateFormat("yyyy-");
        return sf.format(gcal.getTime()) + "01-01";
    }

    public static final String getLastday()
    {
        String nyear = String.valueOf(getNowYear());
        String nmonth = String.valueOf(getNowMonth());
        String nday = String.valueOf(getNowDay());
        int dayday[] = {
            4, 6, 9, 11
        };
        int years = Integer.parseInt(nyear);
        int months = Integer.parseInt(nmonth);
        int days = Integer.parseInt(nday);
        if(nmonth.length() == 1)
        {
            if(months == 1)
            {
                nyear = String.valueOf(years - 1);
                nmonth = "12";
            } else
            if(months == 3)
            {
                if(years % 4 == 0)
                {
                    if(days > 28)
                        days = 28;
                } else
                if(days > 29)
                    days = 29;
                nmonth = "0" + (months - 1);
            } else
            {
                for(int i = 0; i < dayday.length; i++)
                {
                    if(months - 1 == dayday[i] && days >= 31)
                        days = 30;
                    nmonth = "0" + (months - 1);
                }

            }
        } else
        {
            for(int i = 0; i < dayday.length; i++)
                if(months - 1 == dayday[i] && days >= 31)
                    days = 30;

            nmonth = String.valueOf(months - 1);
        }
        if(nday.length() == 1)
            nday = "0" + nday;
        else
            nday = String.valueOf(days);
        String thisday = nyear + "-" + nmonth + "-" + nday;
        return thisday;
    }

    public static final String getFormatDay(String myDate)
    {
        String returnDate = "";
        try
        {
            String d[] = myDate.split("-");
            returnDate = d[0];
            if(d[1].length() == 1)
                returnDate = returnDate + "-0" + d[1];
            else
                returnDate = returnDate + "-" + d[1];
            if(d[2].length() == 1)
                returnDate = returnDate + "-0" + d[2];
            else
                returnDate = returnDate + "-" + d[2];
        }
        catch(ArrayIndexOutOfBoundsException e)
        {
            System.out.println("CDate.getFormatDay" + e.getMessage());
        }
        return returnDate;
    }

    public static void main(String args[])
    {
        //System.out.println(toDate("2008-11-22"));
        //System.out.println(Calendar.getInstance().get(Calendar.SECOND) + "" + Calendar.getInstance().get(Calendar.MILLISECOND));
        //System.out.println(getTime(new Date()));
        
    	//七天之后
//      Calendar co=Calendar.getInstance();
//      for (int i=0;i<8;i++) {
//      	co.add(Calendar.DAY_OF_MONTH,1);
//      }
//      java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd");
//      System.out.println("======"+formatter.format(co.getTime()));
    	
    	CDate cd = new CDate();
    	SimpleDateFormat formatter  = new SimpleDateFormat("yyyy-MM-dd");
    	try{
    		Date nowdate = formatter.parse("2011-05-20");
    		System.out.println(cd.Format(nowdate,5));
    	}catch(Exception ex){
    		ex.printStackTrace();
    	}
    	
	}
}
