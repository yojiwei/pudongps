package com.webservise;

import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.util.Date;
import java.util.Hashtable;

import org.jdom.Document;
import org.jdom.Element;
import org.jdom.input.SAXBuilder;

import com.component.database.CDataCn;
import com.component.database.CDataImpl;
import com.util.CDate;
import com.util.ReadProperty;

/**
 * 与监察系统对接的接口
 * @author Administrator
 *
 */
public class ControlWorkService {
	ReadProperty rp = new ReadProperty();
	//获取监察数据插入门户网站数据库
	public String controlWork(String username,String password,String xmls){
		Element ele = null;
		int isControl = 0;
		String returnxml = "";
		//判断用户信息
		String controlwork_username = rp.getPropertyValue("controlwork_username");
		String controlwork_password = rp.getPropertyValue("controlwork_password");
		if(!username.equals(controlwork_username)||!password.equals(controlwork_password)){
			returnxml = "登录信息出错";
		}
		ele = initEle(xmls);
		if(ele!=null)
		isControl = controlWork(ele);
		if(isControl==0){
			returnxml = "操作成功";
		}else{
			returnxml = "操作失败";
		}
		
		return returnxml;
	}
	//操作数据
	private int controlWork(Element ele){

		String tcw_number = "";
		String tcw_prnum = "";
		String tcw_prname = "";
		String tcw_dtname = "";
		String tcw_systemcode = "";
		String tcw_systemname = "";
		String tcw_residentname = "";
		String tcw_companyname = "";
		String tcw_flownum = "";
		String tcw_systemother = "";
		String tcw_date = CDate.getThisday();
		String tcw_status = "";
		CDataCn dCn = null;
		CDataImpl dImpl = null;
		Hashtable contentPr = null;
		Hashtable contentDept = null;
		Hashtable deptPr = null;
		try {
			dCn = new CDataCn();
			dImpl = new CDataImpl(dCn);
			
			if(ele!=null){
				tcw_prnum = ele.getChildTextTrim("prnum");
				tcw_number= ele.getChildTextTrim("number");
				tcw_prname = ele.getChildTextTrim("prname");
				tcw_systemcode = ele.getChildTextTrim("systemcode");
				tcw_systemname = ele.getChildTextTrim("systemname");
				tcw_dtname = ele.getChildTextTrim("dtname");
				tcw_status = ele.getChildTextTrim("status");
				tcw_residentname = ele.getChildTextTrim("residentname");
				tcw_companyname = ele.getChildTextTrim("companyname");
				tcw_flownum = ele.getChildTextTrim("flownum");
				tcw_systemother = ele.getChildTextTrim("systemother");
				
				
				dCn.beginTrans();
				dImpl.addNew("tb_controlwork","tcw_id",CDataImpl.PRIMARY_KEY_IS_VARCHAR);
				dImpl.setValue("tcw_prnum",tcw_prnum,CDataImpl.STRING);
				dImpl.setValue("tcw_number",tcw_number,CDataImpl.STRING);
				dImpl.setValue("tcw_systemcode",tcw_systemcode,CDataImpl.STRING);
				dImpl.setValue("tcw_systemname",tcw_systemname,CDataImpl.STRING);
				dImpl.setValue("tcw_prname",tcw_prname,CDataImpl.STRING);
				dImpl.setValue("tcw_dtname",tcw_dtname,CDataImpl.STRING);
				dImpl.setValue("tcw_date",tcw_date,CDataImpl.DATE);
				dImpl.setValue("tcw_status",tcw_status,CDataImpl.STRING);
				dImpl.setValue("tcw_residentname",tcw_residentname,CDataImpl.STRING);
				dImpl.setValue("tcw_companyname",tcw_companyname,CDataImpl.STRING);
				dImpl.setValue("tcw_flownum",tcw_flownum,CDataImpl.STRING);
				dImpl.setValue("tcw_systemother",tcw_systemother,CDataImpl.STRING);
				
				dImpl.update();
				dCn.commitTrans();
			}
		}catch(Exception ex){
			ex.printStackTrace();
			
			return 1;
		}finally{
			if(dImpl!=null){
				dImpl.closeStmt();
			}
			if(dCn!=null){
				dCn.closeCn();
			}
		}
		return 0;
	}
	/**
	 * Description：初始化变量
	 * 
	 * @param fileStr
	 *            一段xml的字符串
	 */
	private Element initEle(String fileStr) {
		Document doc = null;

		SAXBuilder sb = null;

		Element element = null;
		try {
			sb = new SAXBuilder();
			InputStream inputStream = new ByteArrayInputStream(fileStr
					.getBytes("utf-8"));
			doc = sb.build(inputStream);
			element = doc.getRootElement();
		} catch (Exception ex) {
			System.out.println(" XML格式错误: " + ex.getMessage());
		}
		return element;
	}
	
	public static void main(String args[]){
		ControlWorkService cws = new ControlWorkService();
		String xmls = "<?xml version='1.0' encoding='utf-8'?><root><number>123456</number><prname>测试事项名称</prname><prnum>1111111</prnum><systemcode>dzjc</systemcode><systemname>电子监察</systemname><dtname>建交委</dtname><status>通过</status><residentname>申请人(个人)</residentname><companyname>申请人(企业)</companyname><flownum>业务流水号</flownum><systemother>相关系统</systemother></root>";
		System.out.println(cws.controlWork("dzjc","dzjc1234567",xmls));
	}
	
}
