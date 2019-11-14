package com.util;

import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.Timer;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;


public class AutoGetListener implements ServletContextListener {
	private final static long fONCE_PER_DAY = 1000*60*30;
	private final static int fONE_DAY = 1;
	private final static int fFOUR_AM = 7;
	private final static int fZERO_MINUTES = 0;
	
    public void contextInitialized(ServletContextEvent sce) {
    	Timer timer = new Timer();
		
		FatchMail fetchMail  = new FatchMail();
	    timer.scheduleAtFixedRate(fetchMail,getTomorrowMorning7am(), fONCE_PER_DAY);
	    
    }
	
	private static Date getTomorrowMorning7am(){
	    Calendar tomorrow = new GregorianCalendar();
	    tomorrow.add(Calendar.DATE, fONE_DAY);
	    Calendar result = new GregorianCalendar(
	      tomorrow.get(Calendar.YEAR),
	      tomorrow.get(Calendar.MONTH),
	      tomorrow.get(Calendar.DATE),
	      fFOUR_AM,
	      fZERO_MINUTES
	    );
	    return result.getTime();
	  }
	
	public void contextDestroyed(ServletContextEvent arg0) {
        // TODO Auto-generated method stub
        
    }
}
