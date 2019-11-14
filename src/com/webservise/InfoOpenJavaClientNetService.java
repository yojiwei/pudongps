package com.webservise;

import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.Hashtable;
import java.util.Vector;

import org.apache.axis.client.Call;
import org.apache.axis.client.Service;
import org.apache.taglibs.standard.lang.jstl.test.Bean1;

import com.component.database.CDataCn;
import com.component.database.CDataImpl;
import com.util.CDate;
import com.util.CTools;

import javax.xml.namespace.QName;

/**
 * java调用.netwebservice
 * 调用门户网站上依申请公开接口抓取数据到公文备案依申请公开处理系统
 * 公文备案系统27 设置监听器定时执行
 * @version1.0
 */
public class InfoOpenJavaClientNetService {

	private String keyId="";//接收信息主键ID
	//private boolean isBreak=false;//判断是否有数据
	public InfoOpenJavaClientNetService() {

	}
	public static void main(String[] args) {
		InfoOpenJavaClientNetService aa = new InfoOpenJavaClientNetService();
		aa.getInfoOpenData();//得到门户网公开信息申请
		//aa.putInfoMessage();//公开信息回复推送
	}
	
	/**
	 * 调用门户网站上依申请公开接口抓取数据到公文备案依申请公开处理系统
	 * @return 空成功 其他失败
	 */
	public String getInfoOpenData(){
		String returnString="";
		boolean result = false;
		CDataCn dCn = null;
		CDataImpl dImpl = null;
		try{
			dCn = new CDataCn();
			dImpl = new CDataImpl(dCn);
			
			WebserviceReadProperty pro = new WebserviceReadProperty();
			String openendpoint=pro.getPropertyValue("openendpoint");
			String opennamespaceuri=pro.getPropertyValue("opennamespaceuri");
			String opensoapactionuri=pro.getPropertyValue("opensoapactionuri");
			
			String endpoint = "http://usercenter.pudong.gov.cn/axis/services/applyopenservice?wsdl";//本地
			//String endpoint = openendpoint;//外网
			Service service = new Service();
			Call call = (Call) service.createCall();
			call.setTargetEndpointAddress(new java.net.URL(endpoint));

			call.setOperationName(new QName(opennamespaceuri, "sendXmls"));
			call.addParameter(new QName(opennamespaceuri,"username"), org.apache.axis.encoding.XMLType.XSD_STRING,javax.xml.rpc.ParameterMode.IN);
			call.addParameter(new QName(opennamespaceuri,"password"), org.apache.axis.encoding.XMLType.XSD_STRING,javax.xml.rpc.ParameterMode.IN);
			
			call.setReturnType(org.apache.axis.encoding.XMLType.XSD_STRING);
			call.setUseSOAPAction(true);
			call.setSOAPActionURI(opensoapactionuri);
			
			String username=pro.getPropertyValue("openusername");
			String password=pro.getPropertyValue("openpassword");
			String returnXml = "";
			
			for(int i=0;i<50;i++){//每次读50条
				returnXml= (String) call.invoke(new Object[] {username,password} );

				//判断有没有数据可以调用
				if("".equals(returnXml)){
					return returnString;
				}
				//返回boolean值result：true插入公文备案数据库成功false插入数据库失败或者没有数据提供调用 keyId全局变量
				result = callEntity(returnXml);

				if(result){
					dImpl.setTableName("infoopenlog");
					dImpl.setPrimaryFieldName("id");
					dImpl.addNew();
					if(keyId.equals(""))keyId="-100";//表示没此ID,或没接收到门户中的ID
					dImpl.setValue("keyid",keyId,CDataImpl.INT);//门户系统里的信息主键
					dImpl.setValue("msg","插入成功 "+CDate.getNowTime()+" InfoOpenJavaClientNetService.getInfoOpenData ",CDataImpl.STRING);//门户系统里的信息主键
					dImpl.update();
					//调用通知成功方法——将反馈依申请公开处理状态推送到门户网站
					tealMessage("true",dImpl);
					System.out.println("插入成功 "+CDate.getNowTime()+" InfoOpenJavaClientNetService.getInfoOpenData ");
				}else{
					//判断是否有数据提供调用
					
					//调用通知失败方法——将反馈依申请公开处理状态推送到门户网站
					tealMessage("false",dImpl);
					System.out.println("插入失败 "+CDate.getNowTime()+" InfoOpenJavaClientNetService.getInfoOpenData ");
					break;
				}
			}
			
			
		}catch (Exception e) {
			System.err.println(e.toString());
			returnString="发生错误"+e.toString();
		}finally{
		dImpl.closeStmt();
		dCn.closeCn(); 
		}
		return returnString;
	}
	/**
	 * 用户webService 并将XML插入本地数据库
	 * @param call
	 * @param returnXml 调用依申请公开的XML
	 * @return true插入成功 false插入失败
	 */
	public boolean callEntity(String returnXml) {
		String returnString = "";
		try{
		InfoOpenParseXml infoOpenParseXml = new InfoOpenParseXml();
		//去插入公文备案数据库返回returnString正常返回信息主键ID，异常返回错误报错信息
		returnString = infoOpenParseXml.getInfoOpenXML(returnXml).trim();
		if(isNumber(returnString)){//能转换成数字表示成功
			keyId=returnString;//记录调用系统里的信息主键ID
			return true;
		}else{
			String tempReturnXMl = "";
			if(returnXml.indexOf("</messgaeid>")!=-1){
				tempReturnXMl=returnXml.substring(0,returnXml.indexOf("</messgaeid>"));
				if(returnXml.indexOf("<messgaeid>")!=-1){
					tempReturnXMl=tempReturnXMl.substring(returnXml.indexOf("<messgaeid>")+11);
				}
			}
			if(isNumber(tempReturnXMl)){
				keyId=tempReturnXMl.trim();//从XML中取得ID，返回给对方
			}else keyId="-100";//表示没此ID,或没接收到门户中的ID
			return false;
		}
		}catch (Exception e) {
			System.out.println("失败:"+CDate.getNowTime()+" InfoOpenJavaClientNetService.callEntity " +e.getMessage());
			return false;
		}
	}
	
