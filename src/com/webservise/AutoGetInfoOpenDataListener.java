package com.webservise;

import java.util.Timer;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import com.util.CDate;

/**
 * @author Administrator
 *自动调用 浦东门户网站依申请公开接口抓取到公文备案并反馈信息到门户网站
 */
public class AutoGetInfoOpenDataListener implements ServletContextListener {
	Timer timer;
	public AutoGetInfoOpenDataListener() {
		timer=new Timer();
	}
	public void contextInitialized(ServletContextEvent arg0) {		
		System.out.println(CDate.getNowTime()+"==============--------"+CDate.getNowTime()+"自动同步依申请公开数据任务开始--------====");
		AutoGetInfoOpenDataTask autoUpDataTask= new AutoGetInfoOpenDataTask();
		//延迟2分钟,120分钟定时执行   task每天早晨一点执行 2*60*1000,120*60*100
		timer.schedule(autoUpDataTask, 2*60*1000,5*60*1000);//一秒=1000毫秒 执行任务前的延迟时间，单位是毫秒; 执行各后续任务之间的时间间隔，单位是毫秒。 
		
	
	}
	public void contextDestroyed(ServletContextEvent arg0) {
		System.out.println(CDate.getNowTime()+"==============--------"+CDate.getNowTime()+"自动同步依申请公开数据任务取消--------====");
		timer.cancel();
	}
	
}
 
