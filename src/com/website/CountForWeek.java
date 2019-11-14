// Decompiled by Jad v1.5.7g. Copyright 2000 Pavel Kouznetsov.
// Jad home page: http://www.geocities.com/SiliconValley/Bridge/8617/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi 
// Source File Name:   CountForWeek.java

package com.website;

import com.component.database.CDataCn;
import com.component.database.CDataImpl;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

public class CountForWeek {

	public CountForWeek() {
	}

	public void addCount(String tb_type, String id, String sj_dir) {
		CDataCn dCn = new CDataCn();
		CDataImpl dImpl = new CDataImpl(dCn);
		ResultSet rs = null;
		String sql = "";
		sql = "select tb_id tb_countNews from tb_countNews where tb_id = " + id
				+ " and tb_type = '" + tb_type + "'";
		rs = dImpl.executeQuery(sql);
		try {
			if (rs.next())
				sql = "update tb_countNews set tb_count = tb_count + 1 where tb_id = "
						+ id + " and tb_type = '" + tb_type + "'";
			else
				sql = "insert into tb_countNews (tb_id,tb_type,tb_url,tb_count) values ("
						+ id + ",'" + tb_type + "','" + sj_dir + "',1)";
			dImpl.executeUpdate(sql);
			rs.close();
		} catch (SQLException e) {
			System.out
					.println("=============CountForWeek.java_addCount FUNCTION IS WRONG: "
							+ e + "===========");
		}
		dImpl.closeStmt();
		dCn.closeCn();
	}

    public void addCount_count(String tb_type, String sj_dir) {
		CDataCn dCn = new CDataCn();
		CDataImpl dImpl = new CDataImpl(dCn);
		ResultSet rs = null;
		String sql = "";
		sql = "select tb_id tb_countNews from tb_countNews where tb_url = '"
				+ sj_dir + "' and tb_type = '" + tb_type + "'";
		rs = dImpl.executeQuery(sql);
		try {
			if (rs.next())
				sql = "update tb_countNews set tb_count = tb_count + 1 where tb_url = '"
						+ sj_dir + "' and tb_type = '" + tb_type + "'";
			else
				sql = "insert into tb_countNews (tb_id,tb_type,tb_url,tb_count) values (1111,'"
						+ tb_type + "','" + sj_dir + "',1)";
			rs.close();
			dImpl.executeUpdate(sql);
		} catch (SQLException e) {
			System.out
					.println("=============CountForWeek.java_addCount FUNCTION IS WRONG: "
							+ e + "===========");
		}
		dImpl.closeStmt();
		dCn.closeCn();
	}

	public void getWeekCount() {
		String toDay = getUpWeekDate();
		CDataCn dCn = new CDataCn();
		CDataImpl dImpl = new CDataImpl(dCn);
		ResultSet rs = null;
		String sql = "";
		String tb_id = "";
		String tb_type = "";
		String tb_url = "";
		String tb_count = "";
		sql = "select * from tb_countforweek where tb_type = 'news' and tb_week = '" + toDay
				+ "' and rownum < 2";
		rs = dImpl.executeQuery(sql);
		try {
			if (rs.next()) {
				System.out.println("===========" + toDay
						+ " THE DATA IS ALREDY IN!===========");
				rs.close();
				return;
			}
			rs.close();
			sql = "select * from (select * from tb_countNews where tb_type = 'news' order by tb_count desc) where rownum <=20";
			Vector vPage = dImpl.splitPage(sql, 1000, 1);
			if (vPage != null) {
				for (int i = 0; i < vPage.size(); i++) {
					Hashtable hash = (Hashtable) vPage.get(i);
					tb_id = hash.get("tb_id").toString();
					tb_type = hash.get("tb_type").toString();
					tb_url = hash.get("tb_url").toString();
					tb_count = hash.get("tb_count").toString();
					sql = "insert into tb_countforweek (tb_id,tb_type,tb_url,tb_count,tb_week,tb_create_time) values ("
							+ tb_id
							+ ",'"
							+ tb_type
							+ "','"
							+ tb_url
							+ "',"
							+ tb_count
							+ ",'"
							+ toDay
							+ "',to_date('"
							+ toDay
							+ "','yyyy-MM-dd'))";
					dImpl.executeUpdate(sql);
				}

			}
			sql = "update tb_countNews set tb_count = 0 where tb_type = 'news'";
			dImpl.executeUpdate(sql);
		} catch (SQLException e) {
			System.out
					.println("===========CountForWeek.java_getWeekCount FUNCTION IS WRONG: "
							+ e + "===========");
		}
		dImpl.closeStmt();
		dCn.closeCn();
		System.out.println("===========" + toDay
				+ " THE DATE INSERT IS SUCCESS!==========");
	}