	/**
	 * 判断是否能转换为数字
	 * @param str
	 * @return
	 */
	public boolean isNumber(String str){   
	      try{   
	            Integer.parseInt(str.trim());   
	            return   true;   
	      }catch(Exception   e){   
	            return   false;   
	      }   
	  }
	
	/**
	 * 调用门户网站上依申请公开接口反馈依申请公开处理结果状态
	 * 调用成功返回true 失败返回false
	 */
	public boolean webServiceError(String keyId,String ok){
			try {
				WebserviceReadProperty pro = new WebserviceReadProperty();
				String openendpoint=pro.getPropertyValue("open2endpoint");
				String opennamespaceuri=pro.getPropertyValue("open2namespaceuri");
				String opensoapactionuri=pro.getPropertyValue("open2soapactionuri");
				
				String open2username=pro.getPropertyValue("openusername");
				String open2password=pro.getPropertyValue("openpassword");
				
				String endpoint = "http://usercenter.pudong.gov.cn/axis/services/applyopenservice?wsdl";//本地
//				String endpoint = openendpoint;//外网
				Service service = new Service();
				Call call = (Call) service.createCall();
				call.setTargetEndpointAddress(new java.net.URL(endpoint));

				call.setOperationName(new QName(opennamespaceuri, "updateStatus"));
				call.addParameter(new QName(opennamespaceuri,"id"), org.apache.axis.encoding.XMLType.XSD_STRING,javax.xml.rpc.ParameterMode.IN);
				call.addParameter(new QName(opennamespaceuri,"username"), org.apache.axis.encoding.XMLType.XSD_STRING,javax.xml.rpc.ParameterMode.IN);
				call.addParameter(new QName(opennamespaceuri,"password"), org.apache.axis.encoding.XMLType.XSD_STRING,javax.xml.rpc.ParameterMode.IN);
				call.addParameter(new QName(opennamespaceuri,"status"), org.apache.axis.encoding.XMLType.XSD_STRING,javax.xml.rpc.ParameterMode.IN);
				call.setReturnType(org.apache.axis.encoding.XMLType.XSD_BOOLEAN);//返回的是布尔值
				call.setUseSOAPAction(true);
				call.setSOAPActionURI(opensoapactionuri);
				//调用浦东门户网站依申请公开接口updateStatus方法返回boolean值returnMsg true修改浦东数据库成功、false修改浦东数据库失败
				Boolean returnMsg= (Boolean) call.invoke(new Object[] { keyId, open2username,open2password,ok} );
				if(returnMsg.booleanValue())
					return true;//true返回成功
			}catch (Exception e) {
				System.out.println("失败:"+CDate.getNowTime()+" InfoOpenJavaClientNetService.webServiceError " +e.getMessage());
				return false;
			}
			return false;
	}
	/**
	 * 日志记录
	 * ok值为true 或false 告诉四次调用失败 都不成功,;不再告诉;退出此for
	 * @param ok "true"调用成功"、"false"调用失败
	 * @param dImpl
	 * @return
	 */
	public boolean tealMessage(String ok,CDataImpl dImpl ){
		int thisErrorNum=0;
		boolean telError=false;
		for(int j=0;j<5;j++){
			telError=false;
			//调用浦东接口updateStatus方法将反馈依申请处理状态推送到门户网站
			telError = webServiceError(keyId,ok);//调用通知webService的方法
			
			if(telError){
				dImpl.setTableName("infoopenlog");
				dImpl.setPrimaryFieldName("id");
				dImpl.addNew();
				if(keyId.equals(""))keyId="-100";//表示没此ID,或没接收到门户中的ID
				dImpl.setValue("keyid",keyId,CDataImpl.INT);//门户系统里的信息主键
				dImpl.setValue("errornum",String.valueOf(thisErrorNum),CDataImpl.INT);//通知错误次数
				dImpl.setValue("msg","插入成功 "+CDate.getNowTime()+" InfoOpenJavaClientNetService.tealMessage ",CDataImpl.STRING);//门户系统里的信息主键
				dImpl.update();
				break;//成功退出此for
			}else thisErrorNum=thisErrorNum+1;
			
			if(thisErrorNum>4){//告诉四次调用失败 都不成功,;不再告诉;退出此for
				dImpl.setTableName("infoopenlog");
				dImpl.setPrimaryFieldName("id");
				dImpl.addNew();
				if(keyId.equals(""))keyId="-100";//表示没此ID,或没接收到门户中的ID
				dImpl.setValue("keyid",keyId,CDataImpl.INT);//门户系统里的信息主键
				dImpl.setValue("errornum",String.valueOf(thisErrorNum),CDataImpl.INT);//通知错误次数
				dImpl.setValue("msg","插入失败 "+CDate.getNowTime()+" InfoOpenJavaClientNetService.tealMessage ",CDataImpl.STRING);//门户系统里的信息主键
				dImpl.update();
			}
		}
		return telError;
	}
	
