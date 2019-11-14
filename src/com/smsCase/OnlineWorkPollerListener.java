package com.smsCase;

import com.beyondbit.soft2.onlinework.OnlineWorkPoller;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Timer;
import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import org.apache.log4j.Logger;

public class OnlineWorkPollerListener
  implements ServletContextListener
{
  private static final int CYCLE = 15000;
  private Logger logger;
  private OnlineWorkPoller onlineWorkPoller = null;
  private DxpdQ dxpdq = null;

  public OnlineWorkPollerListener() {
    this.logger = Logger.getLogger(OnlineWorkPollerListener.class);
  }

  public static void main(String[] args) {
    OnlineWorkPollerListener onlineWorkPollerListener1 = new OnlineWorkPollerListener();
  }

  public void contextInitialized(ServletContextEvent sce)
  {
    try {
      ServletContext servletContext = sce.getServletContext();
      this.logger = Logger.getLogger(OnlineWorkPollerListener.class);
      this.logger.info(
        "start initializing dxpdxiaowei!");

      this.onlineWorkPoller = new OnlineWorkPoller();
      this.dxpdq = new DxpdQ();

      SimpleDateFormat sdf = new SimpleDateFormat(
        "yyyy-MM-dd HH:mm");
      Date startTime = sdf.parse(servletContext.getInitParameter(
        "start-time"));
      if (startTime.compareTo(Calendar.getInstance().getTime()) <= 0) {
        startTime = Calendar.getInstance().getTime();
      }

      Timer timer = new Timer();

      timer.schedule(this.dxpdq, startTime, 15000L);
      this.logger.info("finish initializing dxpdxiaowei!");
    }
    catch (Exception ex) {
      this.logger.error("", ex);
      throw new IllegalStateException();
    }
  }

  public void contextDestroyed(ServletContextEvent sce)
  {
  }
}