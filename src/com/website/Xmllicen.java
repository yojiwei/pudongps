/*
 * 创建日期 2005-8-1
 *
 * TODO 要更改此生成的文件的模板，请转至
 * 窗口 － 首选项 － Java － 代码样式 － 代码模板
 */
package com.website;

import java.util.TimerTask;

import com.util.CDate;


/**
 * @author Administrator
 *
 * TODO 要更改此生成的类型注释的模板，请转至
 * 窗口 － 首选项 － Java － 代码样式 － 代码模板
 */
public class Xmllicen extends TimerTask {
     public void run() {
          	this.stratXml();
     }

     public void stratXml(){
		System.out.println(CDate.getNowTime()+"---------------自动生成XML-------------------");
		System.out.println(CDate.getNowTime()+"============================================");
		/*****************
		if (CDate.getThisday().equals("2006-12-13")) {
			System.out.println(CDate.getNowTime()+">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>成功生成！");
		}
		else if (CDate.getThisday().equals("2006-12-14")) {
			System.out.println(CDate.getNowTime()+">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>2002");
			SessionXmlwsbs.VectorXML(CDate.getThisday(),"","2002-12-31","2006-12-13","2006-12-12");
		}
		else if (CDate.getThisday().equals("2006-12-15")) {
			System.out.println(CDate.getNowTime()+">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>2003");
			SessionXml01.VectorXML(CDate.getThisday(),"2003-01-01","2003-12-31","2006-12-14");
		}
		else if (CDate.getThisday().equals("2006-12-16")) {
			System.out.println(CDate.getNowTime()+">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>2004");
			SessionXml01.VectorXML(CDate.getThisday(),"2004-01-01","2004-12-31","2006-12-15");
		}
		else if (CDate.getThisday().equals("2006-12-17")) {
			System.out.println(CDate.getNowTime()+">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>2005");
			SessionXml01.VectorXML(CDate.getThisday(),"2005-01-01","2005-12-31","2006-12-16");
		}
		************************/
		if (CDate.getThisday().equals("2006-12-15")) {
			System.out.println(CDate.getNowTime()+">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>2006-12-15");
			SessionXmlwsbs.VectorXML(CDate.getThisday(),"2006-12-12","2006-12-14","","");
		}
     	else {
     		SessionXml.VectorXML(CDate.getThisday());
     	}
		System.out.println(CDate.getNowTime()+"-------------自动生成XML结束------------------");

  		System.out.println(CDate.getNowTime() + "----------------新闻一周排行统计开始-------------------");
  		CountForWeek cfw = new CountForWeek();
  		cfw.getWeekCount();
  		System.out.println(CDate.getNowTime() + "----------------新闻一周排行统计结束-------------------");
  		System.out.println(CDate.getNowTime() + "----------------党务公开预示公告开始-------------------");
  		String sj_dir = "gbkc";
  		int i = -14;
  		DangwusGongGao.AutoDisApper(sj_dir,i);
  		System.out.println(CDate.getNowTime() + "----------------党务公开预示公告结束-------------------");
     }
     
}
