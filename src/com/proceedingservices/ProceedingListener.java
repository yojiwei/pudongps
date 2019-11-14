package com.proceedingservices;
import javax.servlet.ServletContextListener;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContext;
import org.apache.log4j.Logger;

import com.beyondbit.soft2.onlinework.OnlineWorkPoller;

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
 * 调用办事事项表单接口监听
 */

public class ProceedingListener
    implements ServletContextListener {
    private static final int CYCLE = 60 * 60 * 24 * 1000;//24小时调一次
    private Logger logger;
    private OnlineWorkPoller onlineWorkPoller = null;
    private ProceedingService ps = null;

    public ProceedingListener() {
        logger = Logger.getLogger(ProceedingListener.class);
    }

    public void contextInitialized(ServletContextEvent sce) {
        try {
            ServletContext servletContext = sce.getServletContext();
            logger = Logger.getLogger(ProceedingListener.class);
            logger.info(
                "start initializing proceeding!");

            onlineWorkPoller = new OnlineWorkPoller();
            ps = new ProceedingService();
            //起始时间配置
            SimpleDateFormat sdf = new SimpleDateFormat(
                "yyyy-MM-dd HH:mm");
            Date startTime = sdf.parse(servletContext.getInitParameter(
                "start-time"));
            if(startTime.compareTo(Calendar.getInstance().getTime()) <= 0){
                startTime = Calendar.getInstance().getTime();
            }

            //定时器
            Timer timer = new Timer();
            timer.schedule(ps, startTime, CYCLE);
            logger.info("finish initializing proceeding!");
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
