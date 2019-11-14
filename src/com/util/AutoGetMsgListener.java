package com.util;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Timer;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import org.apache.log4j.Logger;


/**
 * <p>Program Name:工程名</p>
 * <p>Module Name:模块名</p>
 * <p>Function:功能描述</p>
 * <p>Create Time: 2006-8-23 10:53:00</p>
 * @author: Administrator
 * @version: 
 */
public class AutoGetMsgListener implements ServletContextListener {
    private static final int CYCLE = 24 * 60 * 60 * 1000;//60 * 60 * 1000;
    private Logger logger;
    private AutoGetMsg autoGetMsg = null;

    public AutoGetMsgListener() {
        logger = Logger.getLogger(AutoGetMsgListener.class);
    }

    public void contextInitialized(ServletContextEvent sce) {
        try {
            ServletContext servletContext = sce.getServletContext();
            logger = Logger.getLogger(AutoGetMsgListener.class);
            logger.info(
                "start initializing AutoGetMsgListener!");

            autoGetMsg = new AutoGetMsg();

            //起始时间配置
            SimpleDateFormat sdf = sdf = new SimpleDateFormat(
                "yyyy-MM-dd HH:mm");
            Date startTime = sdf.parse("2006-11-09 04:00");
            if(startTime.compareTo(Calendar.getInstance().getTime()) <= 0){
                startTime = Calendar.getInstance().getTime();
            }

            //定时器  
            Timer timer = new Timer();
            timer.scheduleAtFixedRate(autoGetMsg, startTime, CYCLE);
            logger.info("finish initializing AutoGetMsgListener!");
        }
        catch (Exception ex) {
            logger.error("", ex);
            throw new IllegalStateException();
        }
    }

    public void contextDestroyed(ServletContextEvent sce) {
        return;
    }

}

