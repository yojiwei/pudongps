package com.emailService;

import java.rmi.RemoteException;

import org.apache.axis.client.Call; 
import org.apache.axis.client.Service;
import javax.xml.namespace.QName;

public class TestServer {
	
	Service service = null;
	Call call = null;	
	
	public TestServer() {
		System.out.println("======测试信访邮件接口开始======");
		String request="<XML><DEPTINFO><DEPTUSER>xfb_01</DEPTUSER><DEPTPASSWORD>1</DEPTPASSWORD></DEPTINFO></XML>";
		String strRtn="";
		try {
			service = new Service();
			call = (Call)service.createCall();
			String url = "http://31.6.130.122/axis/services/emailservice?wsdl";
			System.out.println("信访邮件接口服务地址：" + url);
			call.setTargetEndpointAddress(url);
		} catch (Exception e) {
			System.err.println(e.getLocalizedMessage());
		}
        //设置要调用的方法	 lhq 测试使用	
		call.setOperation("getEmails");
		call.setOperationName(new QName("http://schemas.xmlsoap.org/wsdl/", "getEmails"));
		//设置方法传入的参数（命名空间，参数类型，输入输出模式）
		//call.addParameter(new QName("http://result.server.egova.com.cn", "spID"), org.apache.axis.encoding.XMLType.XSD_STRING, javax.xml.rpc.ParameterMode.IN);
		//call.addParameter(new QName("http://result.server.egova.com.cn", "spWD"), org.apache.axis.encoding.XMLType.XSD_STRING, javax.xml.rpc.ParameterMode.IN);
		call.addParameter(new QName("http://schemas.xmlsoap.org/wsdl/", "requst"), org.apache.axis.encoding.XMLType.XSD_STRING, javax.xml.rpc.ParameterMode.IN);
	    //方法的返回类型		
		call.setReturnType(org.apache.axis.encoding.XMLType.XSD_STRING);
		call.setUseSOAPAction(true);
		call.setSOAPActionURI("http://schemas.xmlsoap.org/wsdl/getEmails");
		try {
			System.out.println("------------success---------");
			strRtn = call.invoke(new Object[]{request}).toString();
			
		} catch (RemoteException e) {
			e.printStackTrace();
		}
		System.out.println("strRtn="+strRtn);
		
		System.out.println("======测试信访邮件接口结束======");
	}
	
	public static void main(String[] args) {
		TestServer test = new TestServer();
	}
}