	/**
	 * 定时把依申请公开处理结果的信息推送到门户
	 * @return
	 */
	public boolean putInfoMessage(){
		CDataCn dCn = null;
		CDataImpl dImpl = null;
		Vector vPage=null;
		Hashtable table=null;
		try{
			dCn = new CDataCn();
			dImpl = new CDataImpl(dCn);
			
			WebserviceReadProperty pro = new WebserviceReadProperty();
			String openendpoint=pro.getPropertyValue("openendpoint");
			String opennamespaceuri=pro.getPropertyValue("opennamespaceuri");
			String opensoapactionuri=pro.getPropertyValue("opensoapactionuri");
			
			String endpoint = "http://usercenter.pudong.gov.cn/axis/services/applyopenservice?wsdl";
//			String endpoint = openendpoint;//外网
			Service service = new Service();
			Call call = (Call) service.createCall();
			call.setTargetEndpointAddress(new java.net.URL(endpoint));

			call.setOperationName(new QName(opennamespaceuri, "getXmls"));
			call.addParameter(new QName(opennamespaceuri,"getXmls"), org.apache.axis.encoding.XMLType.XSD_STRING,javax.xml.rpc.ParameterMode.IN);
			call.addParameter(new QName(opennamespaceuri,"username"), org.apache.axis.encoding.XMLType.XSD_STRING,javax.xml.rpc.ParameterMode.IN);
			call.addParameter(new QName(opennamespaceuri,"password"), org.apache.axis.encoding.XMLType.XSD_STRING,javax.xml.rpc.ParameterMode.IN);
			
			call.setReturnType(org.apache.axis.encoding.XMLType.XSD_BOOLEAN);
			call.setUseSOAPAction(true);
			call.setSOAPActionURI(opensoapactionuri);
			
			String sql="select checktype,isovertime,dealmode,id,infoid as messgaeid,did as did,step as step,status as status,to_char(finishtime,'yyyy-mm-dd')as applytime,flownum,lastmessage as reback,status_name from infoopen where infoid is not null and sender='浦东门户' and putstatus!=6 and putstatus!=7 and putstatus!=4 and flownum is not null and status_name is not null order by id";
			vPage = dImpl.splitPage(sql, 1000,1);
			if(vPage!=null){
				for(int i=0;i<vPage.size();i++){
					table=(Hashtable)vPage.get(i);
					System.out.println("infoid = " + table.get("messgaeid"));
					
					String msgID=CTools.dealNull(table.get("id"));
					
					putInfoMessageBean putbean = new putInfoMessageBean();
					putbean.setStatus(CTools.dealNull(table.get("status")));
					putbean.setStep(CTools.dealNull(table.get("step")));
					putbean.setReback(CTools.dealNull(table.get("reback")));
					putbean.setMessgaeid(CTools.dealNull(table.get("messgaeid")));
					
					putbean.setFlownum(CTools.dealNull(table.get("flownum")));
					putbean.setDeptname(CTools.dealNull(table.get("deptname")));
					putbean.setApplytime(CTools.dealNull(table.get("applytime")));
					
					putbean.setChecktype(CTools.dealNull(table.get("checktype")));
					putbean.setIsovertime(CTools.dealNull(table.get("isovertime")));
					putbean.setDealmode(CTools.dealNull(table.get("dealmode")));
					
					putbean.setStatus_name(CTools.dealNull(table.get("status_name")));
					
					String sql1="select dt_code,dt_name from tb_deptinfo where dt_id='"+CTools.dealNull(table.get("did"))+"'" ;
					Hashtable intable = dImpl.getDataInfo(sql1);
					if(intable!=null){
						putbean.setDeptcode(CTools.dealNull(intable.get("dt_code")));
						putbean.setDeptname(CTools.dealNull(intable.get("dt_name")));
					}
					
					boolean re = pudEntity(call,putbean);
					if(re){
						sql="update infoopen set putstatus=6 where id='"+msgID+"'";
						dImpl.executeUpdate(sql);
					}else{
						sql="update infoopen set putstatus=putstatus+1 where id='"+msgID+"'";//错误次数加一
						dImpl.executeUpdate(sql);
					}
				}
			}
		}catch (Exception e) {
			System.out.println("失败:"+CDate.getNowTime()+" InfoOpenJavaClientNetService.putInfoMessage " +e.getMessage());
			
		}finally{
			dImpl.closeStmt();
			dCn.closeCn(); 
		}
		return true;
	}
	
