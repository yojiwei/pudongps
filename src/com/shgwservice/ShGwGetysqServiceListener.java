package com.shgwservice;

import java.util.Timer;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import com.util.CDate;
/**
 * 定时抓取市依申请公开数据到浦东公文备案系统
 * http://10.81.96.38:8080/services/ApplyOpenExportService
 * 定时（一小时执行一次）
 * @author yojiwei
 *
 */
public class ShGwGetysqServiceListener implements ServletContextListener{
	
	Timer timer;
	public ShGwGetysqServiceListener() {
		timer=new Timer();
	}
	public void contextInitialized(ServletContextEvent arg0) {		
		System.out.println(CDate.getNowTime()+"==============--------"+CDate.getNowTime()+"自动抓取市依申请公开数据开始--------====");
		ShGwGetysqService autoUpDataTask= new ShGwGetysqService();
		//延迟2分钟,120分钟定时执行   task每天早晨一点执行 2*60*1000,120*60*100
		timer.schedule(autoUpDataTask, 2*60*1000,60*60*1000);//一秒=1000毫秒 执行任务前的延迟时间，单位是毫秒; 执行各后续任务之间的时间间隔，单位是毫秒。 
		
	
	}
	public void contextDestroyed(ServletContextEvent arg0) {
		System.out.println(CDate.getNowTime()+"==============--------"+CDate.getNowTime()+"自动抓取市依申请公开数据取消--------====");
		timer.cancel();
	}

	}