package com.util;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.Iterator;
import java.util.Locale;
import java.util.Map;
import java.util.Vector;

import com.component.database.CDataCn;
import com.component.database.CDataImpl;

/**
 * @author Administrator
 *
 */
public class TimeCalendar {
	private String isholiday = "";
	CDataCn dCn=null;   //新建数据库连接对象
	CDataImpl dImpl=null;  //新建数据接口对象
	private String sqlStr = "";
	private static Calendar cal = null;
	private static SimpleDateFormat   def   =   null;
	private boolean isholi =false;
	private String endtime = "";
	private int days = 0;
	private int yesdays = 0;
	private int i=0;
	
	public TimeCalendar(){
		cal = Calendar.getInstance();
		def = new SimpleDateFormat("yyyy-MM-dd");
	}
	
	/**
	 * 计算是否为节假日
	 * @param daytime
	 * @return
	 */
	public boolean isHoliday(String daytime){
		try{
			dCn = new CDataCn();
			dImpl = new CDataImpl(dCn);
			
			sqlStr = "select hd_flag from tb_holiday where hd_date = to_date('"+daytime+"','yyyy-mm-dd hh:mi:ss')";
			Hashtable holiday_con = dImpl.getDataInfo(sqlStr);
			if (holiday_con != null)
			{
				isholiday = CTools.dealNull(holiday_con.get("hd_flag"));
				if ("1".equals(isholiday)) { //设置为节假日
					isholi = true; //当天为节假日，日期增加一天
				}
			}
		}catch(Exception ex){
			ex.printStackTrace();
		}finally{
			if(dImpl!=null){
				dImpl.closeStmt();
			}if(dCn!=null){
				dCn.closeCn();
			}
		}
		return  isholi;
	}
	/**
	 * 选择补正时间挂起
	 * 材料补正得到限制时间||第三方意见征询 15天为办理时限
	 * @param applytime 申请的时间
	 * @param id  申请的ID
	 * @param status 3材料补正7第三方意见征询
	 * @return
	 */
	public String getLimittime(String applytime,String id,String status){
		String limittime = "";
		String couniw = "0";
		SimpleDateFormat ft = new SimpleDateFormat("yyyy-MM-dd");
		try{
			dCn = new CDataCn();
			dImpl = new CDataImpl(dCn);
			
			cal.get(Calendar.DATE);
			//sqlStr = "select max(to_char(endtime,'yyyy-MM-dd')) as endtime from taskcenter where status = "+status+" and iid ="+id+" order by id desc";
			sqlStr = "select max(to_char(inserttime,'yyyy-MM-dd')) as endtime from infoopen_word where  ip_id ="+id+"";
			Hashtable holiday_con = dImpl.getDataInfo(sqlStr);
			if(holiday_con!=null){
				endtime = CTools.dealNull(holiday_con.get("endtime"));
			}
			//判断该申请中间是否有延期答复19情况，多次延期15*couniw
			sqlStr = "select count(iw_id) as couniw from infoopen_word where applyflag = 19 and ip_id ="+id+" order by iw_id desc";
			Hashtable yqdf_con = dImpl.getDataInfo(sqlStr);
			if(yqdf_con!=null){
				couniw = CTools.dealNull(yqdf_con.get("couniw"));
			}
			//endtime==2017-06-01--couniw=1----applytime=2017-05-12
			//System.out.println("endtime=="+endtime+"--couniw="+couniw+"----applytime="+applytime);
			applytime = ft.format(ft.parse(applytime));
			days = this.getdays(applytime, endtime)-this.getWeekDays(applytime, endtime);//实际用过的天数
		 	limittime = this.getMapHolidays(def.format(new Date()), 15*(Integer.parseInt(couniw)+1)-days);//新算的办理期限
		 	
		}catch(Exception ex){
			ex.printStackTrace();
		}finally{
			if(dImpl!=null){
				dImpl.closeStmt();
			}if(dCn!=null){
				dCn.closeCn();
			}
		}
		return limittime;
	}
	/**
	 * 相差的天数
	 * @param starttime 申请的时间
	 * @param endtime 挂起的时间
	 * @return
	 */
	public int getdays(String starttime,String endtime){
		long days = 0;
		int adays = 0;
		SimpleDateFormat ft = new SimpleDateFormat("yyyy-MM-dd");
		  try {
		   Date startdate = ft.parse(starttime);
		   Date enddate = ft.parse(endtime);
		   days = enddate.getTime() - startdate.getTime();
		   days = days / 1000 / 60 / 60 / 24;
		  } catch (Exception e) {
			  e.printStackTrace();
		  }
		  adays = (int)days;
		return adays;
	}
	
