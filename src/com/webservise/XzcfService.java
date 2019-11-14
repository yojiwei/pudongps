package com.webservise;

import java.util.Hashtable;
import java.util.TimerTask;
import java.util.Vector;
import javax.xml.namespace.QName;
import org.apache.axis.client.Call;
import org.apache.axis.client.Service;
import com.component.database.CDataCn;
import com.component.database.CDataImpl;
import com.util.CDate;
import com.util.CFile;
import com.util.CTools;
import com.util.FolderFileChange;
/**
 * 推送行政处罚信息到浦东门户网站
 * @return "成功" 表示推送成功 其他表示失败
 * 接口地址 http://system.pudong.gov.cn/PubilshInfo/intergrade.asmx
 * cf_id   行政处罚ID
 * opType  add|edit|delete
 */
public class XzcfService extends TimerTask{
	/**
	 * 构造函数 
	 */
	public XzcfService(){}
	/**
	 * run方法
	 */
	public void run() {
		//手动推送
		//new XzcfService().sdpullData("222,111");
		//定时自动推送2000条
		new XzcfService().autoPullData();
	}
	
	
	/**
	 * 手动推送行政处罚信息到浦东门户网站
	 * @param ids
	 * @return
	 */
	public String sdpullData(String ids){
		String returnString="";
		CDataCn cDn=null;
		CDataImpl dImpl=null;
		Hashtable table=null;
		Vector vPage=null;
		String sql="";
		String cf_errornum="";//错误次数
		String sj_id = "";
		String cf_id = "";
		String opType = "";
		String dtCode = "";
		String returnStr="";
		try {
			cDn = new CDataCn();
			dImpl =new CDataImpl(cDn);
			
			//手动推送
			//正式接口推送参数说明
			//#门户网站信息推送webservice访问地址
			//gwendpoint=http://system.pudong.gov.cn/PubilshInfo/intergrade.asmx
			//#intergrade  opennamespaceuri
			//gwnamespaceuri=http://tempuri.org/
			//#SOAPAction
			//gwsoapactionuri=http://tempuri.org/intergrade
			//#设置外网存放此公文的栏目代码
			//gwsubjectcode=ServiceTest
			//#设置本机IP
			//gwip=192.68.0.103
			//#设置外网用户名 公文
			//gwusername=administrator
			//#设置外网用户密码 公文
			//gwpassword = 11

			WebserviceReadProperty pro = new WebserviceReadProperty();
			String gwendpoint=pro.getPropertyValue("gwendpoint");
			String gwnamespaceuri=pro.getPropertyValue("gwnamespaceuri");
			String gwsoapactionuri=pro.getPropertyValue("gwsoapactionuri");
			String gwip=pro.getPropertyValue("gwip");
			String gwusername=pro.getPropertyValue("gwusername");
			String gwpassword=pro.getPropertyValue("gwpassword");
			
			String endpoint = gwendpoint;
			
			Service service = new Service();
			Call call = (Call) service.createCall();
			call.setTargetEndpointAddress(new java.net.URL(endpoint));
			call.setOperationName(new QName(gwnamespaceuri, "intergrade"));
			call.addParameter(new QName(gwnamespaceuri,"ip"), org.apache.axis.encoding.XMLType.XSD_STRING,javax.xml.rpc.ParameterMode.IN);
			call.addParameter(new QName(gwnamespaceuri,"uid"), org.apache.axis.encoding.XMLType.XSD_STRING,javax.xml.rpc.ParameterMode.IN);
			call.addParameter(new QName(gwnamespaceuri,"password"), org.apache.axis.encoding.XMLType.XSD_STRING,javax.xml.rpc.ParameterMode.IN);
			call.addParameter(new QName(gwnamespaceuri,"xmlStr"), org.apache.axis.encoding.XMLType.XSD_STRING,javax.xml.rpc.ParameterMode.IN);
			call.setReturnType(org.apache.axis.encoding.XMLType.XSD_STRING);
			call.setUseSOAPAction(true);
			call.setSOAPActionURI(gwsoapactionuri);
			
			sql="select cf_id,cf_errornum+1 as cf_errors,cf_subjectcode,operater from tb_xzcf where issend=0 and operater is not null and cf_id in("+ids+") order by cf_id";//取出没发送成功,且推送失败次数小于3的。
			Vector vXzcfPage = dImpl.splitPage(sql,2000,1);
			if(vXzcfPage!=null){
				for(int i=0;i<vXzcfPage.size();i++){
					table = (Hashtable)vXzcfPage.get(i);
					if(table!=null){
						cf_id=CTools.dealNull(table.get("cf_id"));
						cf_errornum=CTools.dealNumber(table.get("cf_errors"));
						sj_id=CTools.dealNull(table.get("cf_subjectcode"));
						opType=CTools.dealNull(table.get("operater"));
						
						
						if(i%200==0){
							dImpl.closeStmt();
							cDn.closeCn();
							
							cDn = new CDataCn();
							dImpl =new CDataImpl(cDn);
						}
						
					///////////////////////
					cDn.beginTrans();//开启事务
					
					try{
							MessageBean mBean=null;
							mBean = getMessageBean(cf_id,sj_id,opType,dImpl);//得到实体
							if("delete".equals(opType))
								mBean.setDtCode(dtCode);
							//推送类型  add新增  edit更新 delete删除
							mBean.setOPERATER(opType);//设置推送类型  add新增  edit更新  delete删除
							
							String putXML=getXml(cf_id,mBean).toString();
							System.out.println("sdputXML========================"+putXML);
							
							//执行门户网站信息接口调用
							returnStr= (String) call.invoke(new Object[] {gwip,gwusername,gwpassword,putXML});
							returnStr = returnStr.trim();//去掉二头空格

							
							System.out.println("returnStr-------------->" + returnStr);
						
					}catch (Exception putEx) {
						System.out.println(CDate.getNowTime()+"推送出错--XzcfService.java:"+ putEx.getMessage());
						returnStr=CDate.getNowTime()+"推送出错--XzcfService.java:"+ putEx.getMessage();
					}
					
					boolean isPutSuccess =false;
					if("add".equals(opType)){
						if(isNumber(returnStr)){
							isPutSuccess=true;//如果能转换成数字,则说明推送成功
							returnStr=cf_id+opType+"成功";
						}else{
							isPutSuccess=false;//如果不能转换成数字,则说明推送失败
							returnStr=cf_id+opType+"失败";
						}
					}else if("edit".equals(opType)){
						if(isNumber(returnStr)){
							isPutSuccess=true;//如果能转换成数字,则说明推送成功
							returnStr=cf_id+opType+"成功";
						}else {
							isPutSuccess=false;//如果不能转换成数字,则说明推送失败
							returnStr=cf_id+opType+"失败";
						}
					}else if("delete".equals(opType)){
						if("".equals(returnStr)){
							isPutSuccess=true;//如果能转换成数字,则说明推送成功
							returnStr=cf_id+opType+"成功";
						}else {
							isPutSuccess=false;//如果不能转换成数字,则说明推送失败
							returnStr=cf_id+opType+"失败";
						}
					}
					
					//更新推送状态
					 dImpl.setTableName("tb_xzcf");
					 dImpl.setPrimaryFieldName("cf_id");
					 dImpl.edit("tb_xzcf","cf_id",Integer.parseInt(cf_id));
					 if(isPutSuccess){
						 dImpl.setValue("issend","1",CDataImpl.STRING);//0待推送1推送成功2推送失败
					 }else{
						 dImpl.setValue("cf_errornum",cf_errornum,CDataImpl.INT);//超过3次不再推送
					 }
					 dImpl.update();
					 

					if(cDn.getLastErrString().equals("")){
						cDn.commitTrans();//没错误提交
						returnString="成功";
					}else{
						cDn.rollbackTrans();//有错误回滚
						returnString="发生错误";
					}
					/////////////////////////
					
					
					} 
				}
			}	
					
				
			
		}catch (Exception e) {
			System.err.println(e.toString());
			returnString="发生错误"+e.toString();
		}finally{
			dImpl.closeStmt();
			cDn.closeCn();
		}
		return returnString;
	}
	
