package com.webservise;

import java.util.Calendar;
import java.util.Date;
import java.util.Timer;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import com.util.CDate;

/**
 * 
 *自动调用 controlworkfeedback抓取从市民中心数据库中的办事反馈数据（工商局、食药监局）
 *
 */
public class ControlWorkListener implements ServletContextListener {
	Timer timer;
	public ControlWorkListener() {
		timer=new Timer();
	}
	public void contextInitialized(ServletContextEvent arg0) {		
		System.out.println(CDate.getNowTime()+"----------------自动调用 controlworkfeedback抓取从市民中心数据库中的办事反馈数据（工商局、食药监局） 线程启动----------------");
		ControlWorkFeedBack cwfbDataTask= new ControlWorkFeedBack();
		//每天23:25分执行
		Calendar calendar = Calendar.getInstance();
		calendar.set(Calendar.HOUR_OF_DAY, 23);
		calendar.set(Calendar.MINUTE, 23);
		calendar.set(Calendar.SECOND, 0);
		Date time = calendar.getTime();
		System.out.println("time==========="+time);
		timer = new Timer();
		timer.schedule(cwfbDataTask, time);
	}
	public void contextDestroyed(ServletContextEvent arg0) {
		System.out.println(CDate.getNowTime()+"----------------自动调用 controlworkfeedback抓取从市民中心数据库中的办事反馈数据（工商局、食药监局） 线程取消----------------");
		timer.cancel();
	}
	
}
 
