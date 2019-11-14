package com.website;

import java.io.PrintStream;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Timer;
import javax.servlet.*;

//import com.beyondbit.sms.reply.SMSReplyPoller;

public class CreateHTML implements ServletContextListener{
	 private static final int CYCLE = 20 * 60 * 1000; //一个小时
	
    Timer timerHtml;

    public CreateHTML()
    {
        timerHtml = new Timer();
    }

    public void contextInitialized(ServletContextEvent sce)
    {

    	try{
	    	ServletContext servletContext = sce.getServletContext();
	    	HTMLClient client = new HTMLClient();
	
	        //起始时间配置
	        SimpleDateFormat sdf = sdf = new SimpleDateFormat(
	            "yyyy-MM-dd HH:mm");
	        Date startTime = sdf.parse(servletContext.getInitParameter("start-time")); //从配置文件（web.xml）获取起始时间
	        if(startTime.compareTo(Calendar.getInstance().getTime()) <= 0){
	            startTime = Calendar.getInstance().getTime();
	        }
	
	        //定时器
	        Timer timer = new Timer();
	        timer.scheduleAtFixedRate(client, startTime, CYCLE); //调用smsReplyPoller，运行监听程序
    	}
    	catch(Exception e){
    		e.printStackTrace();
    	}
    }

    public void contextDestroyed(ServletContextEvent arg0)
    {
        arg0.getServletContext().log("\u7CFB\u7EDF\u5173\u95ED\u6210\u529F......");
        System.out.println("\u7CFB\u7EDF\u5173\u95ED\u6210\u529F......");
       
        timerHtml.cancel();
    }
}