	/**
	 * 得到实体对象
	 * @param cf_id  信息主键
	 * @param sj_id 栏目主键
	 * @param dImpl 数据对象
	 * @return 返回实体对象
	 */
	private MessageBean getMessageBean(String cf_id,String sj_id,String opType,CDataImpl dImpl){
		MessageBean mBean =new MessageBean();
		if("delete".equals(opType)){
				mBean.setSUBJECTCODE(sj_id);
				mBean.setID(cf_id);
				mBean.setSUBJECTID(sj_id);
		}else{
			
			String sql="select x.cf_id,x.cf_number,x.cf_qyname,x.cf_qycode,x.cf_name,x.cf_wfss,x.cf_type_by,x.cf_lxfs_date,x.cf_deptname,to_char(x.cf_date,'yyyy-MM-dd') as cf_date,x.cf_memo,d.dt_code from tb_xzcf x,tb_deptinfo d where x.dt_id=d.dt_id and x.cf_id='"+cf_id+"'";
			//System.out.println("sql = " + sql);
			Hashtable table = dImpl.getDataInfo(sql);
			if(table!=null){
				mBean.setMessageTitle(CTools.dealNull(table.get("cf_qyname")));
				mBean.setSpecial("0");//1是特别提醒   0不是特别提醒
				mBean.setLink(CTools.dealNull(table.get("cf_name")));//链接 LINK
				mBean.setKEY(CTools.dealNull(table.get("cf_qycode")));
				mBean.setSENDDATE(CDate.getThisday());//信息推送日期即为修改日期
				mBean.setSendTime(CTools.dealNull(table.get("cf_date")));//发布日期
				//结束时间是否为空
				String ct_endtime_ = "";
				if("".equals(ct_endtime_)){
					ct_endtime_ = "2050-02-02";
				}
				mBean.setEndTime(ct_endtime_);//结束日期
				mBean.setInsertTime(CDate.getThisday());//录入日期
				mBean.setCONTENT(CTools.dealNull(table.get("cf_type_by"))+"#"+CTools.dealNull(table.get("cf_lxfs_date")));
				mBean.setSOURCE("");
				mBean.setDESCRIBE(CTools.dealNull(table.get("cf_wfss")));
				mBean.setFILECODE(CTools.dealNull(table.get("cf_number")));
				mBean.setINDEX(CTools.dealNull(table.get("cf_memo")));
				mBean.setDtCode(CTools.dealNull(table.get("dt_code")));
				
				mBean.setPUBLISH("");//公开类别
				mBean.setCARRIER("");//载体类型
				mBean.setANNAL("");//记录形式
				mBean.setSENDUNIT(CTools.dealNull(table.get("cf_deptname")));//部门名称
				mBean.setGONGWENTYPE("");//公文种类
				mBean.setSUBJECTCODE(sj_id);
				
				mBean.setID(cf_id);
				mBean.setSUBJECTID(sj_id);
			}
		}
		return mBean;
	}
	/**
	 * 组合xml
	 * @param cf_id 信息ID主键
	 * @param mBean 实体
	 * @return 返回组合xml
	 */
	private StringBuffer getXml(String cf_id,MessageBean mBean) {
		StringBuffer strB= new StringBuffer();
		strB.append("<?xml version=\"1.0\" encoding=\"utf-8\" ?>");
		strB.append("<DEP_DataExchangeData>");
		strB.append("<OperationType>消息发起</OperationType>");
		strB.append("<MessageTitle><![CDATA["+mBean.getMessageTitle().replaceAll(">", "＞").replaceAll("<", "＜")+" ]]></MessageTitle>");
		strB.append("<MessageID></MessageID>");
		strB.append("<MessageBody><ROOT><DATASEND>");
		strB.append("<OPERATER>"+mBean.getOPERATER()+"</OPERATER>");
		strB.append("<ID>"+mBean.getID()+"_"+mBean.getSUBJECTCODE()+"</ID>");//由信息ID和栏目代码组成2009-04-09
		strB.append("<FORMID>"+mBean.getFORMID()+"</FORMID>");
		strB.append("<TITLE><![CDATA["+mBean.getMessageTitle().replaceAll(">", "＞").replaceAll("<", "＜")+" ]]></TITLE>");
		strB.append("<SPECIAL>"+mBean.getSpecial()+"</SPECIAL>");//特别提醒 SPECIAL  1是特别提醒   0不是特别提醒
		strB.append("<LINK>"+mBean.getLink()+"</LINK>");//链接 LINK
		strB.append("<DEPTCODE>"+mBean.getDtCode()+"</DEPTCODE>");//部门代号
		strB.append("<FORMID>"+mBean.getFORMID()+"</FORMID>");
		strB.append("<SUBJECTID></SUBJECTID>");
		
		//注： 转换一下正文附件里的路径适合门户网站前台展示
		strB.append("<CONTENT><![CDATA["+mBean.getCONTENT().replaceAll("\"/attach/infoattach/", "\"http://www.pudong.gov.cn/UpLoadPath/PublishInfo/")+" ]]></CONTENT>");
		strB.append("<STARTTIME>"+mBean.getSendTime()+"</STARTTIME>");//发布日期
		strB.append("<ENDTIME>"+mBean.getEndTime()+"</ENDTIME>");//结束日期
		
		strB.append("<SENDTIME>"+mBean.getSENDDATE()+"</SENDTIME>");//信息更新发布日期
		strB.append("<INSERTTIME>"+mBean.getInsertTime()+"</INSERTTIME>");//信息录入日期
		
		strB.append("<SENDUNIT>"+mBean.getSENDUNIT()+"</SENDUNIT>");//部门
		strB.append("<FILECODE>"+mBean.getFILECODE()+"</FILECODE>");
		strB.append("<INDEX>"+mBean.getINDEX()+"</INDEX>");
		strB.append("<PUBLISH>"+mBean.getPUBLISH()+"</PUBLISH>");
		strB.append("<CARRIER>"+mBean.getCARRIER()+"</CARRIER>");
		strB.append("<ANNAL>"+mBean.getANNAL()+"</ANNAL>");
		//报送到浦东门户网站后台，公文种类
		strB.append("<GONGWENTYPE>"+mBean.getGONGWENTYPE()+"</GONGWENTYPE>");//公文种类
		
		strB.append("<SUBJECTCODE>"+mBean.getSUBJECTCODE()+"</SUBJECTCODE>");//栏目代码
		strB.append("<SOURCE></SOURCE>");
		strB.append("<DESCRIBE><![CDATA["+mBean.getDESCRIBE().replaceAll(">", "＞").replaceAll("<", "＜")+" ]]></DESCRIBE>");//摘要-内容描述
		strB.append("<KEY><![CDATA["+mBean.getKEY().replaceAll(">", "＞").replaceAll("<", "＜")+" ]]></KEY>");
		strB.append("<IMPORTANTFLAG>0</IMPORTANTFLAG>");
		//得到附件
		strB.append("<FILEPUBATTACH></FILEPUBATTACH>");
		//结尾
		strB.append("</DATASEND></ROOT></MessageBody>");
		strB.append("<SourceUnitCode></SourceUnitCode><SourceCaseCode></SourceCaseCode>");
		strB.append("<DestUnit><DestUnitCode></DestUnitCode><DestCaseCode></DestCaseCode><InterFaceCode></InterFaceCode></DestUnit>");
		strB.append("<Sender>"+mBean.getSender()+"</Sender>");
		strB.append("<SendTime>"+mBean.getSENDDATE()+"</SendTime>");//信息更新发布日期
		strB.append("<ENDTIME>"+mBean.getEndTime()+"</ENDTIME>");//结束日期
		strB.append("</DEP_DataExchangeData>");
		
		return strB;
	}
	
	
	/**
	 * 判断是否能转换为数字
	 * @param str
	 * @return true是可转换数字 false不可转换
	 */
	public boolean isNumber(String str){   
	      try{   
	            Integer.parseInt(str);   
	            return   true;   
	      }catch(Exception   e){   
	            return   false;   
	      }   
	}
	
