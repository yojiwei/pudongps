package com.webservise;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.net.URLDecoder;
import java.util.Hashtable;
import java.util.Vector;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.xml.namespace.QName;

import org.apache.axis.client.Call;
import org.apache.axis.client.Service;

import com.component.database.CDataCn;
import com.component.database.CDataImpl;
import com.util.CBase64;
import com.util.CDate;
import com.util.CFile;
import com.util.CTools;

/**
 * java调用.netwebservice
 * @author shi
 * @version1.0
 * http://system.pudong.gov.cn/PubilshInfo/intergrade.asmx
 *
 */
public class JavaClientNetService {
	/** 
	 * 构造函数
	 */
	public JavaClientNetService() {

	}
	/**
	 * main方法
	 * @param args
	 */
	public static void main(String[] args) {
		JavaClientNetService aa = new JavaClientNetService();
		String aabb = "430199";
		//aa.putLocalData("42","2012-10-12","2012-11-12","290942");//dt_id,starttime,endtime,id
		aa.putLocalData("","","",aabb);//putLocalData(String dt_id,String startTime,String endTime,String id)
		//aa.isNumber(" ");
		//aa.putData();
	}
	
	private String thisSql="";
	/**
	 * 正式推送公文备案信息到门户网站 主方法
	 * @return "成功" 表示推送成功 其他表示失败
	 * 接口地址 http://system.pudong.gov.cn/PubilshInfo/intergrade.asmx
	 */
	public String putData(){
		String returnString="";
		CDataCn cDn=null;
		CDataImpl dImpl=null;
		Hashtable table=null;
		Vector vPage=null;
		String sql="";
		String ct_id="";
		String sj_id="";
		String cm_id="";//推送表主键
		String cm_type="";//推送类型
		String cm_errornum="";//错误次数
		String dtCode = "";
		String returnStr="";
		String retr = "";
		try {
			cDn = new CDataCn();
			dImpl =new CDataImpl(cDn);
			
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
			String gwsubjectcode=pro.getPropertyValue("gwsubjectcode");
			String gwip=pro.getPropertyValue("gwip");
			String gwusername=pro.getPropertyValue("gwusername");
			String gwpassword=pro.getPropertyValue("gwpassword");
			String errorsavepath9 = pro.getPropertyValue("errorsavepath");
			
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
			
			sql="select cm_id,cm_type,ct_id,sj_id,(cm_errornum+1) as cm_errornum,cm_dtcode from tb_contentmessage where nvl(cm_result,0)!=1 and cm_errornum<5 order by cm_id asc";//取出没发送成功,但失败次数小于5的记录
			
			if(!getThisSql().equals(""))
				sql=getThisSql();//只取一条
			System.out.println("sql-----------------------"+sql);
			vPage = dImpl.splitPage(sql, 3000,1);//最多取5000条
			if(vPage!=null){
				for(int i=0;i<vPage.size();i++){
					table =(Hashtable)vPage.get(i);
					cm_id=CTools.dealNull(table.get("cm_id"));
					ct_id=CTools.dealNull(table.get("ct_id"));
					sj_id=CTools.dealNull(table.get("sj_id"));//栏目代码
					
					dtCode = CTools.dealNull(table.get("cm_dtcode"));
					//不予公开就不用同步到门户网站了，直接将同步次数变为5
					cm_errornum=CTools.dealNull(table.get("cm_errornum"));
					if("newgovOpen_ZFJS_bygk".equals(sj_id)){
						cm_errornum = "5";
					}
					cm_type=CTools.dealNull(table.get("cm_type"));
					if(cm_type.equals("1"))cm_type="add";
					else if(cm_type.equals("2"))cm_type="edit";
					else if(cm_type.equals("3"))cm_type="delete";
					
					//批量处理重建数据库链接
					if(i%200 == 0){
						dImpl.closeStmt();
						cDn.closeCn();
						
						cDn = new CDataCn();
						dImpl =new CDataImpl(cDn);
					}
					
					cDn.beginTrans();//开启事务
					
					try{
						MessageBean mBean=null;
						
						//判断附件是否已经上传至服务器
						if(isOnAttach(ct_id,dImpl)){
							if(!"".equals(ct_id)&&!"".equals(sj_id)){
								mBean = getMessageBean(ct_id, sj_id, cm_type,dImpl);//得到实体
							}
							if(mBean!=null){
								if("delete".equals(cm_type))
									mBean.setDtCode(dtCode);
								//推送类型1新增  2更新 3删除
								mBean.setOPERATER(cm_type);//设置推送类型  1新增  2更新 3删除
								
								String putXML=getXml(ct_id,mBean,dImpl).toString();
								System.out.println("putXML===========cm_id="+cm_id+"============="+putXML);
								//CFile.write(dImpl.getInitParameter("xxgkerror_path")+ct_id+"_put.xml",putXML.toString());
								//执行门户网站信息接口调用
								returnStr= (String) call.invoke(new Object[] {gwip,gwusername,gwpassword,putXML});
								returnStr = returnStr.trim();//去掉二头空格
								
							}
							System.out.println("returnStr-------------->" + returnStr);
						}
						
					}catch (Exception putEx) {
						System.out.println(CDate.getNowTime()+"推送出错--JavaClientNetService.java:"+ putEx.getMessage());
						returnStr=CDate.getNowTime()+"推送出错--JavaClientNetService.java:"+ putEx.getMessage();
					}
					
					boolean isPutSuccess =false;
					if("add".equals(cm_type)){
						if(isNumber(returnStr)){
							isPutSuccess=true;//如果能转换成数字,则说明推送成功
							returnStr=ct_id+cm_type+"成功";
						}else{
							isPutSuccess=false;//如果不能转换成数字,则说明推送失败
							returnStr=ct_id+cm_type+"失败";
						}
					}else if("edit".equals(cm_type)){
						if(isNumber(returnStr)){
							isPutSuccess=true;//如果能转换成数字,则说明推送成功
							returnStr=ct_id+cm_type+"成功";
						}else {
							isPutSuccess=false;//如果不能转换成数字,则说明推送失败
							returnStr=ct_id+cm_type+"失败";
						}
					}else if("delete".equals(cm_type)){
						if("".equals(returnStr)){
							isPutSuccess=true;//如果能转换成数字,则说明推送成功
							returnStr=ct_id+cm_type+"成功";
						}else {
							isPutSuccess=false;//如果不能转换成数字,则说明推送失败
							returnStr=ct_id+cm_type+"失败";
						}
					}
					
					returnString = returnStr;
					retr = returnStr;
					//更新推送状态
					 dImpl.setTableName("tb_contentmessage");
					 dImpl.setPrimaryFieldName("cm_id");
					 dImpl.edit("tb_contentmessage","cm_id",Integer.parseInt(cm_id));
					 if(isPutSuccess){
						 dImpl.setValue("cm_result","1",CDataImpl.INT);//1操作成功 2操作失败 失败超4次将不再推送
					 }else{
						 dImpl.setValue("cm_result","2",CDataImpl.INT);//1操作成功 2操作失败 失败超4次将不再推送
						 dImpl.setValue("cm_errornum",cm_errornum,CDataImpl.INT);//1操作成功 2操作失败 失败超4次将不再推送
					 }
					 dImpl.setValue("cm_updatetime",CDate.getThisday(),CDataImpl.STRING);// 推送结果时间
					 dImpl.setValue("cm_returnmessage",retr,CDataImpl.STRING);// 反馈信息
					 
					 dImpl.update();
					 
					 //记录日志-----
//				 	dImpl.setTableName("tb_contentmessagelog");
//				    dImpl.setPrimaryFieldName("cl_id");
//				    dImpl.addNew();
//				    dImpl.setValue("cm_id",cm_id,CDataImpl.INT);//关联tb_contentmessage表主键
//				    dImpl.setValue("cl_returnmessage",returnStr,CDataImpl.STRING);//反馈信息
//				    dImpl.update();
				    
					if(cDn.getLastErrString().equals("")){
						cDn.commitTrans();//没错误提交
						returnString="成功";
					}else{
						cDn.rollbackTrans();//有错误回滚
						returnString="发生错误";
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
	 * 组合xml
	 * @param ct_id 信息ID主键
	 * @param mBean 实体
	 * @param dImpl 数据对象
	 * @return 返回组合xml
	 */
	//in_gongwentype -1 请选择 0 命令(令) 1 决定 2 公告 3 通告 4 通知 5 通报 6 议案 7 报告 8 请示 9 批复 10 意见 11 函 12 会议纪要
	
	private StringBuffer getXml(String ct_id,MessageBean mBean,CDataImpl dImpl) {
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
		strB.append("<SOURCE>"+mBean.getSOURCE()+"</SOURCE>");
		strB.append("<DESCRIBE><![CDATA["+mBean.getDESCRIBE().replaceAll(">", "＞").replaceAll("<", "＜")+" ]]></DESCRIBE>");//摘要-内容描述
		strB.append("<KEY><![CDATA["+mBean.getKEY().replaceAll(">", "＞").replaceAll("<", "＜")+" ]]></KEY>");
		strB.append("<IMPORTANTFLAG>0</IMPORTANTFLAG>");
		//得到附件
		strB.append(getAttachXml(ct_id, dImpl,mBean));
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
	 * 得到附件相关XML
	 * @param ct_id 信息主键
	 * @param dImpl 数据对象
	 * @return StringBuffer 附件相关XML
	 */
	private StringBuffer getAttachXml(String ct_id,CDataImpl dImpl,MessageBean mBean) {
			StringBuffer strB= new StringBuffer();
			Hashtable table =null;
			String pa_name="";
			String pa_path="";
			String pa_filename="";
			String fileSize="";
			String filetype="";//扩展名
			
			String sql ="select pa_path,pa_name,pa_filename from tb_publishattach where ct_id="+ ct_id + " order by pa_id";
			//System.out.println("sqlattach======="+sql);
			Vector vPage = dImpl.splitPage(sql,60,1);//最多取60个附件
			String localPath=this.getClass().getResource("/").getPath();
			localPath = URLDecoder.decode(localPath);//转换编码 如空格
			localPath = localPath.substring(1,localPath.lastIndexOf("WEB-INF"));
			String allLocalPath=localPath+"attach/infoattach/";
			strB.append("<FILEPUBATTACH>");//附件开始
			if(vPage!=null){
				
				for(int i=0;i<vPage.size();i++){
					table = (Hashtable)vPage.get(i);
					pa_filename=CTools.dealNull(table.get("pa_filename"));
					pa_path=CTools.dealNull(table.get("pa_path"));
					pa_name=CTools.dealNull(table.get("pa_name"));
					filetype="";//扩展名初始化
					if(pa_filename.lastIndexOf(".")!=-1)
						filetype=pa_filename.substring(pa_filename.lastIndexOf(".")+1);
					
				
					String localFilePath=allLocalPath+pa_path+"/"+pa_filename;
					
					File file = new File(localFilePath);
					//System.out.println("localFilePath============="+localFilePath+"==filetype=="+filetype);
					if(file.exists()){
						//update by yao 20100726
						if(!"".equals(pa_name) &&!".".equals(pa_name)){
							if(pa_name.lastIndexOf(".") != -1)
								pa_filename=pa_name;
							else
								pa_filename=pa_name + pa_filename.substring(pa_filename.lastIndexOf("."));
						}
						
						strB.append("<PUBATTACH><FILENAME><![CDATA["+pa_filename.replaceAll(">", "＞").replaceAll("<", "＜")+"]]></FILENAME>");
						strB.append("<FILETYPE>"+filetype+"</FILETYPE>");
						try{
							FileInputStream fis = null;
							fis = new FileInputStream(file);
							fileSize =String.valueOf(fis.available());
							strB.append("<FILELENGTH>"+fileSize+"</FILELENGTH>");
							strB.append("<FILECONTENT>");//文件内容 base64
							strB.append(CBase64.getFileEncodeString(localFilePath));
							strB.append(" </FILECONTENT>");
							strB.append("<FILEEXTENSION>"+filetype+"</FILEEXTENSION>");
						}catch(IOException fnfe){
							System.out.println("JavaClientNetService.java:推送附件没找到"+fnfe.getMessage());
						}
						strB.append("</PUBATTACH>");
					}
				}
			}
			//正则查找正文中的附件 进行附件追加
			String regPic = "/attach/infoattach/[^\"]*\"";
			String labelContent = mBean.getCONTENT();
			String picStr="";
			Pattern p = null;
			Matcher m = null;
			p = Pattern.compile(regPic);
			m = p.matcher(labelContent);
			allLocalPath=localPath+"attach/infoattach/";
			while(m.find()) {
				picStr=m.group();
				if(!picStr.equals(""))picStr=picStr.substring(0, picStr.length()-1);//去掉最后一个引号
				else continue;//空 退出当前
		
				pa_filename=picStr.substring(picStr.lastIndexOf("/")+1);
				
				String tempPicStr=picStr.substring(0,picStr.lastIndexOf("/"));
				pa_path = tempPicStr.substring(tempPicStr.lastIndexOf("/")+1); 
				
				filetype="";//扩展名初始化
				if(pa_filename.lastIndexOf(".")!=-1)filetype=pa_filename.substring(pa_filename.lastIndexOf(".")+1);
				String localFilePath=allLocalPath+pa_path+"/"+pa_filename;
				File file = new File(localFilePath);
				if(file.exists()){
					strB.append("<PUBATTACH><FILENAME>"+pa_filename+"</FILENAME>");
					strB.append("<FILETYPE>"+filetype+"</FILETYPE>");
					try{
						FileInputStream fis = null;
						fis = new FileInputStream(file);
						fileSize =String.valueOf(fis.available());
						strB.append("<FILELENGTH>"+fileSize+"</FILELENGTH>");
						strB.append("<FILECONTENT>");//文件内容 base64
						strB.append(CBase64.getFileEncodeString(localFilePath));
						strB.append(" </FILECONTENT>");
						strB.append("<FILEEXTENSION>"+filetype+"</FILEEXTENSION>");
					}catch(IOException fnfe){
						System.out.println("JavaClientNetService.java:推送正文中的附件没找到"+fnfe.getMessage());
					}
					strB.append("</PUBATTACH>");
				}
			}
			strB.append("</FILEPUBATTACH>");//附件结束 
			return strB;
	}
	/**
	 * 判断附件是否已经上传
	 * @param ct_id
	 * @param dImpl
	 * @return
	 */
	private boolean isOnAttach(String ct_id,CDataImpl dImpl) {
		StringBuffer strB= new StringBuffer();
		Hashtable table =null;
		boolean isOnAttach = false;
		String pa_name="";
		String pa_path="";
		String pa_filename="";
		String fileSize="";
		String filetype="";//扩展名
		String localFilePath = "";
		
		String sql ="select pa_path,pa_name,pa_filename from tb_publishattach where ct_id="+ ct_id + " order by pa_id";
		//System.out.println("isonserversqlattach======="+sql);
		Vector vPage = dImpl.splitPage(sql,10,1);//最多取10个附件
		String localPath=this.getClass().getResource("/").getPath();
		localPath = URLDecoder.decode(localPath);//转换编码 如空格
		localPath = localPath.substring(1,localPath.lastIndexOf("WEB-INF"));
		String allLocalPath=localPath+"attach/infoattach/";
		if(vPage!=null){
			
			for(int i=0;i<vPage.size();i++){
				table = (Hashtable)vPage.get(i);
				pa_filename=CTools.dealNull(table.get("pa_filename"));
				pa_path=CTools.dealNull(table.get("pa_path"));
				pa_name=CTools.dealNull(table.get("pa_name"));
				filetype="";//扩展名初始化
				if(pa_filename.lastIndexOf(".")!=-1)
					filetype=pa_filename.substring(pa_filename.lastIndexOf(".")+1);
				
			
				localFilePath=allLocalPath+pa_path+"/"+pa_filename;
				
				File file = new File(localFilePath);
				if(file.exists()){
					isOnAttach = true;
				}else{
					isOnAttach = false;
				}
			}
		}else{
			isOnAttach = true;
		}
		System.out.println(isOnAttach+"====localFilePath============="+localFilePath+"==filetype=="+filetype);
		
		return isOnAttach;
}
	
	
	/**
	 * 得到实体对象
	 * @param ct_id  信息主键
	 * @param sj_id 栏目主键
	 * @param dImpl 数据对象
	 * @return 返回实体对象
	 */
	private MessageBean getMessageBean(String ct_id,String sj_id,String cm_type,CDataImpl dImpl){
		MessageBean mBean =new MessageBean();
		if("delete".equals(cm_type)){
			//设置栏目代码
			if(isNumber(sj_id))
				mBean.setSUBJECTCODE(getSj_dir(sj_id));
			else
				mBean.setSUBJECTCODE(sj_id);
				mBean.setID(ct_id);
				mBean.setSUBJECTID(sj_id);
		}else{
			
			String sql="select t.ct_title,t.ct_keywords,t.ct_inserttime,t.ct_sendtime,t.ct_endtime,t.ct_url,t.ct_specialflag,d.ct_content,t.ct_source,t.ct_memo,t.in_filenum,t.in_catchnum,"
					+ " t.dt_id,t.in_gongkaitype,t.in_gongwentype,t.in_carriertype,t.in_infotype,dt.dt_code  " 
					+ " from tb_content t,tb_contentdetail d,tb_deptinfo dt where t.ct_id=d.ct_id and t.dt_id = dt.dt_id and t.ct_id='"+ct_id+"'";
			System.out.println("getMessageBeanSql ================ " + sql);
			Hashtable table = dImpl.getDataInfo(sql);
			if(table!=null){
				mBean.setMessageTitle(CTools.dealNull(table.get("ct_title")));
				mBean.setSpecial(CTools.dealNull(table.get("ct_specialflag")));//1是特别提醒   0不是特别提醒
				mBean.setLink(CTools.dealNull(table.get("ct_url")));//链接 LINK
				mBean.setKEY(CTools.dealNull(table.get("ct_keywords")));
				mBean.setSENDDATE(CDate.getThisday());//信息推送日期即为修改日期
				mBean.setSendTime(CTools.dealNull(table.get("ct_sendtime")));//发布日期
				//结束时间是否为空
				String ct_endtime_ = CTools.dealNull(table.get("ct_endtime"));
				if("".equals(ct_endtime_)){
					ct_endtime_ = "2050-02-02";
				}
				mBean.setEndTime(ct_endtime_);//结束日期
				mBean.setInsertTime(CTools.dealNull(table.get("ct_inserttime")));//录入日期
				mBean.setCONTENT(CTools.dealNull(table.get("ct_content")));
				mBean.setSOURCE(CTools.dealNull(table.get("ct_source")));
				mBean.setDESCRIBE(CTools.dealNull(table.get("ct_memo")));
				mBean.setFILECODE(CTools.dealNull(table.get("in_filenum")));
				mBean.setINDEX(CTools.dealNull(table.get("in_catchnum")));
				mBean.setDtCode(CTools.dealNull(table.get("dt_code")));
				
				String dt_id = CTools.dealNull(table.get("dt_id"));//部门ID
				String in_gongkaitype = CTools.dealNull(table.get("in_gongkaitype"));String gCode="gongkaitype";//开公类型
				String in_carriertype = CTools.dealNull(table.get("in_carriertype"));String cCode="carriertype";//载体类型
				String in_infotype = CTools.dealNull(table.get("in_infotype"));String iCode="infotype";//记录形式
				String in_gongwentype = CTools.dealNull(table.get("in_gongwentype"));String gwCode="gongwentype";//公文类型
				
				sql="select * from (select dv_value as gv from tb_datavalue where dd_id =(select dd_id from tb_datatdictionary where dd_code='"+gCode+"') and dv_realvalue='"+in_gongkaitype+"')a, "
				+" (select dv_value as cv from tb_datavalue where dd_id =(select dd_id from tb_datatdictionary where dd_code='"+cCode+"') and dv_realvalue=nvl('"+in_carriertype+"','-1'))b, "
				+" (select dv_value as iv from tb_datavalue where dd_id =(select dd_id from tb_datatdictionary where dd_code='"+iCode+"') and dv_realvalue=nvl('"+in_infotype+"','-1'))c, "
				+" (select dv_value as gw from tb_datavalue where dd_id =(select dd_id from tb_datatdictionary where dd_code='"+gwCode+"') and dv_realvalue=nvl('"+in_gongwentype+"','-1'))g, "
				+" (select dt_name as dv from tb_deptinfo where dt_id ='"+dt_id+"')d ";
				
				//System.out.println("一些类型sql==============="+sql);
				table = dImpl.getDataInfo(sql);
				if(table!=null){
					mBean.setPUBLISH(CTools.dealNull(table.get("gv")));//公开类别
					mBean.setCARRIER(CTools.dealNull(table.get("cv")));//载体类型
					mBean.setANNAL(CTools.dealNull(table.get("iv")));//记录形式
					mBean.setSENDUNIT(CTools.dealNull(table.get("dv")));//部门名称
					mBean.setGONGWENTYPE(CTools.dealNull(table.get("gw")));//公文种类
					
				}
				//设置栏目代码, XA4排除发改委
				if(isNumber(sj_id) && !"XA4".equals(mBean.getDtCode()))
					mBean.setSUBJECTCODE(getSj_dir(sj_id));
				else
					mBean.setSUBJECTCODE(sj_id);
				
				mBean.setID(ct_id);
				mBean.setSUBJECTID(sj_id);
			}else{
				mBean = null;
			}
		}
		return mBean;
	}
	
	/**
	 * 根据栏目id得到栏目code
	 * @param sj_id 栏目id
	 * @return sj_dir 栏目code
	 */
	public String getSj_dir(String sj_id){
		String sj_dir = "";
		CDataCn dCn = null;
		CDataImpl dImpl = null;
		String sql = "select sj_dir from tb_subject where sj_id = "+ sj_id ;
		Hashtable table = null;
		try{
			dCn = new CDataCn();
			dImpl = new CDataImpl(dCn);
			table = dImpl.getDataInfo(sql);
			if(table != null)
				sj_dir = CTools.dealNull(table.get("sj_dir"));
		}catch(Exception e){
			System.out.println("getOraChildSubject -->" + e.getMessage());
		}finally{
			dImpl.closeStmt();
			dCn.closeCn();
		}
		return sj_dir;
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
	public String getThisSql() {
		return thisSql;
	}
	public void setThisSql(String thisSql) {
		this.thisSql = thisSql;
	}
	/**
	 * 本地测试调用浦东门户网站信息推送接口方法
	 * 初始化信息公开数据
	 * @param id 公文备案信息ID
	 * @param dt_id 部门ID
	 * @param startTime 开始日期
	 * @param endTime 结束日期
	 * @return 是否推送成功
	 * //cm_type 1 add 2 edit 3 delete
	 */
	public String putLocalData(String dt_id,String startTime,String endTime,String id){
		String returnString="";
		CDataCn cDn=null;
		CDataImpl dImpl=null;
		Hashtable table=null;
		Vector vPage=null;
		String sql="";
		String strSql = "";
		String ct_id="";
		String sj_id="";
		String cm_type="";//推送类型
		String cm_id = "";
		String dtCode = "";
		String returnStr="";
		String retr = "";
		StringBuffer errorXmls= new StringBuffer();
		try {
			cDn = new CDataCn();
			dImpl =new CDataImpl(cDn);
			//正式接口推送参数说明
			//#门户网站信息推送webservice访问地址
			//gwendpoint=http://61.129.65.9/PubilshInfo/intergrade.asmx
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
			String gwsubjectcode=pro.getPropertyValue("gwsubjectcode");
			String gwip=pro.getPropertyValue("gwip");
			String gwusername=pro.getPropertyValue("gwusername");
			String gwpassword=pro.getPropertyValue("gwpassword");
			
			String endpoint = gwendpoint;
			//门户正式接口地址
			endpoint = "http://system.pudong.gov.cn/PubilshInfo/intergrade.asmx";
			
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
			
			//条件查询
			if(!"".equals(dt_id)||!"".equals(startTime)||!"".equals(endTime)||!"".equals(id)){
				if(!"".equals(dt_id)){
					strSql += " and c.dt_id = "+dt_id+"";
				}
				if(!"".equals(startTime)){
					strSql += " and c.ct_inserttime > '"+startTime+"'";
				}
				if(!"".equals(endTime)){
					strSql += " and c.ct_inserttime < '"+endTime+"'";
				}
				if(!"".equals(id)){
					strSql += " and c.ct_id in ("+id+")";
				}
			}else{
				return "";
			}
			//cm_type 1 add 2 edit 3 delete
			sql = "select distinct s.sj_id,c.ct_id,'2' as cm_type,s.cm_id  from tb_content c,tb_contentmessage s where c.ct_id = s.ct_id  "+strSql+"";
			
			System.out.println("sql======"+sql);
			
			if(!getThisSql().equals(""))
				sql=getThisSql();//只取一条
			
			vPage = dImpl.splitPage(sql,5000,1);//最多取5000条
			if(vPage!=null){
				for(int i=0;i<vPage.size();i++){
					table =(Hashtable)vPage.get(i);
					ct_id=CTools.dealNull(table.get("ct_id"));
					sj_id=CTools.dealNull(table.get("sj_id"));//栏目代码
					cm_id = CTools.dealNull(table.get("cm_id"));
					
					cm_type=CTools.dealNull(table.get("cm_type"));
					if(cm_type.equals("1"))cm_type="add";
					else if(cm_type.equals("2"))cm_type="edit";
					else if(cm_type.equals("3"))cm_type="delete";
					
					//批量处理重建数据库链接
					if(i%200 == 0){
						dImpl.closeStmt();
						cDn.closeCn();
						
						cDn = new CDataCn();
						dImpl =new CDataImpl(cDn);
					}
					
					cDn.beginTrans();//开启事务
					
					try{
						MessageBean mBean=null;
						//判断附件是否已经上传至服务器
						if(isOnAttach(ct_id, dImpl)){
							if(!"".equals(ct_id)&&!"".equals(sj_id)){
								mBean = getMessageBean(ct_id, sj_id, cm_type,dImpl);//得到实体
							}
							if(mBean!=null){
							if("delete".equals(cm_type))
								mBean.setDtCode(dtCode);
							//推送类型1新增  2更新 3删除
							mBean.setOPERATER(cm_type);//设置推送类型  1新增  2更新 3删除
							
							String putXML=getXml(ct_id,mBean,dImpl).toString();
							System.out.println("putXMLLocal========================"+putXML);
							//CFile.write(dImpl.getInitParameter("xxgkerror_path")+ct_id+"trans.xml",putXML.toString());
							returnStr= (String) call.invoke(new Object[] {gwip,gwusername,gwpassword,putXML} );
							returnStr = returnStr.trim();//去掉二头空格
							
							}
							System.out.println("returnStr-->" + returnStr);
						}
						
					}catch (Exception putEx) {
						System.out.println(CDate.getNowTime()+"推送出错--JavaClientNetService.java:"+ putEx.getMessage());
						returnStr=CDate.getNowTime()+"推送出错--JavaClientNetService.java:"+ putEx.getMessage();
					}
					
					boolean isPutSuccess =false;
					if("add".equals(cm_type)){
						if(isNumber(returnStr)){
							isPutSuccess=true;//如果能转换成数字,则说明推送成功
							returnStr="成功";
						}else{
							isPutSuccess=false;//如果不能转换成数字,则说明推送失败
							returnStr="失败";
						}
					}else if("edit".equals(cm_type)){
						if(isNumber(returnStr)){
							isPutSuccess=true;//如果能转换成数字,则说明推送成功
							returnStr="成功";
						}else {
							isPutSuccess=false;//如果不能转换成数字,则说明推送失败
							//失败列表
							errorXmls.append(returnStr+"\n");
						}
					}else if("delete".equals(cm_type)){
						if("".equals(returnStr)){
							isPutSuccess=true;//如果能转换成数字,则说明推送成功
							returnStr="成功";
						}else {
							isPutSuccess=false;//如果不能转换成数字,则说明推送失败
							returnStr="失败";
						}
					}
					returnString = returnStr;
					retr = returnStr;
					//更新推送状态
					 dImpl.setTableName("tb_contentmessage");
					 dImpl.setPrimaryFieldName("cm_id");
					 dImpl.edit("tb_contentmessage","cm_id",Integer.parseInt(cm_id));
					 if(isPutSuccess){
						 dImpl.setValue("cm_result","1",CDataImpl.INT);//1操作成功 2操作失败 失败超4次将不再推送
					 }else{
						 dImpl.setValue("cm_result","2",CDataImpl.INT);//1操作成功 2操作失败 失败超4次将不再推送
					 }
					 dImpl.setValue("cm_updatetime",CDate.getThisday(),CDataImpl.STRING);// 推送结果时间
					 dImpl.setValue("cm_returnmessage",retr,CDataImpl.STRING);// 反馈信息
					 dImpl.update();
					 
					 //记录日志-----
//				 	dImpl.setTableName("tb_contentmessagelog");
//				    dImpl.setPrimaryFieldName("cl_id");
//				    dImpl.addNew();
//				    dImpl.setValue("cm_id",cm_id,CDataImpl.INT);//关联tb_contentmessage表主键
//				    dImpl.setValue("cl_returnmessage",returnStr,CDataImpl.STRING);//反馈信息
//				    dImpl.update();
				    
				    
				    if(cDn.getLastErrString().equals("")){
						cDn.commitTrans();//没错误提交
						returnString="成功";
					}else{
						cDn.rollbackTrans();//有错误回滚
						returnString="发生错误";
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


}
