package com.smsCase;

import java.util.Date;
import java.rmi.RemoteException;
import java.text.DateFormat;
import org.apache.axis.client.Call;
import org.apache.axis.client.Service;
import org.apache.axis.utils.Options;

import javax.xml.namespace.QName;
import java.lang.Integer;
import javax.xml.rpc.ParameterMode;

public class DxpdQTestService {
	/**
	 * axis方式调用webservice
	 * 
	 * @return
	 */
	public String getResultService() {
		String result = "";
		try {
			// WebService URL
			String service_url = "http://sms.pudong.sh/SmsWebservice/SendSmsService.asmx";

			Service service = new Service();
			Call call = (Call) service.createCall();
			call.setTargetEndpointAddress(new java.net.URL(service_url));
			String phoneNumberList = "15000661517,13501952977";
			String contentStr = "测试内容,请勿回复！";
			String PassWord = "PudongSendSms";

			call.setOperationName(new QName("http://tempuri.org/", "SendSms"));
			call.removeAllParameters();
			call.addParameter(new QName("http://tempuri.org/","phoneNumberList"),
					org.apache.axis.encoding.XMLType.XSD_STRING,
					ParameterMode.IN);
			call.addParameter(new QName("http://tempuri.org/", "contentStr"),
					org.apache.axis.encoding.XMLType.XSD_STRING,
					ParameterMode.IN);
			call.addParameter(new QName("http://tempuri.org/", "PassWord"),
					org.apache.axis.encoding.XMLType.XSD_STRING,
					ParameterMode.IN);
			call.setReturnType(org.apache.axis.encoding.XMLType.XSD_STRING);
			call.setUseSOAPAction(true);
			call.setSOAPActionURI("http://tempuri.org/SendSms");

			try {
				result = (String) call.invoke(new Object[] { phoneNumberList,
						contentStr, PassWord });
			} catch (RemoteException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

		} catch (Exception e) {
			System.err.println(e);
		}
		return result; 
	}

	/**
	 * main
	 * 
	 * @param args
	 */
	public static void main(String args[]) {
		DxpdQTestService dqts = new DxpdQTestService();
		System.out.println("返回值=========" + dqts.getResultService());

	}
}
