package com.newpointservice;

import java.util.Hashtable;
import java.util.Vector;

import javax.xml.namespace.QName;

import org.apache.axis.client.Call;
import org.apache.axis.client.Service;

import com.component.database.CDataCn;
import com.component.database.CDataImpl;
import com.util.CDate;
import com.util.CTools;
import com.webservise.WebserviceReadProperty;

/**
 * 与新点进行信访反馈数据接口对接
 * @author Administrator
 * http://61.129.89.214/PDWebService_XF/Service.asmx
 *
 */
public class EmailFeedback {
	CDataCn dCn=null;   //新建数据库连接对象
	CDataImpl dImpl=null;  //新建数据接口对象
	/**
	 * 构造函数
	 */
	public EmailFeedback(){}
	
	
	/**
	 * 获取信访反馈XML
	 * @param emailId
	 * @return
	 */
	public void putEmailFeedbackXmls(){
		Vector vector = null;
		Hashtable contentEmail = null;
		String ui_id = "";
		String cw_feedback = "";
		String cw_status = "";
		String cw_finishtime = "";
		StringBuffer emailXml  =new StringBuffer();
		String ValidateData = "Epoint_WebSerivce_**##0601";
		String emailSql = "";

		try{
			dCn = new CDataCn();
			dImpl = new CDataImpl(dCn);
			
			
			WebserviceReadProperty pro = new WebserviceReadProperty();
			String openendpoint=pro.getPropertyValue("openendpoint");
			String opennamespaceuri=pro.getPropertyValue("opennamespaceuri");
			String opensoapactionuri=pro.getPropertyValue("opensoapactionuri");
			
			String endpoint = "http://61.129.89.214/PDWebService_XF/Service.asmx";
			Service service = new Service();
			Call call = (Call) service.createCall();
			call.setTargetEndpointAddress(new java.net.URL(endpoint));

			call.setOperationName(new QName(opennamespaceuri, "MailReply"));
			call.addParameter(new QName(opennamespaceuri,"ParasXml"), org.apache.axis.encoding.XMLType.XSD_STRING,javax.xml.rpc.ParameterMode.IN);
			call.addParameter(new QName(opennamespaceuri,"ValidateData"), org.apache.axis.encoding.XMLType.XSD_STRING,javax.xml.rpc.ParameterMode.IN);
			
			call.setReturnType(org.apache.axis.encoding.XMLType.XSD_BOOLEAN);
			call.setUseSOAPAction(true);
			call.setSOAPActionURI(opensoapactionuri);
			
			
			emailSql = "select ui_id,cw_feedback,cw_status,cw_finishtime from tb_connwork where cw_isxd = 1 order by cw_applytime ";
			vector = dImpl.splitPage(emailSql,20,1);
			if(vector!=null){
				for(int j=0;j<vector.size();j++)
	            {
					contentEmail = (Hashtable)vector.get(j);
					ui_id = CTools.dealNull(contentEmail.get("ui_id"));
					cw_feedback = CTools.dealNull(contentEmail.get("cw_feedback"));
					cw_status = CTools.dealNull(contentEmail.get("cw_status"));
					cw_finishtime = CTools.dealNull(contentEmail.get("cw_finishtime"));
					//组织XMLS
					emailXml.append("<xml><paras>");
					emailXml.append("<netlvid>"+ui_id+"</netlvid>");//第三方系统ID
					emailXml.append("<content>"+cw_feedback+"</content>");//反馈信息
					emailXml.append("<status>"+cw_status+"</status>"); //信访状态
					emailXml.append("<finishtime>"+cw_finishtime+"</finishtime>");  //办理时间
					emailXml.append("</paras>");
					//调用接口
					String returnXml= (String) call.invoke(new Object[] {ValidateData,emailXml} );
					//if(returnXml){
						//修改信访反馈推送状态
						dImpl.edit("tb_connwork", "ui_id", ui_id);
						dImpl.setValue("cw_isxd","0", CDataImpl.INT);
						dImpl.update();
					//}
					
					
	            }
			}
			
		}catch(Exception ex){
			ex.printStackTrace();
			System.out.println("失败:"+CDate.getNowTime()+" EmailFeedback.getEmailFeedbackXmls " +ex.getMessage());
		}finally{
			dImpl.closeStmt();
			dCn.closeCn();
		}
	}
	
	public static void main(String args[]){
		String xmls = "<?xml version=\"1.0\" encoding=\"gb2312\" ?><paras><netlvid>1</netlvid><content>测试信访反馈内容</content><status>2</status></paras>";
		EmailFeedback efeedback = new EmailFeedback();
		efeedback.putEmailFeedbackXmls();
	}

}