	/**
	 * 取得limittime时间
	 * @param starttime 当前时间
	 * @param count 还有几天期限
	 * @return
	 */
	public String getMapHolidays(String starttime,int count){
		String overTime = "";
		//String sqlTime = "select rum,hd_date from (select rownum rum,g.hd_id,g.hd_date,g.hd_flag,g.hd_remark from tb_holiday g where hd_date > to_date('"+starttime+"','yyyy-MM-dd') and g.hd_flag=0 order by g.hd_date) where rum ="+count+"";
		String sqlTime = "select rr,dd from (select rownum as rr,hd_date dd from (select g.hd_id hd_id,g.hd_date hd_date,g.hd_flag hd_flag,g.hd_remark hd_remark from tb_holiday g where hd_date > to_date('"+starttime+"','yyyy-MM-dd') and g.hd_flag=0 order by hd_date)) d where  d.rr = "+count+"";
		try{
			dCn = new CDataCn();
			dImpl = new CDataImpl(dCn);
			Hashtable ho_con = dImpl.getDataInfo(sqlTime);
			if (ho_con != null)
			{
				overTime = CTools.dealNumber(ho_con.get("dd"));
			}
		}catch(Exception ex){
			ex.printStackTrace();
		}finally{
			if(dImpl!=null){
				dImpl.closeStmt();
			}if(dCn!=null){
				dCn.closeCn();
			}
		}
		return overTime;
	}
	/**
	 * 得到时间段内的双休日数
	 * @param stratTime 申请的时间
	 * @param endTime 挂起的时间
	 * @return
	 */
	public int getWeekDays(String stratTime,String endTime){
		try{
			dCn = new CDataCn();
			dImpl = new CDataImpl(dCn);
			sqlStr = "select count(hd_id) cou from tb_holiday where hd_date <to_date('"+endTime+"','yyyy-MM-dd') and hd_date > to_date('"+stratTime+"','yyyy-MM-dd') and hd_flag=1";
			Hashtable holiday_con = dImpl.getDataInfo(sqlStr);
			if (holiday_con != null)
			{
				isholiday = CTools.dealNumber(holiday_con.get("cou"));
				yesdays = Integer.parseInt(isholiday);
			}
		}catch(Exception ex){
			ex.printStackTrace();
		}finally{
			if(dImpl!=null){
				dImpl.closeStmt();
			}if(dCn!=null){
				dCn.closeCn();
			}
		}
		return yesdays;
	}
	
