package com.util;

import java.util.*;
import java.text.*;

public class CFormatDate {

private Date myDate; // 日期当前日期
private String strDate;
private Calendar myCal;

  public CFormatDate(String pDate) throws ParseException {
      this.strDate = pDate;
      DateFormat df = DateFormat.getDateInstance();
      SimpleDateFormat ft = new SimpleDateFormat("yyyy-MM-dd");
      //myDate = df.parse(this.strDate);
      myDate = ft.parse(this.strDate);
      myCal = df.getCalendar();
  }

  public static String getMonthDay(String strDatetime) throws ParseException
  {
      Date tempDate;
      String month,day;
      DateFormat df = DateFormat.getDateInstance();
      try
      {
        tempDate = df.parse(strDatetime);
        month = Integer.toString(tempDate.getMonth() + 1);
        day = Integer.toString(tempDate.getDate());
        return month + "-" + day;
      }
      catch(ParseException ex)
      {
        return "";
      }
  }
  public String getSecond()
  {
    return(Integer.toString(myCal.get(Calendar.SECOND)));
  }

  public String getYear()
  {
    return(Integer.toString(myCal.get(Calendar.HOUR)));
  }

  public String getFullDate()
  {
    DateFormat df = DateFormat.getDateInstance();
    SimpleDateFormat ft = new SimpleDateFormat("yyyy-MM-dd");
    //return(df.format(myDate));
    return(ft.format(myDate));
  }

  public static void main(String[] args) {
    try{
    CFormatDate CFormatDate1 = new CFormatDate("2002-2-1 12:12:34.0");
    System.out.println("=="+CFormatDate1.getFullDate());
    }
    catch(Exception ex)
    {
    }
  }
}