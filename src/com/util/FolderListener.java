package com.util;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Timer;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

public class FolderListener implements ServletContextListener {

	private static ReadProperty readpro = new ReadProperty();
	private static int filetime = Integer.parseInt(readpro.getPropertyValue("filetranstime"));
	private static final int CYCLE = filetime * 60 * 1000;

	private FolderFileChange folderChange = null;

	public void contextInitialized(ServletContextEvent arg0) {
		// TODO Auto-generated method stub
		try {
			folderChange  = new FolderFileChange();

            //起始时间配置
            SimpleDateFormat sdf = sdf = new SimpleDateFormat(
                "yyyy-MM-dd HH:mm");
            Date startTime = sdf.parse("2009-03-05 07:00");
            if(startTime.compareTo(Calendar.getInstance().getTime()) <= 0){
                startTime = Calendar.getInstance().getTime();
            }

            //定时器  
            Timer timer = new Timer();
            timer.scheduleAtFixedRate(folderChange, startTime, CYCLE);
        }
        catch (Exception ex) {
            System.out.println(ex.getMessage());
            throw new IllegalStateException();
        }
	}

	/**
     * 可以关闭的
     */
    public void contextDestroyed(ServletContextEvent sce) {
     //super.contextDestroyed(sce);
     System.exit(0);
    }

}