	/**
	 * 把双休日设置到表里
	 * @param stratTime
	 * @param endTime
	 */
	public void setWeekDays(String stratTime,String endTime){
		try{
			dCn = new CDataCn();
			dImpl = new CDataImpl(dCn);
			DateFormat df = DateFormat.getDateInstance();
			Calendar beginDate = Calendar.getInstance();
			Calendar endDate = Calendar.getInstance();
			beginDate.setTime(df.parse(stratTime));
			endDate.setTime(df.parse(endTime));
			
			for(;(beginDate.getTime()).compareTo(endDate.getTime())<=0;beginDate.add(Calendar.DATE,1))
			{
				++i;
			    CFormatDate cFDate = new CFormatDate(beginDate.getTime().toLocaleString());
			    cal.setTime(beginDate.getTime());
			    if ((cal.get(Calendar.DAY_OF_WEEK)-1) == 6 || (cal.get(Calendar.DAY_OF_WEEK)-1) == 0) //星期六或星期日
				{
				    String strSql = "select * from TB_HOLIDAY where HD_DATE = to_date('"+cFDate.getFullDate()+"','YYYY-MM-DD')";
				    Hashtable content = dImpl.getDataInfo(strSql);
				    if(content!=null)
				    {
						dImpl.edit("TB_HOLIDAY","HD_ID",content.get("hd_id").toString());
						dImpl.setValue("HD_FLAG","1",CDataImpl.INT);
						dImpl.setValue("HD_REMARK","双休日",CDataImpl.STRING);
						dImpl.update();
				    }
				    else
				    {
						dImpl.addNew("TB_HOLIDAY","HD_ID",CDataImpl.PRIMARY_KEY_IS_VARCHAR);
						dImpl.setValue("HD_DATE",cFDate.getFullDate(),CDataImpl.DATE);
						dImpl.setValue("HD_FLAG","1",CDataImpl.INT);
						dImpl.setValue("HD_REMARK","双休日",CDataImpl.STRING);
						dImpl.update();
				    }
				}else{
					dImpl.addNew("TB_HOLIDAY","HD_ID",CDataImpl.PRIMARY_KEY_IS_VARCHAR);
					dImpl.setValue("HD_DATE",cFDate.getFullDate(),CDataImpl.DATE);
					dImpl.setValue("HD_FLAG","0",CDataImpl.INT);
					dImpl.setValue("HD_REMARK","工作日",CDataImpl.STRING);
					dImpl.update(); 
				}
			    if(i%200==0){
			    	dCn = new CDataCn();
					dImpl = new CDataImpl(dCn);
			    }
			    
			}
		}catch(Exception ex){
			ex.printStackTrace();
		}finally{
			if(dImpl!=null){
				dImpl.closeStmt();
			}if(dCn!=null){
				dCn.closeCn();
			}
		}
	}
	/**
	 * 计算系统时间与到期时间间的时间间隔数（天）
	 * @param sysdate 系统时间（yyyy-MM-dd）
	 * @param limittime 到期时间（yyyy-MM-dd）
	 * @return int timeDecrease 未超期返回正数，超期返回负数
	 */
	public int getTimeDecrease(String sysdate,String limittime){
		int timeDecrease = 0;
		boolean isDelay = false;
		String sql = "";
		Hashtable table = null;
		
		//取得传入的系统时间转成时间格式
		Calendar start = Calendar.getInstance();
		start.set(Calendar.YEAR,Integer.parseInt(sysdate.substring(0,4)));
		start.set(Calendar.MONTH,(Integer.parseInt(sysdate.substring(5,7))-1));
		start.set(Calendar.DAY_OF_MONTH,Integer.parseInt(sysdate.substring(8,10)));
		
		//取得传入的到期时间转成时间格式
		Calendar end = Calendar.getInstance();
		end.set(Calendar.YEAR,Integer.parseInt(limittime.substring(0,4)));
		end.set(Calendar.MONTH,(Integer.parseInt(limittime.substring(5,7))-1));
		end.set(Calendar.DAY_OF_MONTH,Integer.parseInt(limittime.substring(8,10)));
		
		if(start.before(end)){
			sql = "select count(hd_id) cou from tb_holiday where hd_date <=to_date('"+limittime+"','yyyy-MM-dd') and hd_date > to_date('"+sysdate+"','yyyy-MM-dd') and hd_flag=0";
		}else{
			isDelay = true;
			sql = "select count(hd_id) cou from tb_holiday where hd_date <=to_date('"+sysdate+"','yyyy-MM-dd') and hd_date > to_date('"+limittime+"','yyyy-MM-dd') and hd_flag=0";
		}
		try{
			dCn = new CDataCn();
			dImpl = new CDataImpl(dCn);
			table = dImpl.getDataInfo(sql);
			if(table != null){
				timeDecrease  = Integer.parseInt(CTools.dealNumber(table.get("cou")));
			}
			if(isDelay)
				timeDecrease = -timeDecrease;
		}catch(Exception ex){
			ex.printStackTrace();
		}finally{
			if(dImpl!=null){
				dImpl.closeStmt();
			}if(dCn!=null){
				dCn.closeCn();
			}
		}
		return timeDecrease;
	}
	
