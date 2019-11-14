package com.website;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Timer;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
/**
 * 浦东门户办事大厅滚动部分部分页面生成静态页面监听器
 * @author yao
 * 20100514
 *
 */
public class CRollListenter implements ServletContextListener {
    private static final int CYCLE = 12* 60* 60 * 1000;
    private CreateRollWorkHall ciwh = null;

    public void contextInitialized(ServletContextEvent sce) {
        try {
        	ServletContext servletContext = sce.getServletContext();
        	ciwh = new CreateRollWorkHall();
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
            timer.schedule(ciwh, startTime, CYCLE);
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


