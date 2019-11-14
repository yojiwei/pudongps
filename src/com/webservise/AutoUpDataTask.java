package com.webservise;

import java.util.Calendar;
import java.util.Hashtable;
import java.util.TimerTask;


import com.component.database.CDataCn;
import com.component.database.CDataImpl;
import com.util.CDate;
import com.util.CTools;

public class AutoUpDataTask extends TimerTask{
	
	public AutoUpDataTask() {
	}
	public void run() {
		System.out.println(CDate.getNowTime()+"==============--------"+CDate.getNowTime()+"公文备案推送 进入RUN--------====");
		
		new AutoUpDataTask().TaskOne();
		
		System.out.println(CDate.getNowTime()+"==============--------"+CDate.getNowTime()+"公文备案推送 退出RUN--------====");
	}
	public static void main(String[] args) {
		JavaClientNetService jcnsPut = new JavaClientNetService();
		jcnsPut.putData();
	}
	public void test() {
		new AutoUpDataTask().TaskOne();
	}
	private void TaskOne() {
		Calendar cal = Calendar.getInstance();
		//if (cal.get(Calendar.HOUR_OF_DAY)%2==0) {//每天2小时执行
		System.out.println(CDate.getNowTime()+"==============--------"+CDate.getNowTime()+"自动 - 公文备案推送文件的方法开始--------=============");
		putIndex();
		System.out.println(CDate.getNowTime()+"==============--------"+CDate.getNowTime()+"自动 - 公文备案推送文件的方法结束--------=============");
		//}
	}
	private void putIndex(){
		try{
			JavaClientNetService jcnsPut = new JavaClientNetService();
			jcnsPut.putData();
		} catch (Exception e) {
			System.out.println("AutoUpDataTask.java:"+e.getMessage());
		}
	}
	private String getSubjectId(String code,CDataImpl dImpl){
		String sql="select sj_id from tb_subject where sj_dir='"+code+"'";
		String subjectId="";
		Hashtable table = dImpl.getDataInfo(sql);
		if(table!=null)subjectId = CTools.dealNull(table.get("sj_id")).trim();
		return subjectId;
	}
}