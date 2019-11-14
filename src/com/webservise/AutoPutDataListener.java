package com.webservise;

import java.util.Timer;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import com.util.CDate;

/**
 * 
 * @author 施建兵
 *自动调用 公文备案推送 的方法
 */
public class AutoPutDataListener implements ServletContextListener {
	Timer timer;
	public AutoPutDataListener() {
		timer=new Timer();
	}
	public void contextInitialized(ServletContextEvent arg0) {		
		System.out.println(CDate.getNowTime()+"----------------自动调用 公文备案推送 的方法 线程启动----------------");
		AutoUpDataTask autoUpDataTask= new AutoUpDataTask();
		//延迟5分钟,2分钟定时执行   task每天早晨一点执行
		timer.schedule(autoUpDataTask, 2*60*1000,5*60*1000);//一秒=1000毫秒 执行任务前的延迟时间，单位是毫秒; 执行各后续任务之间的时间间隔，单位是毫秒。 
		//schedule(TimerTask task, long delay, long period)的注释：大意是在延时delay毫秒后重复的执行task，周期是period毫秒。
	
	}
	public void contextDestroyed(ServletContextEvent arg0) {
		System.out.println(CDate.getNowTime()+"-----自动调用 公文备案推送 的方法 线程取消-----");
		timer.cancel();
	}
	
}
 