	/***
	 * 组装XMLS
	 * @param call
	 * @param putbean
	 * @return
	 */
	public boolean pudEntity(Call call,putInfoMessageBean putbean) {
		try{
			WebserviceReadProperty pro = new WebserviceReadProperty();
			
			String username=pro.getPropertyValue("openusername");
			String password=pro.getPropertyValue("openpassword");
			
			String xml="<?xml version=\"1.0\" encoding=\"GBK\" ?>";
			xml=xml+"<infoopen>";
			xml=xml+"<messgaeid>"+putbean.getMessgaeid()+"</messgaeid>";
			xml=xml+"<fdcode>"+putbean.getDeptcode()+"</fdcode>";
			xml=xml+"<fdname>"+putbean.getDeptname()+"</fdname>";
			xml=xml+"<status>"+putbean.getStatus()+"</status>";
			xml=xml+"<step>"+putbean.getStep()+"</step>";
			xml=xml+"<finishtime>"+putbean.getApplytime()+"</finishtime>";
			//xml=xml+"<flownum>"+putbean.getFlownum()+"</flownum>";
			xml=xml+"<feedback>"+putbean.getReback()+"</feedback>";
			
			xml=xml+"<checktype>"+putbean.getChecktype()+"</checktype>";
			xml=xml+"<dealmode>"+putbean.getStatus()+"</dealmode>";
			xml=xml+"<isovertime>"+putbean.getIsovertime()+"</isovertime>";
			xml=xml+"<statusname>"+putbean.getStatus_name()+"</statusname>";
			
			xml=xml+"</infoopen>";
			
			Boolean returnXml= (Boolean) call.invoke(new Object[] {xml,username,password} );
			
			return returnXml.booleanValue();//true返回成功 false失败
		}catch (Exception e) {
			return false;
		}
	}
}