	/**
	 * 自动推送行政处罚信息到门户网站
	 * @return
	 */
	public String autoPullData(){
		String returnString="";
		CDataCn cDn=null;
		CDataImpl dImpl=null;
		Hashtable table=null;
		Vector vPage=null;
		String sql="";
		String cf_errornum="";//错误次数
		String sj_id = "";
		String cf_id = "";
		String opType = "";
		String dtCode = "";
		String returnStr="";
		try {
			cDn = new CDataCn();
			dImpl =new CDataImpl(cDn);
			
			//手动推送
			//正式接口推送参数说明
			//#门户网站信息推送webservice访问地址
			//gwendpoint=http://system.pudong.gov.cn/PubilshInfo/intergrade.asmx
			//#intergrade  opennamespaceuri
			//gwnamespaceuri=http://tempuri.org/
			//#SOAPAction
			//gwsoapactionuri=http://tempuri.org/intergrade
			//#设置外网存放此公文的栏目代码
			//gwsubjectcode=ServiceTest
			//#设置本机IP
			//gwip=192.68.0.103
			//#设置外网用户名 公文
			//gwusername=administrator
			//#设置外网用户密码 公文
			//gwpassword = 11

			WebserviceReadProperty pro = new WebserviceReadProperty();
			String gwendpoint=pro.getPropertyValue("gwendpoint");
			String gwnamespaceuri=pro.getPropertyValue("gwnamespaceuri");
			String gwsoapactionuri=pro.getPropertyValue("gwsoapactionuri");
			String gwip=pro.getPropertyValue("gwip");
			String gwusername=pro.getPropertyValue("gwusername");
			String gwpassword=pro.getPropertyValue("gwpassword");
			
			String endpoint = gwendpoint;
			
			Service service = new Service();
			Call call = (Call) service.createCall();
			call.setTargetEndpointAddress(new java.net.URL(endpoint));
			call.setOperationName(new QName(gwnamespaceuri, "intergrade"));
			call.addParameter(new QName(gwnamespaceuri,"ip"), org.apache.axis.encoding.XMLType.XSD_STRING,javax.xml.rpc.ParameterMode.IN);
			call.addParameter(new QName(gwnamespaceuri,"uid"), org.apache.axis.encoding.XMLType.XSD_STRING,javax.xml.rpc.ParameterMode.IN);
			call.addParameter(new QName(gwnamespaceuri,"password"), org.apache.axis.encoding.XMLType.XSD_STRING,javax.xml.rpc.ParameterMode.IN);
			call.addParameter(new QName(gwnamespaceuri,"xmlStr"), org.apache.axis.encoding.XMLType.XSD_STRING,javax.xml.rpc.ParameterMode.IN);
			call.setReturnType(org.apache.axis.encoding.XMLType.XSD_STRING);
			call.setUseSOAPAction(true);
			call.setSOAPActionURI(gwsoapactionuri);
			
			sql="select cf_id,cf_errornum+1 as cf_errors,cf_subjectcode,operater from tb_xzcf where issend=0 and operater is not null and cf_errornum<4 order by cf_id";//取出没发送成功,且推送失败次数小于3的。
			Vector vXzcfPage = dImpl.splitPage(sql,2000,1);
			if(vXzcfPage!=null){
				for(int i=0;i<vXzcfPage.size();i++){
					table = (Hashtable)vXzcfPage.get(i);
					if(table!=null){
						cf_id=CTools.dealNull(table.get("cf_id"));
						cf_errornum=CTools.dealNumber(table.get("cf_errors"));
						sj_id=CTools.dealNull(table.get("cf_subjectcode"));
						opType=CTools.dealNull(table.get("operater"));
						
						
						if(i%200==0){
							dImpl.closeStmt();
							cDn.closeCn();
							
							cDn = new CDataCn();
							dImpl =new CDataImpl(cDn);
						}
						
						
					///////////////////////
					cDn.beginTrans();//开启事务
					
					try{
							MessageBean mBean=null;
							mBean = getMessageBean(cf_id,sj_id,opType,dImpl);//得到实体
							if("delete".equals(opType))
								mBean.setDtCode(dtCode);
							//推送类型  add新增  edit更新 delete删除
							mBean.setOPERATER(opType);//设置推送类型  add新增  edit更新  delete删除
							
							String putXML=getXml(cf_id,mBean).toString();
							System.out.println("autoputXML========================"+putXML);
							
							//CFile.write("d:\\aab.xml",putXML.toString());
							//执行门户网站信息接口调用
							returnStr= (String) call.invoke(new Object[] {gwip,gwusername,gwpassword,putXML});
							returnStr = returnStr.trim();//去掉二头空格
							
							System.out.println("returnStr-------------->" + returnStr);
						
					}catch (Exception putEx) {
						System.out.println(CDate.getNowTime()+"推送出错--XzcfService.java:"+ putEx.getMessage());
						returnStr=CDate.getNowTime()+"推送出错--XzcfService.java:"+ putEx.getMessage();
					}
					
					boolean isPutSuccess =false;
					if("add".equals(opType)){
						if(isNumber(returnStr)){
							isPutSuccess=true;//如果能转换成数字,则说明推送成功
							returnStr=cf_id+opType+"成功";
						}else{
							isPutSuccess=false;//如果不能转换成数字,则说明推送失败
							returnStr=cf_id+opType+"失败";
						}
					}else if("edit".equals(opType)){
						if(isNumber(returnStr)){
							isPutSuccess=true;//如果能转换成数字,则说明推送成功
							returnStr=cf_id+opType+"成功";
						}else {
							isPutSuccess=false;//如果不能转换成数字,则说明推送失败
							returnStr=cf_id+opType+"失败";
						}
					}else if("delete".equals(opType)){
						if("".equals(returnStr)){
							isPutSuccess=true;//如果能转换成数字,则说明推送成功
							returnStr=cf_id+opType+"成功";
						}else {
							isPutSuccess=false;//如果不能转换成数字,则说明推送失败
							returnStr=cf_id+opType+"失败";
						}
					}
					
					//更新推送状态
					 dImpl.setTableName("tb_xzcf");
					 dImpl.setPrimaryFieldName("cf_id");
					 dImpl.edit("tb_xzcf","cf_id",Integer.parseInt(cf_id));
					 if(isPutSuccess){
						 dImpl.setValue("issend","1",CDataImpl.STRING);//0待推送1推送成功2推送失败
					 }else{
						 dImpl.setValue("cf_errornum",cf_errornum,CDataImpl.INT);//超过3次不再推送
					 }
					 dImpl.update();
					 

					if(cDn.getLastErrString().equals("")){
						cDn.commitTrans();//没错误提交
						returnString="成功";
					}else{
						cDn.rollbackTrans();//有错误回滚
						returnString="发生错误";
					}
					/////////////////////////
					
					
					} 
				}
			}	
					
				
			
		}catch (Exception e) {
			System.err.println(e.toString());
			returnString="发生错误"+e.toString();
		}finally{
			dImpl.closeStmt();
			cDn.closeCn();
		}
		return returnString;
	}
	
	//Main方法
	public static void main(String args[]){
		XzcfService xzcf = new XzcfService();
		xzcf.autoPullData();
	}
	

	
}
