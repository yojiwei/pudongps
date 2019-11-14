package com.website;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.Timer;

import com.util.CDate;
/**
 * 取得新闻的一周排行
 * @author terry
 */
public class AutoGetNewsWeek {
	private final static long fONCE_PER_DAY = 1000*60*60*24;
	private final static int fONE_DAY = 1;
	private final static int fFOUR_AM = 3;
	private final static int fZERO_MINUTES = 33;
	
	public AutoGetNewsWeek() {
		System.out.println("==================");
		Timer timer = new Timer();
		timer.schedule(new TaskNews(),getTomorrowMorning333(),fONCE_PER_DAY);
	}
	
	private static Date getTomorrowMorning333() {
	    Calendar tomorrow = new GregorianCalendar();
	    tomorrow.add(Calendar.DATE, fONE_DAY);
	    Calendar result = new GregorianCalendar (
	      tomorrow.get(Calendar.YEAR),
	      tomorrow.get(Calendar.MONTH),
	      tomorrow.get(Calendar.DATE),
	      fFOUR_AM,
	      fZERO_MINUTES
	    );
	    return result.getTime();
	}
	
	public static void main(String args[]) {
		AutoGetNewsWeek agn = new AutoGetNewsWeek();
		System.out.println(CDate.getThisday());
	}
	
}
