package com.webservise;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.Hashtable;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import com.component.database.CDataCn;
import com.component.database.CDataImpl;
import com.util.CDate;
import com.util.CMessage;
import com.util.CTools;
import com.util.ReadProperty;
/**
 * 
 * @param workxml 浦东提供给委办局、各街道镇内部系统调用的办事反馈接口
 * 及时的将反馈信息更新到浦东门户网站用户中心
 * 
 */
public class WorkFeedbackService {
	private ReadProperty pro = null;
	public WorkFeedbackService(){
		pro = new ReadProperty();
	}
	/**
	 * 供各委办局办事反馈的方法
	 * @param workxml 反馈的XMLS
	 * @param name 接口用户名
	 * @param password 接口密码
	 * @return 返回true、false的字符串，true操作数据库成功，false操作数据库失败
	 */
	public String getXmls(String workxml){
		String hb_title = "";//事项名称
		String hb_workid = "";//事项ID
		String hb_userid = "";//环保局浦东用户ID
		String hb_useruid = "";//用户UID
		String hb_username = "";//用户名称
		String hb_deptid = "";//办事反馈部门ID
		String hb_deptname = "";//办事反馈部门
		String hb_huifu = "";//办理事项回复
		String hb_usname = "";//调用接口验证用户名
		String hb_uspass = "";//调用接口验证密码
		CDataCn dCn = null;
        CDataImpl dImpl = null;
        Hashtable content = null;
        
        String pro_username = "";
        String pro_password = "";
        
        try{
        	dCn = new CDataCn();
            dImpl = new CDataImpl(dCn);
            
            pro_username = pro.getPropertyValue("pro_username");
            pro_password = pro.getPropertyValue("pro_password");
            
            
            hb_workid = this.getUserColumn(workxml, "workid").trim();//事项ID
    		hb_title = this.getUserColumn(workxml, "title").trim();//事项名称
    		hb_useruid = this.getUserColumn(workxml, "useruid").trim();//用户ID
    		hb_username = this.getUserColumn(workxml, "username").trim();//用户名称
    		hb_deptid = this.getUserColumn(workxml, "deptid").trim();//反馈部门
    		hb_deptname = this.getUserColumn(workxml, "deptname").trim();//反馈部门
    		hb_usname = this.getUserColumn(workxml, "usname").trim();//反馈部门
    		hb_uspass = this.getUserColumn(workxml, "uspass").trim();//反馈部门
    		hb_huifu = this.getUserColumn(workxml, "huifu").trim();//办理事项回复
            
    		
    		//用户名、密码验证
            if(!pro_username.equals(hb_usname) || !pro_password.equals(hb_uspass)){
            	return "false";//错误的用户名或密码！
            }
    		
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
	        
	        
	        //System.out.println(hbjxml+"===="+hb_workid+"=2"+hb_title+"=3"+hb_useruid+"=4"+hb_username+"="+hb_huifu);
	        
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
            msg.setValue(CMessage.msgSenderId, hb_deptid);//单位ID
            msg.setValue(CMessage.msgSenderName, hb_deptname);
            msg.setValue(CMessage.msgSenderDesc, hb_deptname);
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
		WorkFeedbackService wfs = new WorkFeedbackService();
		//String wfsxml = "<xml><BackInfo><workid>80</workid><title>您申请的项目“户外广告设置审批”交互消息!</title><useruid>yc_huangxiao@pudong.gov.cn</useruid><username>浦东新区</username><huifu>测试</huifu></BackInfo><usname>调用接口的验证用户名</usname><uspass>调用接口的验证密码</uspass></xml>";
		String wfsxml = "<xml><BackInfo><workid>402880482c76679c012c767e17b20003</workid><title>测试1</title><useruid>kingroc</useruid><username>测试企业</username><deptid>46</deptid><deptname>网上申报系统</deptname><huifu>反馈意见反馈意见反馈意见</huifu></BackInfo><usname>wbj</usname><uspass>wbj123</uspass></xml>";
		System.out.println(wfs.getXmls(wfsxml));


	}
}
