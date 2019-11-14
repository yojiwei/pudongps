package com.website;

import java.util.TimerTask;

import com.util.CDate;

public class TaskNews extends TimerTask {
	
	public void run() {
		System.out.println(CDate.getThisday() + "----------------新闻一周排行统计开始-------------------");
		CountForWeek cfw = new CountForWeek();
		cfw.getWeekCount();
		System.out.println("----------------新闻一周排行统计结束-------------------");
		System.out.println("----------------党务公开预示公告开始-------------------");
		String sj_dir = "gbkc";
		int i = -14;
		DangwusGongGao.AutoDisApper(sj_dir,i);
		System.out.println(CDate.getThisday() + "----------------党务公开预示公告结束-------------------");
	}
	
}
