package com.webservise;

import java.util.Calendar;
import java.util.TimerTask;


import com.util.CDate;
/**
 * 自动调用 浦东门户网站依申请公开接口抓取到公文备案并反馈信息到门户网站
 * @author Administrator
 *
 */
public class AutoGetInfoOpenDataTask extends TimerTask{
	/**
	 * 构造函数
	 */
	public AutoGetInfoOpenDataTask() {}
	/**
	 * run方法
	 */
	public void run() {
		new AutoGetInfoOpenDataTask().TaskOne();
	}
	/**
	 * 执行方法
	 */
	private void TaskOne() {
		Calendar cal = Calendar.getInstance();
		//if (cal.get(Calendar.HOUR_OF_DAY)%2==0) {//每天2小时执行
		System.out.println(CDate.getNowTime()+"==============--------"+CDate.getNowTime()+"自动 - 抓取门户网站依申请公开数据--------=============");
		new InfoOpenJavaClientNetService().getInfoOpenData();//调用 信息公开网上申请 调用方法
		System.out.println(CDate.getNowTime()+"==============--------"+CDate.getNowTime()+"自动 - 推送公文备案依申请处理结果信息到门户网站--------=============");
		new InfoOpenJavaClientNetService().putInfoMessage();//调用 信息公开网上申请 信息反馈 调用方法
			
		//}
	}
	
	/**
	 * main方法
	 * @param args
	 */
	public static void main(String[] args) {
		AutoGetInfoOpenDataTask jcnsPut = new AutoGetInfoOpenDataTask();
		jcnsPut.TaskOne();
	}
}