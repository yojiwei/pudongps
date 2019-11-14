package com.webservise;

import java.util.Hashtable;
import java.util.TimerTask;
import java.util.Vector;

import com.component.newdatabase.CDataCn;
import com.component.newdatabase.CDataImpl;
import com.component.newdatabase.MyCDataCn;
import com.component.newdatabase.MyCDataImpl;
import com.util.CDate;
import com.util.CTools;

/**
 * 用于抓取市民中心办事反馈信息
 * --万达提供oracle数据库
 * @author Administrator
 *
 */
public class ControlWorkFeedBack extends TimerTask{
	public ControlWorkFeedBack(){}
	/**
	 * run方法
	 */
	public void run() {
		// TODO Auto-generated method stub
		new ControlWorkFeedBack().getCwfbListLisenter();
	}
	String fb_name = "";
	String fb_number = "";
	String fb_status = "";
	String fb_slname = "";
	String fb_deptname = "";
	String fb_date = "";
	String fb_cwfb_status = "";
	/**
	 * 调用市民中心数据库获取数据
	 * @param fb_time
	 * @param fb_deptcode
	 */
	public void getCWFBlists(String fb_time,String fb_deptcode){
		String fbSql = "";
		CDataCn dCn = null;
		CDataImpl dImpl = null;
		Hashtable contentPr = null;
		Vector vPage = null;
		String deal_no = "";
		String event_name = "";
		String deal_status ="";
		String deal_date = "";
		String apply_name ="";
		String trans_unit_name = "";
		try {
			//市民中心数据
			dCn = new CDataCn();
			dImpl = new CDataImpl(dCn);
			
			dCn.beginTrans();
			
			
			fbSql = "select ve.deal_no,ve.event_name,ve.deal_status,ve.deal_date,ve.apply_name,vu.name from view_exchange_info ve,view_unit_code vu " +
					"where ve.deal_date > '"+fb_time+"' and ve.trans_unit_code = vu.code and vu.code in("+fb_deptcode+") and vu.code is not null " +
							" order by ve.deal_date desc";
			vPage = dImpl.splitPage(fbSql, 20000, 1);
			for(int i=0;i<vPage.size();i++){
			contentPr = (Hashtable)vPage.get(i);
				if(contentPr!=null){
					deal_no = CTools.dealNull(contentPr.get("deal_no"));
					event_name = CTools.dealNull(contentPr.get("event_name"));
					deal_status = CTools.dealNull(contentPr.get("deal_status"));
					deal_date = CTools.dealNull(contentPr.get("deal_date"));
					apply_name = CTools.dealNull(contentPr.get("apply_name"));
					trans_unit_name = CTools.dealNull(contentPr.get("name"));
					if("浦东新区工商局".equals(trans_unit_name)){
						trans_unit_name = "新区工商分局";
					}
					if("浦东新区食药监局".equals(trans_unit_name)){
						trans_unit_name = "食品药品监督管理局浦东分局";
					}
					System.out.println(i+1+" "+deal_no+" "+event_name+" "+deal_status+" "+deal_date+" "+apply_name+" "+trans_unit_name);
					saveCWFB(deal_no,event_name,deal_status,deal_date,apply_name,trans_unit_name);
				}
				
				if(i%200==0){
					dImpl.closeStmt();
					dCn.closeCn();
					
					dCn = new CDataCn();
					dImpl = new CDataImpl(dCn);
				}
				
				
				
			}
			
			dCn.commitTrans();
			
			System.out.println("--- over ---");
			
		}catch(Exception ex){
			ex.printStackTrace();
		}finally{
			if(dImpl!=null)
				dImpl.closeStmt();
			if(dCn!=null)
				dCn.closeCn();
		}

	}
	/**
	 * 插入浦东数据库
	 * @param deal_no
	 * @param event_name
	 * @param deal_status
	 * @param deal_date
	 * @param apply_name
	 * @param trans_unit_name
	 */
	public void saveCWFB(String deal_no,String event_name,String deal_status,String deal_date,String apply_name,String trans_unit_name){
		MyCDataCn mdCn = null;
		MyCDataImpl mdImpl = null;
		try {
			//浦东数据库
			mdCn = new MyCDataCn();
			mdImpl = new MyCDataImpl(mdCn);
			
			//插入浦东数据库
			mdImpl.addNew("tb_controlwork","tcw_id",MyCDataImpl.PRIMARY_KEY_IS_VARCHAR);
			mdImpl.setValue("tcw_prnum",deal_no,MyCDataImpl.STRING);
			mdImpl.setValue("tcw_prname",event_name,MyCDataImpl.STRING);
			mdImpl.setValue("tcw_dtname",trans_unit_name,MyCDataImpl.STRING);
			mdImpl.setValue("tcw_date",deal_date,MyCDataImpl.DATE);
			mdImpl.setValue("tcw_status",deal_status,MyCDataImpl.STRING);
			mdImpl.setValue("tcw_companyname",apply_name,MyCDataImpl.STRING);
			mdImpl.update();
			
			
		}catch(Exception ex){
			ex.printStackTrace();
		}finally{
			if(mdImpl!=null)
				mdImpl.closeStmt();
			if(mdCn!=null)	
				mdCn.closeCn();
		}
			
	}
	/**
	 * 测试方法
	 * @param fb_time
	 * @param fb_deptname
	 * @return
	 */
	public String testConn(String fb_time,String fb_deptname){
		String fbSql = "";
		CDataCn dCn = null;
		CDataImpl dImpl = null;
		Hashtable contentPr = null;
		Vector vPage = null;
		String deal_no = "";
		String event_name = "";
		String deal_status ="";
		String deal_date = "";
		String apply_name ="";
		String trans_unit_code ="";
		String trans_unit_name = "";
		try {
			//市民中心数据
			dCn = new CDataCn();
			dImpl = new CDataImpl(dCn);
			
			fbSql = "select ve.deal_no,ve.event_name,ve.deal_status,ve.deal_date,ve.apply_name,vu.name,vu.code from view_exchange_info ve,view_unit_code vu " +
					"where ve.deal_date = '"+fb_time+"' and ve.trans_unit_code = vu.code and vu.name ='"+fb_deptname+"' and vu.code is not null " +
							" order by ve.deal_date desc";
			vPage = dImpl.splitPage(fbSql, 500, 1);
			for(int i=0;i<vPage.size();i++){
			contentPr = (Hashtable)vPage.get(i);
				if(contentPr!=null){
					deal_no = CTools.dealNull(contentPr.get("deal_no"));
					event_name = CTools.dealNull(contentPr.get("event_name"));
					deal_status = CTools.dealNull(contentPr.get("deal_status"));
					deal_date = CTools.dealNull(contentPr.get("deal_date"));
					apply_name = CTools.dealNull(contentPr.get("apply_name"));
					trans_unit_code = CTools.dealNull(contentPr.get("code"));
					trans_unit_name = CTools.dealNull(contentPr.get("name"));
					System.out.println(i+1+" "+deal_no+" "+event_name+" "+deal_status+" "+deal_date+" "+apply_name+" "+trans_unit_code+" "+trans_unit_name);
				}
			}
			System.out.println("--- over ---");
			
		}catch(Exception ex){
			ex.printStackTrace();
		}finally{
			dImpl.closeStmt();
			dCn.closeCn();
		}
		return "over";
	}
	
