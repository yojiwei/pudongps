package com.webservise;

import java.util.Timer;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import com.util.CDate;

/**
 * 
 *自动调用 行政处罚推送门户网站接口
 *XzcfService.java
 */
public class AutoXzcfDataListener implements ServletContextListener {
	Timer timer;
	public AutoXzcfDataListener() {
		timer=new Timer();
	}
	public void contextInitialized(ServletContextEvent arg0) {		
		System.out.println(CDate.getNowTime()+"----------------自动调用 行政处罚推送门户网站接口 线程启动----------------");
		XzcfService xzcfDataTask= new XzcfService();
		//延迟2分钟,60分钟定时执行   task每天早晨一点执行
		timer.schedule(xzcfDataTask, 1*60*1000,4*60*1000);//一秒=1000毫秒 执行任务前的延迟时间，单位是毫秒; 执行各后续任务之间的时间间隔，单位是毫秒。 
		//schedule(TimerTask task, long delay, long period)的注释：大意是在延时delay毫秒后重复的执行task，周期是period毫秒。
	}
	public void contextDestroyed(ServletContextEvent arg0) {
		System.out.println(CDate.getNowTime()+"----------------自动调用 行政处罚推送门户网站接口 线程取消----------------");
		timer.cancel();
	}
	
}
 
