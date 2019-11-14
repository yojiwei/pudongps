package com.webservise;

import java.util.Calendar;
import java.util.Date;
import java.util.Timer;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import com.util.CDate;

/**
 * 
 *自动调用行政处罚，推送到浦东新区行政处罚系统
 *XzcfGovInfoService.java
 */
public class AutoXzcfGovDataListener implements ServletContextListener {
	//定时20个小时轮一次
//	Timer timer;
//	public AutoXzcfGovDataListener() {
//		timer=new Timer();
//	}
//	public void contextInitialized(ServletContextEvent arg0) {		
//		System.out.println(CDate.getNowTime()+"----------------自动调用 行政处罚推送浦东新区接口 线程启动----------------");
//		XzcfGovInfoService xzcfGovInfoDataTask= new XzcfGovInfoService();
//		//延迟1小时,20小时定时执行一次   task每天早晨一点执行
//		//timer.schedule(xzcfGovInfoDataTask, 60*60*1000,20*60*60*1000);//一秒=1000毫秒 执行任务前的延迟时间，单位是毫秒; 执行各后续任务之间的时间间隔，单位是毫秒。 
//		timer.schedule(xzcfGovInfoDataTask, 1*60*1000,5*60*1000);//一秒=1000毫秒 执行任务前的延迟时间，单位是毫秒; 执行各后续任务之间的时间间隔，单位是毫秒。 
//	}
//	public void contextDestroyed(ServletContextEvent arg0) {
//		System.out.println(CDate.getNowTime()+"----------------自动调用 行政处罚推送浦东新区接口 线程取消----------------");
//		timer.cancel();
//	}
	
	//定时指定时间执行,晚上23:25分
	Timer timer;
	Date time;
	public AutoXzcfGovDataListener() {
		Calendar calendar = Calendar.getInstance();  
		calendar.set(Calendar.HOUR_OF_DAY, 23);  
		calendar.set(Calendar.MINUTE, 25);  
		calendar.set(Calendar.SECOND, 0);  
		time = calendar.getTime();  
		timer = new Timer();  
		
	}
	public void contextInitialized(ServletContextEvent arg0) {		
		System.out.println(CDate.getNowTime()+"----------------自动调用 行政处罚推送浦东新区接口 线程启动----------------");
		XzcfGovInfoService xzcfGovInfoDataTask= new XzcfGovInfoService();
		//延迟1小时,20小时定时执行一次   task每天早晨一点执行
		//timer.schedule(xzcfGovInfoDataTask, 1*60*1000,5*60*1000);//一秒=1000毫秒 执行任务前的延迟时间，单位是毫秒; 执行各后续任务之间的时间间隔，单位是毫秒。
		timer.schedule(xzcfGovInfoDataTask, time);
	}
	public void contextDestroyed(ServletContextEvent arg0) {
		System.out.println(CDate.getNowTime()+"----------------自动调用 行政处罚推送浦东新区接口 线程取消----------------");
		timer.cancel();
	}
	
	
	
}
 