	/**
	 * 获取数量
	 * @param fb_time
	 * @param fb_deptcode
	 * @return
	 */
	public String getCount(String fb_time,String fb_deptcode){
		String fbSql = "";
		CDataCn dCn = null;
		CDataImpl dImpl = null;
		Hashtable contentPr = null;
		String countfb = "";
		try {
			//市民中心数据
			dCn = new CDataCn();
			dImpl = new CDataImpl(dCn);
			
			fbSql = "select count(ve.deal_no) as conpr from view_exchange_info ve,view_unit_code vu " +
					"where ve.deal_date > '"+fb_time+"' and ve.trans_unit_code = vu.code and vu.code in("+fb_deptcode+")" +
							" order by ve.deal_date desc";
			contentPr = (Hashtable)dImpl.getDataInfo(fbSql);
			if(contentPr!=null){
				countfb = CTools.dealNumber(contentPr.get("conpr"));
			}
			System.out.println("--- over ---"+countfb);
			
		}catch(Exception ex){
			ex.printStackTrace();
		}finally{
			dImpl.closeStmt();
			dCn.closeCn();
		}
		return countfb;
	}
	
	/**
	 * 每天定时执行此方法，进行数据抓取
	 */
	public void getCwfbListLisenter(){
		this.getCWFBlists(CDate.getThisday(), "'PDGSJ','PDYJJ','PD_XQFGW','PD_HBJ','PD_DAJ'");
	}
	
	public static void main(String args[]){
		ControlWorkFeedBack cwfb = new ControlWorkFeedBack();
		//工商局：PDGSJ  
		//食药监局：PDYJJ 
		//发改委：PD_XQFGW
		//环保局：PD_HBJ
		//档案局：PD_DAJ

		cwfb.getCwfbListLisenter();
		//cwfb.testConn("2013-09-30","浦东新区食药监局");
		//cwfb.getCount("2014-12-22","'PDYJJ'");
	}
	
}