	public int getDay() {
		Calendar cal = Calendar.getInstance();
		int week = cal.get(7);
		int toDay = week != 1 ? week - 1 : 7;
		return toDay;
	}

	public void chkDay(int i) {
		int toDay = getDay();
		if (toDay == i)
			getWeekCount();
		else
			System.out.println("=========THE DAY IS NOT SAME=========");
	}

	public String getUpWeekDate() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Calendar cal = Calendar.getInstance();
		int diffDay = 0;
		int toDay = getDay();
		if (toDay == 7)
			diffDay = -7;
		else
			diffDay = -toDay;
		cal.add(5, diffDay);
		String upWeek = sdf.format(cal.getTime());
		return upWeek;
	}

	public String delHtml(String str, String beginHtm, int ii) {
		String endHtm = beginHtm.substring(0, 1) + "/"
				+ beginHtm.substring(1, beginHtm.length());
		int firstHtm = beginHtm.length();
		int lastHtm = endHtm.length();
		int startDel = 0;
		int endDel = 0;
		int time = 0;
		int k = 0;
		for (int j = 0; j < str.length(); j++) {
			if (str.length() < j + lastHtm)
				break;
			if (k == 0) {
				if (beginHtm.equals(str.substring(j, j + firstHtm))) {
					time++;
					if (ii == time) {
						k = 1;
						startDel = j;
					}
				}
				continue;
			}
			if (!endHtm.equals(str.substring(j, j + lastHtm)))
				continue;
			if (k != 1)
				break;
			k = 2;
			endDel = j;
		}

		if (endDel == 0) {
			return str;
		} else {
			String reStr = str.substring(0, startDel)
					+ str.substring(endDel + lastHtm, str.length());
			return reStr;
		}
	}

	public String getWeekDate(Date weekDate, int i) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Calendar cal = Calendar.getInstance();
		cal.setTime(weekDate);
		int diffDay = 0;
		if (i == 1)
			diffDay = 7;
		else
			diffDay = -7;
		cal.add(5, diffDay);
		if ("".equals(checkDate(cal.getTime()))) {
			return "";
		} else {
			String weekDay = sdf.format(cal.getTime());
			return weekDay;
		}
	}

	public String checkDate(Date otherDate) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		String selDateStr = sdf.format(otherDate);
		String nowDateStr = sdf.format(new Date());
		int selDateInt = Integer.parseInt(selDateStr);
		//System.out.println("selDateInt: " + selDateInt);
		int nowDateInt = Integer.parseInt(nowDateStr);
		//System.out.println("nowDateInt: " + nowDateInt);
		if (selDateInt >= nowDateInt)
			return "";
		else
			return selDateStr;
	}
	
	/**
	 * 删除例如img的htm
	 * @param htm	htm文件
	 * @param str	要删除的标签
	 * @return
	 */
	public String dealImgHtm(String htm,String str) {
		
		if ("".equals(htm)) return "";
		
		int startNum = 0;
		int endNum = 0;
		int len = str.length();
		String endHtm = "/>"; 
		
		for (int i = 0;i < htm.length();i++) {
			if (htm.substring(i,i + 2).equals(endHtm)) {
				endNum = i + 2;
				break;
			}
			if (htm.substring(i,i + len).equals(str))
				startNum = i - 1;
		}
		
		if (endNum == 0) return htm;
		
		String reHtm = htm.substring(0,startNum) + htm.substring(endNum,htm.length());
		return reHtm;
	}
	
	/**
	 * 删除对称的htm如 <p></p> 
	 * @param htm	htm文件
	 * @param str	要删除的标签
	 * @return
	 */
	public String dealSymHtm(String htm,String str) {
		
		if ("".equals(htm)) return "";
		
		int startNum = 0;
		int endNum = 0;
		int startLen = str.length();
		String endHtm = "</" + str.substring(1,str.length()); 
		int endLen = endHtm.length();

		for (int i = 0;i < htm.length();i++) {
			if (htm.substring(i,i + startLen).equals(str))
				startNum = i;
			if (htm.substring(i,i + endLen).equals(endHtm)) {
				endNum = i + endLen;
				break;
			}
		}
		
		String htmStr = htm.substring(0,startNum) + htm.substring(endNum,htm.length());
				
		if (endNum == 0) return htm;
		
		if ("".equals(htmStr) || "&nbsp;".equals(htmStr))
			return "";
		else 
			return htmStr;
	}

	public static void main(String args1[]) throws ParseException {
		CountForWeek cfw = new CountForWeek();
		cfw.getWeekCount();
	}
}