	/**
	 * 获得部门、街镇超时数据量
	 * @param deptid
	 * @param String
	 * @return
	 */
	public String getCoutOvertime(String deptid,String time_interval,String overtype,String cp_upid){
		String countSql = "select a.cw_id as cw_id,to_char(a.cw_applytime,'yyyy-MM-dd') as " +
				"cw_applytime from tb_connwork a,tb_connproc b where a.cw_status <> 9 and " +
				"a.cp_id=b.cp_id and b.dt_id="+deptid+"";
		if(!"".equals(time_interval)){
			countSql += time_interval;
		}
		if(!"".equals(cp_upid)){
			countSql += " and b.cp_upid='"+cp_upid+"'";
		}
		
		System.out.println("countSql ========== "+countSql);
		String count2Sql = "";
		Vector vPage = null;
		Hashtable countcontent = null;
		Hashtable content_cw2 = null;
		String cw_id = "";
		String cw_applytime = "";
		int j = 0;
		try{
			dCn = new CDataCn();
			dImpl = new CDataImpl(dCn);
			vPage = dImpl.splitPage(countSql,2000,1);
			if(vPage!=null){
				for(int i=0; i<vPage.size(); i++){
					countcontent = (Hashtable)vPage.get(i);
					cw_id = CTools.dealNull(countcontent.get("cw_id"));
					cw_applytime = CTools.dealNull(countcontent.get("cw_applytime"));
					if("isovertime".equals(overtype)){
						count2Sql = "select a.cw_id from tb_connwork a,tb_connproc b where a.cw_status <> 9 and floor(to_number(decode(cw_managetime,'',(decode(a.cw_finishtime,'',sysdate,a.cw_finishtime)),a.cw_managetime)-to_date(to_char((select dd from (select rownum as rr,hd_date dd from (select g.hd_date hd_date from tb_holiday g where hd_date > to_date('"+cw_applytime+"','yyyy-MM-dd') and g.hd_flag=0 order by hd_date)) d where  d.rr =3),'yyyy-MM-dd'),'yyyy-MM-dd')))>0 and a.cp_id=b.cp_id and a.cw_id='"+cw_id+"'";
						System.out.println("count2Sqlisovertime ========== "+count2Sql);
					}else{
						count2Sql = "select a.cw_id from tb_connwork a,tb_connproc b where a.cw_status <> 9 and floor(to_number(decode(a.cw_finishtime,'',sysdate,decode(a.cw_status,'3',a.cw_finishtime,sysdate))-to_date(to_char((select dd from (select rownum as rr,hd_date dd from (select g.hd_date hd_date from tb_holiday g where hd_date > to_date('"+cw_applytime+"','yyyy-MM-dd') and g.hd_flag=0 order by hd_date)) d where  d.rr =60),'yyyy-MM-dd'),'yyyy-MM-dd')))>0 and a.cp_id=b.cp_id and a.cw_id='"+cw_id+"'";
						System.out.println("count2Sqlisovertimem ========== "+count2Sql);
					}
					content_cw2 = dImpl.getDataInfo(count2Sql);
					if(content_cw2!=null){
						j++;
					}
				}
			}
			
		}catch(Exception ex){
			ex.printStackTrace();
		}finally{
			if(dImpl!=null){
				dImpl.closeStmt();
			}if(dCn!=null){
				dCn.closeCn();
			}
		}
		return j+"";
	}
	/**
	 * 获取部门超时办理申请数
	 * @param deptId
	 * @param timeStrSql
	 * @return
	 */
	public int getDeptOverTimeCounInfo(String deptId,String timeStrSql){
		String deptTimeStrSql = "";
		Hashtable deptcontent = null;
		int wssqyqs = 0;
		try{
			dCn = new CDataCn();
			dImpl = new CDataImpl(dCn);
			deptTimeStrSql = "select count(i.id) as wssqyqs  from infoopen i,taskcenter t where i.id=t.iid and floor(decode(i.step,3,t.endtime,5,t.endtime,10,t.endtime,sysdate)-i.limittime)>0 and i.did='"+deptId+"' "+timeStrSql+" " +
							"order by i.applytime desc,i.id desc";
			deptcontent = dImpl.getDataInfo(deptTimeStrSql);
			if(deptcontent!=null){
				wssqyqs = Integer.parseInt(CTools.dealNumber(deptcontent.get("wssqyqs")));
			}
			
		}catch(Exception ex){
			ex.printStackTrace();
		}finally{
			dImpl.closeStmt();
			dCn.closeCn();
		}
		return wssqyqs;
	}
	
	
	/**
	 * 判断某信件是否超时
	 * @param time_interval
	 * @param cw_id
	 * @return
	 */
	public String getIsOverTime(String time_interval,String cw_id,String overtype){
		String isoverSql = "";
		Hashtable content = null;
		try{
			if("isovertime".equals(overtype)){
				isoverSql = "select a.cw_id from tb_connwork a,tb_connproc b where floor(to_number(decode(cw_managetime,'',(decode(a.cw_finishtime,'',sysdate,a.cw_finishtime)),a.cw_managetime)-to_date(to_char((select dd from (select rownum as rr,hd_date dd from (select g.hd_date hd_date from tb_holiday g where hd_date > to_date('"+time_interval+"','yyyy-MM-dd hh24:mi:ss') and g.hd_flag=0 order by hd_date)) d where  d.rr =3),'yyyy-MM-dd'),'yyyy-MM-dd')))>0 and a.cp_id=b.cp_id and a.cw_id='"+cw_id+"'";
			}
			if("isovertimem".equals(overtype)){
				isoverSql = "select a.cw_id from tb_connwork a,tb_connproc b where floor(to_number(decode(a.cw_finishtime,'',sysdate,decode(a.cw_status,'3',a.cw_finishtime,sysdate))-to_date(to_char((select dd from (select rownum as rr,hd_date dd from (select g.hd_date hd_date from tb_holiday g where hd_date > to_date('"+time_interval+"','yyyy-MM-dd hh24:mi:ss') and g.hd_flag=0 order by hd_date)) d where  d.rr =60),'yyyy-MM-dd'),'yyyy-MM-dd')))>0 and a.cp_id=b.cp_id and a.cw_id='"+cw_id+"'";
			}
			dCn = new CDataCn();
			dImpl = new CDataImpl(dCn);
			content = (Hashtable)dImpl.getDataInfo(isoverSql);
			if(content!=null){
				return "1";
			}else{
				return "0";
			}
			
		}catch(Exception ex){
			ex.printStackTrace();
		}finally{
			if(dImpl!=null){
				dImpl.closeStmt();
			}if(dCn!=null){
				dCn.closeCn();
			}
		}
		return "0";
	}
	/**
	 * 获取延期答复的时间，在原来期限时间上加15个工作日
	 * @param limittime
	 * @return
	 */
	public String getYqdfLimittime(String limittime){
		String strSql = "";
		Hashtable yqdf_content = null;
		String yqdf_limittime = "";
		try{
			
			strSql = "select * from (select rownum,hd_date,hd_flag,dense_rank() over(order by hd_date) rank from tb_holiday where hd_date > to_date('"+limittime+"','yyyy-MM-dd') and hd_flag = 0 order by hd_date ) where rank = 15";
			yqdf_content = dImpl.getDataInfo(strSql);
			if (yqdf_content != null)
			{
				yqdf_limittime = CTools.dealNull(yqdf_content.get("hd_date"));//0工作日1节假日
			}
			
		}catch(Exception ex){
			ex.printStackTrace();
		}		
		return yqdf_limittime;
	}
	
	
	/**
	 * main
	 * @param args
	 */
	public static void main(String args[]){
		TimeCalendar timca = new TimeCalendar();
//		String test = "/NHZF/UPFiles/WorkGuide/20061030053052031.doc";
//		SimpleDateFormat ft = new SimpleDateFormat("yyyy-MM-dd");
//		String applytime = "2009-8-17 18:17:43.0";
//		//String test[] = test.split("/");
//		//System.out.println(test.indexOf("/NHZF/UPFiles/WorkGuide/"));
//		//System.out.println(timca.getdays("2010-01-02", "2009-12-25"));
//		try {
//			System.out.println(ft.format(ft.parse(applytime)));
//		} catch (ParseException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
		
		//System.out.println(timca.getLimittime("2009-06-26", "1211"));
		timca.setWeekDays("2019-01-01", "2020-12-31");
		//System.out.println("========"+timca.getMapHolidays("2017-06-21", 10));
		//System.out.println("========"+timca.setWeekDays("", ""));
		
		

	}
}
