package com.webservise;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.Hashtable;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import com.component.database.CDataCn;
import com.component.database.CDataImpl;
import com.emailService.CASUtil;
import com.util.CDate;
import com.util.CFile;
import com.util.CMessage;
import com.util.CTools;

public class HBJWebservice {
	
	public HBJWebservice(){}
	/**
	 * 
	 * @param hbjxml 环保局反馈XML
	 */
	public String getXmls(String hbjxml){
		String hb_title = "";//事项名称
		String hb_workid = "";//事项ID
		String hb_userid = "";//环保局浦东用户ID
		String hb_useruid = "";//用户UID
		String hb_username = "";//用户名称
		String hb_huifu = "";//办理事项回复
		CDataCn dCn = null;
        CDataImpl dImpl = null;
        Hashtable content = null;
//        System.out.println("1111111111===="+hbjxml);
        try{
        	dCn = new CDataCn();
            dImpl = new CDataImpl(dCn);
            hb_workid = this.getUserColumn(hbjxml, "workid").trim();//环保局事项ID
    		hb_title = this.getUserColumn(hbjxml, "title").trim();//事项名称
    		hb_useruid = this.getUserColumn(hbjxml, "useruid").trim();//用户ID
    		hb_username = this.getUserColumn(hbjxml, "username").trim();//用户名称
    		hb_huifu = this.getUserColumn(hbjxml, "huifu").trim();//办理事项回复
            
    		dCn.beginTrans();
    		
	        //新增用户信息
    		if(hb_useruid.indexOf("@")>0){
    			int index = hb_useruid.lastIndexOf('@'); 
    			hb_useruid = hb_useruid.substring(0,index);
    		}
    		String checkUser = "select us_id from tb_user where us_uid = '"+hb_useruid+"'";
	        content = (Hashtable)dImpl.getDataInfo(checkUser);
	        if(content==null){
	    		hb_userid = String.valueOf(dImpl.addNew("tb_user","us_id"));
		        dImpl.setValue("us_uid",hb_useruid,CDataImpl.STRING);
		        dImpl.setValue("us_name",hb_username,CDataImpl.STRING);
		        dImpl.setValue("us_pwd","123456",CDataImpl.STRING);//密码
		        dImpl.setValue("ws_id","o27",CDataImpl.STRING);
		        dImpl.update();
	        }else{
	        	hb_userid = CTools.dealNull(content.get("us_id"));
	        }
	        
//	        System.out.println(hbjxml+"===="+hb_workid+"=2"+hb_title+"=3"+hb_useruid+"=4"+hb_username+"="+hb_huifu);
	        
	        //判断是否有重复消息
	        String checkSql = "select ma_id from tb_message where ma_primaryid = '"+hb_workid+"'";
	        Hashtable checkcontent = dImpl.getDataInfo(checkSql);
	        if(checkcontent!=null){
	        	return "false";//已经存在此环保局办事消息ID
	        }
	        //记录入用户中心
	        dCn.beginTrans();
            CMessage msg = new CMessage(dImpl);
            msg.addNew();
            msg.setValue(CMessage.msgReceiverId, hb_userid);//用户ID
            msg.setValue(CMessage.msgReceiverName, hb_username);//用户名称||公司名称
            msg.setValue(CMessage.msgTitle, hb_title);//事项名称
            msg.setValue(CMessage.msgSenderId, "46");//环保局单位ID
            msg.setValue(CMessage.msgSenderName, "环保局");
            msg.setValue(CMessage.msgSenderDesc, "环保局");
            msg.setValue(CMessage.msgIsNew, "1");
            msg.setValue(CMessage.msgRelatedType, "1");
            msg.setValue(CMessage.msgPrimaryId, hb_workid);
            msg.setValue(CMessage.msgSendTime, new CDate().getThisday());
            msg.setValue(CMessage.msgContent, hb_huifu);
            msg.update();
            if(!"".equals(dCn.getLastErrString()))
            {
                dCn.rollbackTrans();
            } else
            {
                dCn.commitTrans();
            }
            //
            return "true";
        }catch(Exception ex){
        	ex.printStackTrace();
        	return "false";
        }
	}
	
	public String getUserColumn(String userXml, String column)
    {
        String regBegin = "<" + column + ">";
        String regEnd = "</" + column + ">";
        String regC = regBegin + "([\\w\\W]*?)" + regEnd;
        String returnStr = "";
        Pattern p = null;
        Matcher m = null;
        p = Pattern.compile(regC);
        try {
			userXml = URLDecoder.decode(userXml, "utf-8");
		} catch (UnsupportedEncodingException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
        m = p.matcher(userXml);
        if(m.find())
        {
            returnStr = m.group();
            returnStr = returnStr.replace(regBegin, "");
            returnStr = returnStr.replace(regEnd, "");
            return returnStr;
        } else
        {
            return returnStr;
        }
    }
	
	public static void main(String args[]){
		HBJWebservice hbj = new HBJWebservice();
		//String hbjxml = "<?xml version=\"1.0\" encoding=\"utf-8\"?><BackInfo><workid>80</workid><title>您申请的项目“户外广告设置审批”交互消息!</title><useruid>yc_huangxiao@pudong.gov.cn</useruid><username>浦东新区</username><huifu>测试</huifu></BackInfo>";
		String hbjxml = "<xml><BackInfo><workid>80</workid><title>您申请的项目“户外广告设置审批”交互消息!</title><useruid>yc_huangxiao@pudong.gov.cn</useruid><username>浦东新区</username><huifu>测试</huifu></BackInfo></xml>";
		System.out.println(hbj.getXmls(hbjxml));
	}
}
