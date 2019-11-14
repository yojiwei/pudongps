package com.util;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Timer;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

/**
 * <p>Program Name:工程名</p>
 * <p>Module Name:模块名</p>
 * <p>Function:功能描述</p>
 * <p>Create Time: 2006-8-23 10:53:00</p>
 * @author: Administrator
 * @version: 
 */
public class SHFGReceiveListener implements ServletContextListener {
    private static final int CYCLE = 24 * 60 * 60 * 1000;
    private SHFGReceive receive  = null;

    public void contextInitialized(ServletContextEvent sce) {
        try {
            receive  = new SHFGReceive();

            //起始时间配置
            SimpleDateFormat sdf = sdf = new SimpleDateFormat(
                "yyyy-MM-dd HH:mm");
            Date startTime = sdf.parse("2006-11-05 03:00");
            if(startTime.compareTo(Calendar.getInstance().getTime()) <= 0){
                startTime = Calendar.getInstance().getTime();
            }

            //定时器  
            Timer timer = new Timer();
            timer.scheduleAtFixedRate(receive, startTime, CYCLE);
        }
        catch (Exception ex) {
            System.out.println(ex.getMessage());
            throw new IllegalStateException();
        }
    }

    public void contextDestroyed(ServletContextEvent sce) {
        return;
    }

}

