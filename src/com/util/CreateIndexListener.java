package com.util;

import java.util.Calendar;
import java.util.Date;
import java.util.Timer;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import org.apache.log4j.Logger;

public class CreateIndexListener implements ServletContextListener {
    private Logger logger;
    public CreateIndexListener() {
        logger = Logger.getLogger(CreateIndexListener.class);
    }

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		CreateIndexListener agn = new CreateIndexListener();

	}

	public void contextInitialized(ServletContextEvent arg0) {
		// TODO Auto-generated method stub
	     try {
	            logger.info("开始初始化首页静态页面生成监听器!");
	            CreateIndex  cdbc= new CreateIndex(arg0);    
	            Date startTime =  Calendar.getInstance().getTime(); 
	            //定时器
	            Timer timer = new Timer(false);
	            timer.scheduleAtFixedRate(cdbc,startTime, cdbc.CYCLETIME); //运行监听程序
	            logger.info("首页静态页面生成监听器初始化完成!");
	        }
	        catch (Exception ex) {
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
