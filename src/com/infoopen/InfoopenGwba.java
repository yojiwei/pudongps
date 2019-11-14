package com.infoopen;

import java.util.Hashtable;
import java.util.Vector;

import com.component.database.CDataCn;
import com.component.database.CDataImpl;
import com.util.CTools;
import com.util.TimeCalendar;

/**
 * 处理浦东公文备案系统超期申请
 * iscq
 * 超期1 不超期0
 * @author Administrator
 *
 */
public class InfoopenGwba {
	public String controlCqGwba(){
		String iscq = "0";//0不超期1超期
		CDataCn dCn = null;
		CDataImpl dImpl = null;
		Vector vectorPage = null;
		Hashtable content = null;
		Hashtable endtimecontent = null;
		String cqSql = "";
		String id = "";
		String limittime = "";
		String endtime = "";
		String step = "";
		TimeCalendar tc = null;
		try {
			dCn = new CDataCn();
		    dImpl = new CDataImpl(dCn);
		    tc = new TimeCalendar();
		    cqSql = "select id,to_char(limittime,'yyyy-MM-dd') as limittime,step from infoopen where iscq is null order by id desc";
		    vectorPage = dImpl.splitPage(cqSql, 20000, 1);
		      if (vectorPage != null)
		      { 
		        for (int j = 0; j < vectorPage.size(); j++)
		        {
		          content = ((Hashtable)vectorPage.get(j));
		          id = CTools.dealNull(content.get("id"));
		          limittime = CTools.dealNull(content.get("limittime"));
		          step = CTools.dealNull(content.get("step"));
		          String endtimeSql = "select decode(max(to_char(endtime,'yyyy-MM-dd')),'',to_char(sysdate,'yyyy-MM-dd'),max(to_char(endtime,'yyyy-MM-dd'))) as endtime from taskcenter where iid = '"+id+"' and endtime is not null order by id desc ";
		          endtimecontent  = dImpl.getDataInfo(endtimeSql);
				  if(endtimecontent!=null){
					endtime = CTools.dealNull(endtimecontent.get("endtime"));
				  }
				  
				  if(!"".equals(endtime)&&!"".equals(limittime)){
				  int days = tc.getTimeDecrease(endtime,limittime);
				  
				  
				  if(step.equals("2")){//待处理
						if(days>=10){
							iscq = "0";//正常
						}else if(days>=5 && days<10){
							iscq = "0";//正常
						}else if(days>=0 && days<5){
							iscq = "0";//正常
						}else if(days<0){
							iscq = "1";//超期
						}
					}else if(step.equals("8")||step.equals("3")||step.equals("7")){//处理中
						if(days>=5){
							iscq = "0";//正常
						}else if(days>=0 && days<5){
							iscq = "0";//正常
						}else if(days<0){
							iscq = "1";//超期
						}
					}else if(step.equals("5")){//已完成
						if(days>=0){
							iscq = "0";//正常
						}else{
							iscq = "1";//超期
						}
					}
				  }
				  
				  dImpl.edit("infoopen", "id", Integer.parseInt(id));
				  dImpl.setValue("iscq", iscq, CDataImpl.STRING);
				  dImpl.update();
				  
				  
				  if(j%200==0){
						dImpl.closeStmt();
						dCn.closeCn();
						
						dCn = new CDataCn(); 
						dImpl = new CDataImpl(dCn); 
					}
				  
				  
		        }
		      }else{
		    	  System.out.println("-----------暂时没有可以处理的数据------------");
		      }
		      
			
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}finally{
			dImpl.closeStmt();
			dCn.closeCn();
		}
		return "is over";
	}
	
	public static void main(String args[]){
		InfoopenGwba ifg = new InfoopenGwba();
		System.out.println(ifg.controlCqGwba());
	}
	
}
