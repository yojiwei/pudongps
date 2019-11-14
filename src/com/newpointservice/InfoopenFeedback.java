package com.newpointservice;

import java.util.Hashtable;
import java.util.Vector;

import javax.xml.namespace.QName;

import org.apache.axis.client.Call;
import org.apache.axis.client.Service;

import com.component.database.CDataCn;
import com.component.database.CDataImpl;
import com.emailService.CASUtil;
import com.util.CDate;
import com.util.CTools;
import com.webservise.WebserviceReadProperty;

/**
 * 与新点进行依申请公开反馈数据对接
 * @author Administrator
 * http://61.129.89.214/PDWebService_XF/Service.asmx
 *
 */
public class InfoopenFeedback {
	CDataCn dCn=null;   //新建数据库连接对象
	CDataImpl dImpl=null;  //新建数据接口对象
	/**
	 * 构造函数
	 */
	public InfoopenFeedback(){}
	/**
	 * 推送依申请回复信息
	 */
	public void putInfoopenFeedbackXmls(){
		Vector vector = null;
		Hashtable contentEmail = null;
		String infoid = "";
		String statusname = "";
		String feedback = "";
		String isovertime = "";
		String endtime = "";
		StringBuffer infoXml  =new StringBuffer();
		String ValidateData = "Epoint_WebSerivce_**##0601";
		String infoSql = "";
		String returnXml = "";
		String returnStatus = "";
		String returnErrors = "";

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

			call.setOperationName(new QName(opennamespaceuri, "YsqgkReply"));
			call.addParameter(new QName(opennamespaceuri,"ValidateData"), org.apache.axis.encoding.XMLType.XSD_STRING,javax.xml.rpc.ParameterMode.IN);
			call.addParameter(new QName(opennamespaceuri,"ParasXml"), org.apache.axis.encoding.XMLType.XSD_STRING,javax.xml.rpc.ParameterMode.IN);
			
			call.setReturnType(org.apache.axis.encoding.XMLType.XSD_BOOLEAN);
			call.setUseSOAPAction(true);
			call.setSOAPActionURI(opensoapactionuri);
			
			
			infoSql = "select i.infoid,i.statusname,i.feedback,i.isovertime,t.endtime from infoopen i,taskcenter t where i.id = t.iid and i.isxd = 1 order by t.id";
			vector = dImpl.splitPage(infoSql,20,1);
			if(vector!=null){
				for(int j=0;j<vector.size();j++)
	            {
					contentEmail = (Hashtable)vector.get(j);
					infoid = CTools.dealNull(contentEmail.get("infoid"));
					statusname = CTools.dealNull(contentEmail.get("statusname"));
					feedback = CTools.dealNull(contentEmail.get("feedback"));
					isovertime = CTools.dealNull(contentEmail.get("isovertime"));
					endtime = CTools.dealNull(contentEmail.get("endtime"));
					//组织XMLS
					infoXml.append("<xml><paras>");
					infoXml.append("<rowguid>"+infoid+"</rowguid>");//第三方系统ID
					infoXml.append("<status>"+statusname+"</status>");//办理状态
					infoXml.append("<feedback>"+feedback+"</feedback>"); //回复内容
					infoXml.append("<isovertime>"+isovertime+"</isovertime>");  //是否超期
					infoXml.append("<finishtime>"+endtime+"</finishtime>");  //办理时间
					infoXml.append("</paras>");
					//调用接口
					returnXml= (String) call.invoke(new Object[] {ValidateData,infoXml} );
					returnStatus = CTools.dealNull(CASUtil.getUserColumn(returnXml, "Status")).trim();
					returnErrors = CTools.dealNull(CASUtil.getUserColumn(returnXml, "Description")).trim();
					if("True".equals(returnStatus)){
						//修改信访反馈推送状态
						dImpl.edit("infoopen", "infoid", infoid);
						dImpl.setValue("isxd","0", CDataImpl.INT);
						dImpl.update();
					}else{
						System.out.println("失败:"+CDate.getNowTime()+" InfoopenFeedback.putInfoopenFeedbackXmls   " +returnErrors);
					}
					
					
	            }
			}
			
		}catch(Exception ex){
			ex.printStackTrace();
			System.out.println("失败:"+CDate.getNowTime()+" InfoopenFeedback.putInfoopenFeedbackXmls " +ex.getMessage());
		}finally{
			dImpl.closeStmt();
			dCn.closeCn();
		}
	}
	
	public static void main(String args[]){
		InfoopenFeedback infof = new InfoopenFeedback();
		String xmls = "<?xml version=\"1.0\" encoding=\"gb2312\" ?><paras><rowguid>1</rowguid><status>测试状态</status><feedback>测试内容</feedback><isovertime>1</isovertime><finishtime >2015-12-25<finishtime/></paras>";
		infof.putInfoopenFeedbackXmls();
	}
}
