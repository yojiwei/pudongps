/*
 * 创建日期 2005-6-15
 *
 * TODO 要更改此生成的文件的模板，请转至
 * 窗口 － 首选项 － Java － 代码样式 － 代码模板
 */
package com.website;

import java.text.DateFormat;
import java.util.Calendar;
import java.util.Timer;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

/**
 * @author Administrator
 *
 * TODO 要更改此生成的类型注释的模板，请转至
 * 窗口 － 首选项 － Java － 代码样式 － 代码模板
 */
public class setUp implements ServletContextListener{
     Timer  timerXml =new Timer();
     Timer  timerHtml =new Timer();
	public void contextInitialized(ServletContextEvent arg0) {
	     System.out.println("定时初始化......");
	   /* 
	    * XML生成配置
	    * 
	    * */ 
	    Calendar cal = Calendar.getInstance();
	    cal.set(Calendar.HOUR_OF_DAY,Integer.parseInt(Messages.getString("SessXml.0")));
	    cal.set(Calendar.MINUTE,Integer.parseInt(Messages.getString("SessXml.1")));
	    cal.set(Calendar.SECOND,Integer.parseInt(Messages.getString("SessXml.2")));
	    /***********************
	    cal.set(Calendar.HOUR_OF_DAY,0);
	    cal.set(Calendar.MINUTE,13);
	    cal.set(Calendar.SECOND,0);
	    **************************/
	    System.out.println("XML第一次启动时间->"+cal.getTime());
	    //Xmllicen xml=new Xmllicen();
	    TestXml xml = new TestXml();
	    timerXml.schedule(xml,cal.getTime(),1000*60*60*24);
	    
	   
	   /*
	    * 自动生成静态页面
	    * 
	    * */
	   /*
	   	Calendar cal2 = Calendar.getInstance();
	   	int inWeek = (Integer.parseInt(Messages.getString("SessHtml.2")))+1;
	   	cal2.set(Calendar.DAY_OF_WEEK,inWeek);
	   	cal2.set(Calendar.HOUR_OF_DAY,Integer.parseInt(Messages.getString("SessHtml.3")));
	   	cal2.set(Calendar.MINUTE,Integer.parseInt(Messages.getString("SessHtml.4")));
	   	
	   	Hmllicen html = new Hmllicen();
	   	timerHtml.schedule(html,cal2.getTime(),60*1000*60*1);
	   	System.out.println("HTML第一次启动时间->"+cal2.getTime()+"=>星期"+inWeek);
	   	*/
	   	/**
	   	 * 完成
	   	 * */
	   	System.out.println("定时启动......");
	   	
	}

	public void contextDestroyed(ServletContextEvent arg0) {
		
		arg0.getServletContext().log("系统关闭成功......");
	     System.out.println("系统关闭成功......");		
		this.timerXml.cancel();
		this.timerHtml.cancel();
	}
	
	public static void main(String args[]) {
		
	}

}
