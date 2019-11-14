package edu.yale.its.tp.cas.servlet;

import java.net.URLEncoder;
import java.util.Hashtable;

import com.component.database.CDataCn;
import com.component.database.CDataImpl;
import com.util.CTools;
/**
 * 获得服务器端登录用户的信息并返回到客户端
 * @author yaojiwei
 * 20071107
 */
public class GetUserMessage {

	public GetUserMessage() {
	}
	//取得服务器端登录用户的基本信息
	public StringBuffer getUserMessageByUidSite(String uid) {
    	CDataCn cDn=null;
    	CDataImpl dImpl=null;
    	UserModel user =new UserModel();
    	Hashtable table = null;
    	String strSql="";
    	try{
    		cDn  =new CDataCn();
    		dImpl =new CDataImpl(cDn);
    		  strSql="select us_id from tb_user where us_uid='"+uid+"' and us_isok=1";
    		//us_isok用户是否停用标志:1正常用户0停用用户
    		table  =dImpl.getDataInfo(strSql);
    		if(table!=null){
    			user.setSuccess(URLEncoder.encode("yes","utf-8"));
    			user.setId(URLEncoder.encode(CTools.dealNull(table.get("us_id"),"utf-8")));
    			user.setUid(URLEncoder.encode(uid,"utf-8"));
    			user.setIsok(URLEncoder.encode(CTools.dealNull("1"),"utf-8"));						 //用户是否可用1可用0不可用
    			
    			//user.setRegtime(URLEncoder.encode(CTools.dealNull(table.get("us_regdate")),"utf-8"));//用户注册时间
    			//user.setTel(URLEncoder.encode(CTools.dealNull(table.get("us_tel")),"utf-8"));        //联系电话
    			//user.setAddress(URLEncoder.encode(CTools.dealNull(table.get("us_address")),"utf-8"));//联系地址
    			//user.setZip(URLEncoder.encode(CTools.dealNull(table.get("us_zip")),"utf-8"));		 //邮政编码
    			//user.setEmail(URLEncoder.encode(CTools.dealNull(table.get("us_email")),"utf-8"));    //电子邮件
    			//user.setName(URLEncoder.encode(CTools.dealNull(table.get("us_name")),"utf-8"));
    			//user.setSex(URLEncoder.encode(CTools.dealNull(table.get("us_sex")),"utf-8"));
    			//user.setPwd(URLEncoder.encode(CTools.dealNull(table.get("us_pwd")),"utf-8"));//用户密码---判断服务器端用户密码是否加密
    			//user.setCellphonenumber(URLEncoder.encode(CTools.dealNull(table.get("us_cellphonenumber")),"utf-8"));
    			//user.setIdcardnumber(URLEncoder.encode(CTools.dealNull(table.get("us_idcardnumber")),"utf-8"));
    			//user.setStatus(URLEncoder.encode(CTools.dealNull(table.get("us_status")),"utf-8"));
    		}
    	}catch (Exception e) {
			System.out.println("GetUserMessage:"+e.getMessage());
		}finally{
			if(dImpl!=null){
				dImpl.closeStmt();
			}
			if(cDn!=null){
				cDn.closeCn();
			}
		}
		return userXml(user);
	}
	private StringBuffer userXml(UserModel user) {
		StringBuffer userXml  =new StringBuffer();
		userXml.append("<success>"+user.getSuccess()+"</success>");//返回是否成功标识,yes成功,no不成功
		userXml.append("<id>"+user.getId()+"</id>");                 //用户表中主键ID
		userXml.append("<uid>"+user.getUid()+"</uid>");              //用户登录的UID
		
		//userXml.append("<regtime>"+user.getRegtime()+"</regtime>");  //用户注册时间
		//userXml.append("<tel>"+user.getTel()+"</tel>");              //联系方式
		//userXml.append("<address>"+user.getAddress()+"</address>");  //用户联系地址
		//userXml.append("<zip>"+user.getZip()+"</zip>");              //邮政编码
		//userXml.append("<email>"+user.getEmail()+"</email>");        //用户邮箱
		//userXml.append("<name>"+user.getName()+"</name>");
		//userXml.append("<sex>"+user.getSex()+"</sex>");
		//userXml.append("<cellphonenumber>"+user.getCellphonenumber()+"</cellphonenumber>");
		//userXml.append("<idcardnumber>"+user.getIdcardnumber()+"</idcardnumber>");//身份证
		//userXml.append("<status>"+user.getStatus()+"</status>");
		return userXml;
	}
}
