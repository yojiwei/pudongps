package com.beyondbit.soft2.onlinework;

import javax.servlet.ServletContextListener;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContext;
import org.apache.log4j.Logger;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Timer;
import java.util.Calendar;

/**
 * <p>Title: oa</p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2002</p>
 * <p>Company: popteach</p>
 * @author not attributable
 * @version 1.0
 */

public class OnlineWorkPollerListener
    implements ServletContextListener {
    private static final int CYCLE = 60 * 60 * 1000;
    private Logger logger;
    private OnlineWorkPoller onlineWorkPoller = null;

    public OnlineWorkPollerListener() {
        logger = Logger.getLogger(OnlineWorkPollerListener.class);
    }

    public static void main(String[] args) {
        OnlineWorkPollerListener onlineWorkPollerListener1 = new
            OnlineWorkPollerListener();
    }

    public void contextInitialized(ServletContextEvent sce) {
        try {
            ServletContext servletContext = sce.getServletContext();
            logger = Logger.getLogger(OnlineWorkPollerListener.class);
            logger.info(
                "start initializing OnlineWorkPollerListener!");

            onlineWorkPoller = new OnlineWorkPoller();

            //起始时间配置
            SimpleDateFormat sdf = sdf = new SimpleDateFormat(
                "yyyy-MM-dd HH:mm");
            Date startTime = sdf.parse(servletContext.getInitParameter(
                "start-time"));
            if(startTime.compareTo(Calendar.getInstance().getTime()) <= 0){
                startTime = Calendar.getInstance().getTime();
            }

            //定时器
            Timer timer = new Timer();
            timer.scheduleAtFixedRate(onlineWorkPoller, startTime, CYCLE);
            logger.info("finish initializing OnlineWorkPollerListener!");
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
