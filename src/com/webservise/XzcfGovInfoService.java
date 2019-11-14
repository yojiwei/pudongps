package com.webservise;

import java.net.URL;
import java.util.Hashtable;
import java.util.TimerTask;
import java.util.Vector;
import javax.xml.namespace.QName;
import org.apache.axis.client.Call;

import org.codehaus.xfire.XFireFactory;
import org.codehaus.xfire.client.Client;
import org.codehaus.xfire.client.XFireProxyFactory;
import org.codehaus.xfire.service.Service;
import org.codehaus.xfire.service.binding.ObjectServiceFactory;

import com.component.database.CDataCn;
import com.component.database.CDataImpl;
import com.util.CDate;
import com.util.CFile;
import com.util.CTools;
/**
 * 推送给浦东新区政府行政处罚系统
 * @return "成功" 表示推送成功 其他表示失败
 * 接口地址 http://172.18.206.142:8806/web/services/IGetServicesWSImp
 */
public class XzcfGovInfoService{// extends TimerTask
	/**
	 * 构造函数
	 */
	public XzcfGovInfoService(){} 
	/**
	 * run方法
	 */
	/*public void run() {
		//自动同步，每次一条
		//new XzcfGovInfoService().pullData();
		//手动同步
		new XzcfGovInfoService().sdPullData();
	}*/
	/**
	 * 推送给浦东新区政府行政处罚系统
	 * @return "成功" 表示推送成功 其他表示失败
	 * 接口地址 http://172.18.206.142:8806/web/services/IGetServicesWSImp
	 */
	public String pullData(){
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
			
			//正式接口推送参数说明
			//xzcfendpoint=http://172.18.206.142:8806/web/services/IGetServicesWSImp

			WebserviceReadProperty pro = new WebserviceReadProperty();
			String gwendpoint=pro.getPropertyValue("xzcfendpoint");
			String endpoint = gwendpoint;

			//使用xfire调用
			Service xzcfservice = new ObjectServiceFactory().create(IGetServicesWS.class);  
	        XFireProxyFactory factory = new XFireProxyFactory(XFireFactory  
	                .newInstance().getXFire());  
	        IGetServicesWS helloService = (IGetServicesWS) factory.create(xzcfservice,endpoint);

			
			sql="select * from (select cf_id,cf_errornumgov+1 as cf_errors,cf_subjectcode,operater from tb_xzcf where issendgov=0 and operater is not null and cf_errornumgov<4 order by cf_id) where rownum = 1";//取出没发送成功,且推送失败次数小于3的。
			table = dImpl.getDataInfo(sql);
			if(table!=null){
				cf_id=CTools.dealNull(table.get("cf_id"));
				cf_errornum=CTools.dealNumber(table.get("cf_errors"));
				sj_id=CTools.dealNull(table.get("cf_subjectcode"));
				opType=CTools.dealNull(table.get("operater"));
			
				
					//开启事务
					cDn.beginTrans();
					//调用接口推送
					try{
							MessageBean mBean=null;
							mBean = getMessageBean(cf_id,sj_id,opType,dImpl);//得到实体
							if("delete".equals(opType))
								mBean.setDtCode(dtCode);
							//推送类型  add新增  edit更新 delete删除
							mBean.setOPERATER(opType);//设置推送类型  add新增  edit更新  delete删除
							
							String putXML=getXml(cf_id,mBean).toString();
							//执行门户网站信息接口调用
							returnStr = helloService.insertData(putXML);
							returnStr = returnStr.trim();//去掉二头空格
							//CFile.write("E:\\govsaab.xml",putXML.toString()+"returnStr-------------->" + returnStr);
							System.out.println("returnGovStr-------------->" + returnStr);
						
					}catch (Exception putEx) {
						System.out.println(CDate.getNowTime()+"推送出错--JavaClientNetService.java:"+ putEx.getMessage());
						returnStr=CDate.getNowTime()+"推送出错--JavaClientNetService.java:"+ putEx.getMessage();
					}
					
					

					//更新推送状态
					 dImpl.setTableName("tb_xzcf");
					 dImpl.setPrimaryFieldName("cf_id");
					 dImpl.edit("tb_xzcf","cf_id",Integer.parseInt(cf_id));
					 if("1".equals(returnStr)){
						 dImpl.setValue("issendgov","1",CDataImpl.STRING);//0待推送1推送成功2推送失败
					 }else if("0".equals(returnStr)){
						 dImpl.setValue("cf_errornumgov",cf_errornum,CDataImpl.INT);//超过3次不再推送
					 }else{
						 System.out.println("XzcfGovXML===========无数据推送=============");
					 }
					 dImpl.update();
					 
					 //事务提交
					if(cDn.getLastErrString().equals("")){
						cDn.commitTrans();//没错误提交
						returnString="成功";
					}else{
						cDn.rollbackTrans();//有错误回滚
						returnString="发生错误"; 
					}
					
			}else{
				System.out.println("========暂时没有数据需要同步=========");
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
	 * 手动推送到政务行政处罚平台数据
	 * @return
	 */
	public String sdPullData(){
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
			
			//正式接口推送参数说明
			//xzcfendpoint=http://172.18.206.142:8806/web/services/IGetServicesWSImp

			WebserviceReadProperty pro = new WebserviceReadProperty();
			String gwendpoint=pro.getPropertyValue("xzcfendpoint");
			String endpoint = gwendpoint;

			//使用xfire调用
			Service xzcfservice = new ObjectServiceFactory().create(IGetServicesWS.class);  
	        XFireProxyFactory factory = new XFireProxyFactory(XFireFactory  
	                .newInstance().getXFire());  
	        IGetServicesWS helloService = (IGetServicesWS) factory.create(xzcfservice,endpoint);

	        System.out.println("endpoint=="+endpoint);
			 
			//sql="select cf_id,cf_errornumgov+1 as cf_errors,cf_subjectcode,operater from tb_xzcf where issendgov=0 and operater is not null and cf_errornumgov<4 order by cf_id";//取出没发送成功,且推送失败次数小于3的。
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
						
					////////////////////////////////////	
					//开启事务
					cDn.beginTrans();
					//调用接口推送
					try{
							MessageBean mBean=null;
							mBean = getMessageBean(cf_id,sj_id,opType,dImpl);//得到实体
							if("delete".equals(opType))
								mBean.setDtCode(dtCode);
							//推送类型  add新增  edit更新 delete删除
							mBean.setOPERATER(opType);//设置推送类型  add新增  edit更新  delete删除
							
							String putXML=getXml(cf_id,mBean).toString();
							//执行门户网站信息接口调用
							returnStr = helloService.insertData(putXML);
							returnStr = returnStr.trim();//去掉二头空格
							//CFile.write("E:\\govsaab.xml",putXML.toString()+"returnStr-------------->" + returnStr);
							System.out.println("returnGovStr-------------->" + returnStr);
						
					}catch (Exception putEx) {
						System.out.println(CDate.getNowTime()+"推送出错--JavaClientNetService.java:"+ putEx.getMessage());
						returnStr=CDate.getNowTime()+"推送出错--JavaClientNetService.java:"+ putEx.getMessage();
					}
					
					

					//更新推送状态
					 dImpl.setTableName("tb_xzcf");
					 dImpl.setPrimaryFieldName("cf_id");
					 dImpl.edit("tb_xzcf","cf_id",Integer.parseInt(cf_id));
					 if("1".equals(returnStr)){
						 dImpl.setValue("issendgov","1",CDataImpl.STRING);//0待推送1推送成功2推送失败
					 }else if("0".equals(returnStr)){
						 dImpl.setValue("cf_errornumgov",cf_errornum,CDataImpl.INT);//超过3次不再推送
					 }else{
						 System.out.println("XzcfGovXML===========无数据推送=============");
					 }
					 dImpl.update();
					 
					 //事务提交
					if(cDn.getLastErrString().equals("")){
						cDn.commitTrans();//没错误提交
						returnString="成功";
					}else{
						cDn.rollbackTrans();//有错误回滚
						returnString="发生错误";
					}
					
					///////////////////////////////////

					}
				}
				
					
			}else{
				System.out.println("========暂时没有数据需要同步=========");
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
				mBean.setID(cf_id);
				mBean.setMessageTitle(CTools.dealNull(table.get("cf_qyname")));//违法企业名称或违法自然人姓名
				mBean.setLink(CTools.dealNull(table.get("cf_name")));//法定代表人姓名
				mBean.setKEY(CTools.dealNull(table.get("cf_qycode")));//违法企业组织机构代码
				mBean.setSendTime(CTools.dealNull(table.get("cf_date")));//处罚日期
				mBean.setCONTENT(CTools.dealNull(table.get("cf_type_by")));//行政处罚的种类和依据
				mBean.setSOURCE(CTools.dealNull(table.get("cf_lxfs_date")));//行政处罚的履行方式和期限
				mBean.setDESCRIBE(CTools.dealNull(table.get("cf_wfss")));//主要违法事实
				mBean.setFILECODE(CTools.dealNull(table.get("cf_number")));//行政处罚决定书文号
				mBean.setINDEX(CTools.dealNull(table.get("cf_memo")));//备注
				mBean.setDtCode(CTools.dealNull(table.get("dt_code")));//部门代号
				mBean.setSENDUNIT(CTools.dealNull(table.get("cf_deptname")));//部门名称
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
		strB.append("<root>");
		strB.append("<DEP_DataExchangeData>");
		strB.append("<OPERATER>"+mBean.getOPERATER()+"</OPERATER>");
		strB.append("<MESSAGEID>"+mBean.getID()+"</MESSAGEID>");
		strB.append("<DEPTCODE>"+mBean.getSENDUNIT()+"</DEPTCODE>"); 
		strB.append("<FILENUM>"+mBean.getFILECODE()+"</FILENUM>");
		strB.append("<WFQY><![CDATA["+mBean.getMessageTitle().replaceAll(">", "＞").replaceAll("<", "＜")+" ]]></WFQY>");
		strB.append("<WFQYCODE><![CDATA["+mBean.getKEY().replaceAll(">", "＞").replaceAll("<", "＜")+" ]]></WFQYCODE>");
		strB.append("<CFNAME>"+mBean.getLink()+"</CFNAME>");
		strB.append("<WFSS><![CDATA["+mBean.getDESCRIBE().replaceAll(">", "＞").replaceAll("<", "＜")+" ]]></WFSS>");
		strB.append("<CFZL_BY><![CDATA["+mBean.getCONTENT().replaceAll("\"/attach/infoattach/", "\"http://www.pudong.gov.cn/UpLoadPath/PublishInfo/")+" ]]></CFZL_BY>");
		strB.append("<LXFS_QX><![CDATA["+mBean.getSOURCE().replaceAll(">", "＞").replaceAll("<", "＜")+" ]]></LXFS_QX>");
		strB.append("<CFDATE>"+mBean.getSendTime()+"</CFDATE>");
		strB.append("<MEMO>"+mBean.getINDEX()+"</MEMO>"); 
		strB.append("</DEP_DataExchangeData>");
		strB.append("</root>");
				
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
	 * main
	 */
	public static void main(String args[]) {
		XzcfGovInfoService xzcfservice = new XzcfGovInfoService();
		//自动同步，每次一条
		//xzcfservice.pullData();
		//手动同步
		xzcfservice.sdPullData();
	}

	
}
