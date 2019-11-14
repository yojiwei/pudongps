package com.util;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Timer;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

/**
 * <p>Program Name:浦东统一信息报送</p>
 * <p>Module Name:信息抓取</p>
 * <p>Function:抓区外高桥报送的信息</p>
 * <p>Create Time: 2006-8-23 10:53:00</p>
 * @author: Administrator
 * @version: 
 */
public class WGQMsgReceiveListener implements ServletContextListener {
    private static final int CYCLE = 5 * 60 * 60 * 1000;
    private WGQMessageReceive wgqreceive  = null;

    public void contextInitialized(ServletContextEvent sce) {
        try {
        	wgqreceive  = new WGQMessageReceive("waigaoqiao");
            //起始时间配置 
            SimpleDateFormat sdf = sdf = new SimpleDateFormat(
                "yyyy-MM-dd HH:mm");
            Date startTime = sdf.parse("2009-04-10 07:00");
            if(startTime.compareTo(Calendar.getInstance().getTime()) <= 0){
                startTime = Calendar.getInstance().getTime();
            }

            //定时器  
            Timer timer = new Timer();
            timer.schedule(wgqreceive, startTime, CYCLE);
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

