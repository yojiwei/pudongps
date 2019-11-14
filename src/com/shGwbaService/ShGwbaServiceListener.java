package com.shGwbaService;

import java.util.Timer;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import com.util.CDate;
/**
 * 定时推送公文备案信息到市公文备案系统
 * 定时（一小时执行一次）
 * @author yojiwei
 *
 */
public class ShGwbaServiceListener implements ServletContextListener{
	
	Timer timer;
	public ShGwbaServiceListener() {
		timer=new Timer();
	}
	public void contextInitialized(ServletContextEvent arg0) {		
		System.out.println(CDate.getNowTime()+"==============--------"+CDate.getNowTime()+"自动推送公文备案信息到市公文备案系统开始2019--------====");
		ShGwbaService autoUpDataTask= new ShGwbaService();
		//延迟10分钟,120分钟定时执行   task每天早晨一点执行 2*60*1000,120*60*100
		timer.schedule(autoUpDataTask, 5*60*1000,20*60*1000);//一秒=1000毫秒 执行任务前的延迟时间，单位是毫秒; 执行各后续任务之间的时间间隔，单位是毫秒。 
		
	
	}
	public void contextDestroyed(ServletContextEvent arg0) {
		System.out.println(CDate.getNowTime()+"==============--------"+CDate.getNowTime()+"自动推送公文备案信息到市公文备案系统取消2019--------====");
		timer.cancel();
	}

	}