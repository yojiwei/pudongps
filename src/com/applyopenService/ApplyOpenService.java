package com.applyopenService;

import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.net.URL;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.sql.ResultSet;
import java.sql.SQLDataException;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Hashtable;
import java.util.Vector;

import javax.xml.namespace.QName;

import org.apache.axis.client.Call;
import org.apache.axis.client.Service;
import org.jdom.Document;
import org.jdom.Element;
import org.jdom.input.SAXBuilder;

import sun.misc.BASE64Decoder;
import sun.misc.BASE64Encoder;

import com.app.CMySelf;
import com.component.database.CDataCn;
import com.component.database.CDataImpl;
import com.emailService.CASUtil;
import com.util.CBase64;
import com.util.CDate;
import com.util.CFile;
import com.util.CTools;
import com.util.ReadProperty;
import com.webservise.IGetServicesWS;
import com.webservise.WebserviceReadProperty;
/**
 * by yao 20091231
 * 门户网站依申请公开事项申请接口
 * @author Administrator
 */
public class ApplyOpenService{
	CDataCn dCn=null;   //新建数据库连接对象
	CDataImpl dImpl=null;  //新建数据接口对象
	CMySelf  cmy = null;
	ResultSet rs = null;
	Vector vector = null;
	Hashtable content = null;
	Hashtable contentxf = null;
	Hashtable contentwh = null;
	Hashtable contenthn = null;
	ReadProperty pro = null;
	//
	private String strSql = "";
	
	public ApplyOpenService(){
		pro = new ReadProperty();
	}
	/**
	 * 获得最老的提交的那份申请
	 */
	public String sendXmls(String username,String password){
		ApplyOpenForm applymodel = new ApplyOpenForm();
		String xmls = "";
		
		if(pro.getPropertyValue("apply_username").equals(username)&&pro.getPropertyValue("apply_password").equals(password)){
			try{
				dCn = new CDataCn(); 
				dImpl = new CDataImpl(dCn); 
				String [] fList = null;
				String FilePath = "";
				String filename = "";
				String proposer = "";
				String dt_code = "";//部门CODE
				//文件读取路径
				String path = dImpl.getInitParameter("workattach_read_path");
				//workattach_read_path = D:\pudongps\WebRoot\attach\workattach2007
				//status 0处理中（认领中心|指派）、1处理中、2已结束通过、3在征询中的意见(任务被挂起)、16对方没有接收成功的申请、17对方接收成功、5待补正材料、7第三方意见征询、8处理中
				strSql = "select * from (select id,to_char(applytime,'yyyy-MM-dd hh24:mi:ss') applytime,proposer,pname,punit,pcard,pcardnum,paddress,pzipcode,ptele,pemail,ename,ecode,ebunissinfo,edeputy,elinkman,etele,eemail,infotitle,commentinfo,flownum,purpose,memo,ischarge,free,filenum,offermode,gainmode from infoopen where status=1 order by id) where rownum=1";
				//System.out.println("strSql===="+strSql);
				content  =dImpl.getDataInfo(strSql);
				
				if(content!=null)
				{
					applymodel.setSystemname(URLEncoder.encode("浦东门户网上申请公开","utf-8"));//浦东门户网上申请公开
					applymodel.setSender(URLEncoder.encode("浦东门户","utf-8"));//浦东门户
					applymodel.setSendtime(URLEncoder.encode(CTools.dealNull(content.get("applytime")),"utf-8"));//发送时间
					applymodel.setMessgaeid(URLEncoder.encode(CTools.dealNull(content.get("id")),"utf-8"));//信息主键
					if(CTools.dealNull(content.get("proposer"))!=null){
						proposer = CTools.dealNull(content.get("proposer"));
						proposer = "0".equals(proposer)?"people":"company";
					}
					applymodel.setOperater(URLEncoder.encode(proposer,"utf-8"));//people为公民  company为公司
					
					applymodel.setName(URLEncoder.encode(CTools.dealNull(content.get("pname")),"utf-8"));//姓名
					applymodel.setOrgan(URLEncoder.encode(CTools.dealNull(content.get("punit")),"utf-8"));//工作单位
					applymodel.setPapertype(URLEncoder.encode(CTools.dealNull(content.get("pcard")),"utf-8"));//证件名称
					applymodel.setPapernumber(URLEncoder.encode(CTools.dealNull(content.get("pcardnum")),"utf-8"));//证件号码
					applymodel.setAddress(URLEncoder.encode(CTools.dealNull(content.get("paddress")),"utf-8"));//通信地址
					applymodel.setPostalcode(URLEncoder.encode(CTools.dealNull(content.get("pzipcode")),"utf-8"));//邮政编码
					applymodel.setTel(URLEncoder.encode(CTools.dealNull(content.get("ptele")),"utf-8"));//电话号码
					applymodel.setTelother(URLEncoder.encode("","utf-8"));//其他联系电话
					applymodel.setPeopleemail(URLEncoder.encode(CTools.dealNull(content.get("pemail")),"utf-8"));//电子邮件
					
					applymodel.setCompanyname(URLEncoder.encode(CTools.dealNull(content.get("ename")),"utf-8"));//公司名称
					applymodel.setCompanycode(URLEncoder.encode(CTools.dealNull(content.get("ecode")),"utf-8"));//组织机构代码
					applymodel.setBusinesscard(URLEncoder.encode(CTools.dealNull(content.get("ebunissinfo")),"utf-8"));//营业执照信息
					applymodel.setDeputy(URLEncoder.encode(CTools.dealNull(content.get("edeputy")),"utf-8"));//法人代表
					
					applymodel.setLinkman(URLEncoder.encode(CTools.dealNull(content.get("elinkman")),"utf-8"));//联系人
					
					applymodel.setCompanytel(URLEncoder.encode(CTools.dealNull(content.get("etele")),"utf-8"));//联系电话号码
					applymodel.setCompanytelother(URLEncoder.encode("","utf-8"));//联系人其他电话
					applymodel.setCompanyemail(URLEncoder.encode(CTools.dealNull(content.get("eemail")),"utf-8"));//公司邮箱
					
					applymodel.setTitle(URLEncoder.encode(CTools.dealNull(content.get("infotitle")),"utf-8"));//信息名称
					applymodel.setContent(URLEncoder.encode(CTools.dealNull(content.get("commentinfo")),"utf-8"));//内容
					applymodel.setCatchnum(URLEncoder.encode(CTools.dealNull(content.get("flownum")),"utf-8"));//所需信息的索取号
					applymodel.setPurpose(URLEncoder.encode(CTools.dealNull(content.get("purpose")),"utf-8"));//所需信息的用途
					applymodel.setRemark(URLEncoder.encode(CTools.dealNull(content.get("memo")),"utf-8"));//备注
					applymodel.setDerate(URLEncoder.encode(CTools.dealNull(content.get("ischarge").equals("0")?"no":"yes"),"utf-8"));//是否申请减免费用  no不申请   yes申请
					//update 20090422
					applymodel.setFree(URLEncoder.encode(CTools.dealNull(content.get("free")),"utf-8"));//特别声明：个人需申请免除收费，主要理由
					applymodel.setFilenum(URLEncoder.encode(CTools.dealNull(content.get("filenum")),"utf-8"));//文号
					//
					applymodel.setOffer(URLEncoder.encode(CTools.dealNull(content.get("offermode")),"utf-8"));//所需信息的载体方式  用逗号隔开 如 纸面,电子邮件,  0,1,
					applymodel.setGetmethod(URLEncoder.encode(CTools.dealNull(content.get("gainmode")),"utf-8"));//获取政府信息方式 用逗号隔开 如 邮寄 快递 电子邮件 传真
					//根据部门CODE获取部门的名称 
					strSql = "select d.dt_operid,d.dt_name from tb_deptinfo d,taskcenter t where d.dt_id = t.did and t.iid="+content.get("id")+"";
					contentwh = dImpl.getDataInfo(strSql);
					if(contentwh!=null){
						dt_code = CTools.dealNull(contentwh.get("dt_operid"));//组织机构代码dt_operid
					}
					applymodel.setDept(URLEncoder.encode(dt_code,"utf-8"));//部门CODE
					//关于附件
					//查出附件内容进行base64编码
					strSql="select at_filename,at_name,at_path from tb_applyopenattach where ap_id='"+content.get("id")+"'";
					contentxf = dImpl.getDataInfo(strSql);
					if(contentxf!=null){
						filename = CTools.dealNull(contentxf.get("at_name"));
						applymodel.setFilenewname(URLEncoder.encode(CTools.dealNull(contentxf.get("at_name")),"utf-8"));//附件名称
						//对附件的内容进行base64位编码
						String aa_path = CTools.dealNull(contentxf.get("at_path"));
						if(!aa_path.equals("")){
							//System.out.println("infoopen_attach=========="+path + aa_path);
							java.io.File imgDir = new java.io.File(path + aa_path);
							if (imgDir.exists()){
								fList = imgDir.list();
								//System.out.println("fList==========="+fList.length);
								if(fList.length>=1){
									if (!fList[fList.length-1].equals("")){
									  FilePath = path + aa_path + "\\" + fList[fList.length-1];
									}
								}
							 }
						}
						//得到附件大小
						//System.out.println("-----------"+FilePath);
						File file = new File(FilePath);
						String fileSize = "";
						if(file.exists()){
							FileInputStream fis = new FileInputStream(file);
							fileSize =String.valueOf(fis.available());
						}
						//根据路径读取附件
						String attachContent = this.readFile(FilePath);
						//System.out.println("attachContent==============="+attachContent);
						applymodel.setFilecontent(attachContent);//附件内容
						applymodel.setFileoldname(URLEncoder.encode(CTools.dealNull(contentxf.get("at_filename")),"utf-8"));//附件原名
						applymodel.setFilelength(URLEncoder.encode(fileSize,"utf-8"));//附件大小
						applymodel.setFileextension(URLEncoder.encode(filename.substring(filename.lastIndexOf(".")+1),"utf-8"));//附件扩展名
					}
					//返回XML格式的字符串
					xmls = applyopenXml(applymodel);
					//System.out.println("xmls======="+xmls); 
					//CFile.write("d:/abc.xml",xmls);
				}
			}catch(Exception ex){
				System.out.println("sendXmls方法=="+new java.util.Date() + "---" + ex.getMessage());
				ex.printStackTrace();
			}finally{
				dImpl.closeStmt();
				dCn.closeCn();
			}
		}
		return xmls;
	}
	/**
	 * 拼字符串
	 * @param applyopenForm
	 * @return
	 */
	private String applyopenXml(ApplyOpenForm applyopenForm) {
		StringBuffer applyXml  =new StringBuffer();
		applyXml.append("<infoopen>");
		applyXml.append("<systemname>"+applyopenForm.getSystemname()+" </systemname>");//浦东门户网上申请公开
		applyXml.append("<sender>"+applyopenForm.getSender()+" </sender>");//浦东门户
		applyXml.append("<sendtime>"+applyopenForm.getSendtime()+" </sendtime>"); //发送时间
		applyXml.append("<messgaeid>"+applyopenForm.getMessgaeid()+" </messgaeid>");  //信息主键
		applyXml.append("<operater>"+applyopenForm.getOperater()+" </operater>"); //people为公民  company为公司
		
		applyXml.append("<name>"+applyopenForm.getName()+" </name>");  //姓名
		applyXml.append("<organ>"+applyopenForm.getOrgan()+" </organ>"); //工作单位
		applyXml.append("<papertype>"+applyopenForm.getPapertype()+" </papertype>");//证件名称
		applyXml.append("<papernumber>"+applyopenForm.getPapernumber()+" </papernumber>");//证件号码
		applyXml.append("<address>"+applyopenForm.getAddress()+" </address>");//地址
		applyXml.append("<postalcode>"+applyopenForm.getPostalcode()+" </postalcode>");//邮政编码
		applyXml.append("<tel>"+applyopenForm.getTel()+" </tel>");//联系电话
		applyXml.append("<telother>"+applyopenForm.getTelother()+" </telother>");//其他联系电话
		applyXml.append("<peopleemail>"+applyopenForm.getPeopleemail()+" </peopleemail>");//电子邮件
		
		applyXml.append("<companyname>"+applyopenForm.getCompanyname()+" </companyname>");//名　称
		applyXml.append("<companycode>"+applyopenForm.getCompanycode()+" </companycode>");//组织机构代码
		applyXml.append("<businesscard>"+applyopenForm.getBusinesscard()+" </businesscard>");//营业执照信息
		applyXml.append("<deputy>"+applyopenForm.getDeputy()+" </deputy>");//法人代表
		applyXml.append("<linkman>"+applyopenForm.getLinkman()+" </linkman>");//联系人
		applyXml.append("<companytel>"+applyopenForm.getCompanytel()+" </companytel>");//联系人电话
		applyXml.append("<companytelother>"+applyopenForm.getCompanytelother()+" </companytelother>");//联系人其他电话
		applyXml.append("<companyemail>"+applyopenForm.getCompanyemail()+" </companyemail>");//电子邮件
		
		applyXml.append("<title>"+applyopenForm.getTitle()+" </title>");//信息名称
		applyXml.append("<content>");//内容
		applyXml.append("<![CDATA["+applyopenForm.getContent()+" ]]>");//内容
		applyXml.append("</content>");//内容
		//附件
		applyXml.append("<filecontent>"+applyopenForm.getFilecontent()+" </filecontent>");//文件编码 base64编码
		applyXml.append("<filelength>"+applyopenForm.getFilelength()+" </filelength>");//文件大小,以字节算
		applyXml.append("<fileoldname>"+applyopenForm.getFileoldname()+" </fileoldname>");//附件原名
		applyXml.append("<filenewname>"+applyopenForm.getFilenewname()+" </filenewname>");//附件现在的名字
		applyXml.append("<fileextension>"+applyopenForm.getFileextension()+" </fileextension>");// 附件扩展名 
		//
		applyXml.append("<catchnum>"+applyopenForm.getCatchnum()+" </catchnum>");//所需信息的索取号 可为空
		applyXml.append("<purpose>"+applyopenForm.getPurpose()+" </purpose>");//所需政府信息的用途
		applyXml.append("<remark>");//备注
		applyXml.append("<![CDATA["+applyopenForm.getRemark()+" ]]>");//备注
		applyXml.append("</remark>");//备注
		applyXml.append("<derate>"+applyopenForm.getDerate()+" </derate>");//是否申请减免费用  no不申请   yes申请
		//update 20090422
		applyXml.append("<free>"+applyopenForm.getFree()+" </free>");//特别声明：个人需申请免除收费，主要理由
		applyXml.append("<wennum>"+applyopenForm.getFilenum()+" </wennum>");//文号
		//
		applyXml.append("<offer>"+applyopenForm.getOffer()+" </offer>");//所需信息的制定提供方式  用逗号隔开 如 纸面,电子邮件
		applyXml.append("<getmethod>"+applyopenForm.getGetmethod()+" </getmethod>");//获取政府信息方式 用逗号隔开 如 纸面,电子邮件
		applyXml.append("<dept>"+applyopenForm.getDept()+" </dept>");//选择相关受理部门
		applyXml.append("</infoopen>");
		
		String applyopenMessage="<?xml version=\"1.0\" encoding=\"GBK\" ?>"+applyXml+"";
		//System.out.println("applyopenMessage====="+applyopenMessage);
		return applyopenMessage;
	}
	/**
	 * 修改依申请公开处理状态
	 * 如果对方连续接收不成功将状态更改为16,成功将状态改为17
	 * @param id 依申请公开的信息ID
	 * @param username 修改申请状态进入的用户名
	 * @param password 反馈申请状态进入的用户密码
	 * @param status 修改状态true成功传送 false失败传送 
	 * @return true修改状态成功 false修改状态失败
	 */
	public boolean updateStatus(String id,String username,String password,String status){
		boolean isupdate = false;//是否修改成功false
		if(pro.getPropertyValue("apply_username").equals(username)&&pro.getPropertyValue("apply_password").equals(password)){
			try{
				dCn = new CDataCn(); 
				dImpl = new CDataImpl(dCn);
				dImpl.edit("infoopen", "id",id);
				if(status.equals("true")){
					dImpl.setValue("status","17",CDataImpl.STRING);//改掉这个状态17成功传送
				}else{
					dImpl.setValue("status","16",CDataImpl.STRING);//改掉这个状态16不再传送
				}
				dImpl.update();
				if(dImpl.getLastErrString().equals("")){
					isupdate = true;
				}else{
					isupdate = false;
				}
			}catch(Exception ex){
				System.out.println("updateStatus方法===="+new java.util.Date() + "--" + ex.getMessage());
			}finally{
				dImpl.closeStmt();
				dCn.closeCn();
			}
		}
		return isupdate;
	}
	/**
	 * 修改依申请公开处理结果
	 * @param getXmls 反馈的申请信息
	 * @param username 反馈申请进入的用户名
	 * @param password 反馈申请进入的用户密码
	 * @return false反馈失败true反馈成功
	 */
	public boolean getXmls(String getXmls,String username,String password){
		String messgaeid = "";
		String checktype = "";
		String status = "";
		String statusStep = "";
		String feedback = ""; 
		String statusname = "";
		String dealmode = "";
		String step = "";//处理方式
		String fdcode = "";
		String fdid = "";
		String isovertime = "";
		String finishtime = "";
		String fdname = "";
		boolean isdeal = false;
		
		//System.out.println("---backfeck-------"+getXmls);
		//pudong 依申请公开
		//0处理中（认领中心|指派）、1处理中、2已结束通过、3在征询中的意见(任务被挂起)、
		//16对方没有接收成功、17对方接收成功、5待补正材料
		//gwba 公文备案状态
		//status 1同意公开、2同意部分公开、3国家秘密、4商业秘密（一）行政机关不予公开、5商业秘密（二）行政机关予以公开、
		//6商业秘密（三）权利人不同意公开或未答复、7商业秘密（四）权利人同意公开、8个人隐私（一）行政机关不予公开、
		//9个人隐私（二）行政机关予以公开、10个人隐私（三）权利人不同意公开或未答复、11个人隐私（四）权利人同意公开、
		//12权利人意见征询、13非《规定》所指政府信息、14政府信息不存在、15不属于本机关公开职责权限范围、
		//16过程中信息且危及安全稳定、17危及安全稳定、18非政府信息公开申请、19补正申请告知、20重复申请、21延期答复告知
		//22申请人主动放弃申请、23垃圾申请、24多次重复不作处理
		//step
		//5已完成、－1垃圾、3待补正、2未处理 7第三方意见征询、1材料预审、0未办结业务、8处理中
		
		if(pro.getPropertyValue("apply_username").equals(username)&&pro.getPropertyValue("apply_password").equals(password)){
			messgaeid = CASUtil.getUserColumn(getXmls, "messgaeid"); //依申请公开ID
			checktype = CASUtil.getUserColumn(getXmls, "checktype"); //2显示即将超时3已经超时
			statusStep = CASUtil.getUserColumn(getXmls, "status");  //处理结果状态
			feedback = CASUtil.getUserColumn(getXmls, "feedback"); //回复
			statusname = CASUtil.getUserColumn(getXmls, "statusname"); //处理结果名字
			dealmode = CASUtil.getUserColumn(getXmls, "dealmode");  //处理方式--
			step = CASUtil.getUserColumn(getXmls, "step");  //办理之后的状态
			fdcode = CASUtil.getUserColumn(getXmls, "fdcode");//处理部门组织代码
			fdname = CASUtil.getUserColumn(getXmls, "fdname");//处理部门名称
			isovertime = CASUtil.getUserColumn(getXmls, "isovertime");//是否超时0默认1超时处理2没有超时处理
			finishtime = CASUtil.getUserColumn(getXmls, "finishtime");//申请完成时间
			
			if(step.equals("5")){//处理已结束
				status = "2";
			}
			else if(step.equals("3")){//待补正
				status = "5";
			}
			else if(step.equals("-1")){//垃圾
				status="2";
				checktype = "9";
			}
			else if(step.equals("7")){//第三方意见征询
				status = "3";
			}
			else if(step.equals("8")){//处理中
				status = "0";
			}
			else if(step.equals("2")){//未办理
				//status = "";//状态不变
			}
			else if(step.equals("1")){//材料预审
				//status = "17";//没有状态
			}else{
				status = "2";
			}
			SimpleDateFormat   df   =   new   SimpleDateFormat("yyyy-MM-dd");
			Date finishdate = null;
			
			try{
				dCn = new CDataCn(); 
				dImpl = new CDataImpl(dCn);
				if(!"".equals(finishtime)){
					finishdate=(Date)df.parse(finishtime);
				}
				if (!messgaeid.equals("")) {
					dImpl.edit("infoopen", "id",messgaeid);
					dImpl.setValue("status",status,CDataImpl.STRING);
					dImpl.setValue("statusname",statusname,CDataImpl.STRING);//处理方式的名称
					dImpl.setValue("dealmode",statusStep,CDataImpl.STRING);//具体处理方式
					dImpl.setValue("feedback",feedback,CDataImpl.STRING);//备注｜｜回复
					dImpl.setValue("checktype",checktype,CDataImpl.STRING);//9垃圾
					if(fdcode!=null){
						strSql = "select dt_id,dt_name from tb_deptinfo where dt_operid = '"+fdcode+"'";
						contenthn = dImpl.getDataInfo(strSql);
						if(contenthn!=null){
							fdid = CTools.dealNull(contenthn.get("dt_id"));
							fdname = CTools.dealNull(contenthn.get("dt_name"));
						}
					}
					dImpl.setValue("fdid",fdid,CDataImpl.STRING);//处理部门ID
					dImpl.setValue("fdname",fdname,CDataImpl.STRING);//处理部门名称
					dImpl.setValue("isovertime",isovertime,CDataImpl.INT);//是否超时
					dImpl.setValue("finishtime",finishdate,CDataImpl.DATE);//申请完成时间
					dImpl.setValue("isxd","1",CDataImpl.INT);//是否将反馈信息推送给新点0否1是
					
					dImpl.update();
					
					if(dImpl.getLastErrString().equals("")){
						isdeal = true;
						//反馈信息给新点
						if(isdeal){
							
							
							//反馈信息给新点
							String strSql = "select infoid from infoopen where id='"+messgaeid+"' and isxd = 1";
							content = dImpl.getDataInfo(strSql);
							if(content!=null)
							{
								sendFeedbackMessage(CTools.dealNull(content.get("infoid")),getXmls);
							}					
						}
						return isdeal;
					}else{
						return isdeal;
					}
					
				}
			}catch(Exception ex){
				System.out.println("getXmls方法==="+new java.util.Date() + "--" + ex.getMessage());
			}finally{
				dImpl.closeStmt();
				dCn.closeCn();
			}		
		}
		return isdeal;
	}
	
	/**
	 * 第三方系统调用门户网站依申请公开接口插入infoopen表
	 * @param username
	 * @param password
	 * @param xmls
	 * @return
	 */ 
	public String insertInfoopens(String xmls,String username,String password){
		Boolean islogin = false;
		try{
			dCn = new CDataCn();
			dImpl = new CDataImpl(dCn);
			cmy = new CMySelf();
			String operater = "";
			String id = "";
			String deptSql = "";
			String deptId = "";
			String deptName = "";
			String deptCode = "";
			xmls = getCleanXmls(xmls);
			//System.out.println("ApplyOpenService====insertInfoopens====xmls=="+xmls);
			//验证用户是否登录
			islogin = cmy.login(username, password);
			//islogin = true;
			//验证用户是否登录
			if(islogin&&!"".equals(xmls)){
				//表infoopen
				dImpl.setTableName("infoopen");
				dImpl.setPrimaryFieldName("id");
				id = String.valueOf(dImpl.addNew());
				if(!"".equals(CTools.dealNull(CASUtil.getUserColumn(xmls, "paddress")))){
					dImpl.setValue("paddress",CTools.dealNull(CASUtil.getUserColumn(xmls, "paddress")).trim(),CDataImpl.STRING);
				}else{
					dImpl.setValue("paddress",CTools.dealNull(CASUtil.getUserColumn(xmls, "companyaddress")).trim(),CDataImpl.STRING);
				}
				dImpl.setValue("infoid",CTools.dealNumber(CASUtil.getUserColumn(xmls, "messgaeid")),CDataImpl.INT);
				dImpl.setValue("proposer",CTools.dealNumber(CASUtil.getUserColumn(xmls, "operater")),CDataImpl.INT);
				dImpl.setValue("pname",CTools.dealNull(CASUtil.getUserColumn(xmls, "name")).trim(),CDataImpl.STRING);
				dImpl.setValue("pcard",CTools.dealNull(CASUtil.getUserColumn(xmls, "papertype")).trim(),CDataImpl.STRING);
				dImpl.setValue("pcardnum",CTools.dealNull(CASUtil.getUserColumn(xmls, "papernumber")).trim(),CDataImpl.STRING);
				
				dImpl.setValue("pzipcode",CTools.dealNull(CASUtil.getUserColumn(xmls, "postalcode")).trim(),CDataImpl.STRING);
				dImpl.setValue("ptele",CTools.dealNull(CASUtil.getUserColumn(xmls, "tel")).trim(),CDataImpl.STRING);
				dImpl.setValue("pemail",CTools.dealNull(CASUtil.getUserColumn(xmls, "peopleemail")).trim(),CDataImpl.STRING);
				dImpl.setValue("ename",CTools.dealNull(CASUtil.getUserColumn(xmls, "companyname")).trim(),CDataImpl.STRING);
				dImpl.setValue("edeputy",CTools.dealNull(CASUtil.getUserColumn(xmls, "deputy")).trim(),CDataImpl.STRING);
				dImpl.setValue("elinkman",CTools.dealNull(CASUtil.getUserColumn(xmls, "linkman")).trim(),CDataImpl.STRING);
				dImpl.setValue("etele",CTools.dealNull(CASUtil.getUserColumn(xmls, "companytel")).trim(),CDataImpl.STRING);
				dImpl.setValue("pzipcode",CTools.dealNull(CASUtil.getUserColumn(xmls, "companypostalcode")).trim(),CDataImpl.STRING);
				dImpl.setValue("eemail",CTools.dealNull(CASUtil.getUserColumn(xmls, "companyemail")).trim(),CDataImpl.STRING);
				dImpl.setValue("commentinfo",CTools.dealNull(CASUtil.getUserColumn(xmls, "content")).trim(),CDataImpl.STRING);
				dImpl.setValue("applytime",CTools.dealNull(CASUtil.getUserColumn(xmls, "sendtime")).trim(),CDataImpl.DATE);
				dImpl.setValue("flownum",CTools.dealNull(CASUtil.getUserColumn(xmls, "catchnum")).trim(),CDataImpl.STRING);
				dImpl.setValue("purpose",CTools.dealNull(CASUtil.getUserColumn(xmls, "purpose")).trim(),CDataImpl.STRING);
				dImpl.setValue("free",CTools.dealNull(CASUtil.getUserColumn(xmls, "free")).trim(),CDataImpl.STRING);
				dImpl.setValue("offermode",CTools.dealNull(CASUtil.getUserColumn(xmls, "offer")).trim(),CDataImpl.STRING);
				dImpl.setValue("gainmode",CTools.dealNull(CASUtil.getUserColumn(xmls, "getmethod")).trim(),CDataImpl.STRING);
				//获取部门ID
				deptCode = CTools.dealNull(CASUtil.getUserColumn(xmls, "dept")).trim();
				if(!"".equals(deptCode)){
					deptSql = "select dt_id,dt_name from tb_deptinfo where dt_operid = '"+deptCode+"'";
					Hashtable deptHash = dImpl.getDataInfo(deptSql);
					if(deptHash!=null){
						deptId = CTools.dealNull(deptHash.get("dt_id"));
						deptName = CTools.dealNull(deptHash.get("dt_name"));
					}
				}
				dImpl.setValue("fdid",deptId,CDataImpl.INT);//
				dImpl.setValue("fdname",deptName,CDataImpl.STRING);
				dImpl.setValue("userip",CTools.dealNull(CASUtil.getUserColumn(xmls, "ip")).trim(),CDataImpl.STRING);
				dImpl.setValue("status","1",CDataImpl.INT);
				dImpl.setValue("ischarge","0",CDataImpl.INT);
				dImpl.setValue("isxd","1",CDataImpl.INT);//1新点提交
				dImpl.update();
				
				
				//表taskcenter
				dImpl.setTableName("taskcenter");
				dImpl.setPrimaryFieldName("id");
				dImpl.addNew();
				dImpl.setValue("iid",id,CDataImpl.INT);
				dImpl.setValue("did",deptId,CDataImpl.INT);
				dImpl.setValue("starttime",CTools.dealNull(CASUtil.getUserColumn(xmls, "sendtime")).trim(),CDataImpl.DATE);
				dImpl.setValue("status","0",CDataImpl.INT);
				dImpl.setValue("isovertime","0",CDataImpl.INT);
				dImpl.setValue("genre","网上申请",CDataImpl.STRING);
				dImpl.update();
			
				
				//表tb_applyopenattach
				//上传附件文件名称
				int random_filenum =(int)(Math.random()*1000000);
				String today = CDate.getThisday();
				String random_realName = today + Integer.toString(random_filenum) + id+"."+CTools.dealNull(CASUtil.getUserColumn(xmls, "fileextension"));

				if(!(CTools.dealNull(CASUtil.getUserColumn(xmls, "filecontent"))).equals("")){//有附件
					dImpl.addNew("tb_applyopenattach","at_id",CDataImpl.PRIMARY_KEY_IS_VARCHAR);
					dImpl.setValue("ap_id",id,CDataImpl.INT);
					dImpl.setValue("at_filename",CTools.dealNull(CASUtil.getUserColumn(xmls, "fileoldname")),CDataImpl.STRING);//
					dImpl.setValue("at_name",random_realName,CDataImpl.STRING);//
					dImpl.setValue("at_date",CDate.getNowTime(),CDataImpl.STRING);//
					dImpl.setValue("at_content","1",CDataImpl.STRING);//
					int numeral = 0;
					numeral =(int)(Math.random()*100000);
					String pa_path = CDate.getThisday()+ Integer.toString(numeral);
					dImpl.setValue("at_path",pa_path,CDataImpl.STRING);
					
					String localPath=this.getClass().getResource("/").getPath();
					//localPath = URLDecoder.decode(localPath);//转换编码 如空格
					//localPath = localPath.substring(1,localPath.lastIndexOf("WEB-INF"));
					//localPath+="attach/infoattach/"+pa_path+"/";//目录
					localPath = pro.getPropertyValue("workattach2007path")+pa_path+"/";
					java.io.File newDir = new java.io.File(localPath);
					if(!newDir.exists())//生成目录
					{
					  newDir.mkdirs();
					}
					localPath+=random_realName;//文件地址
					CBase64.saveDecodeStringToFile(CASUtil.getUserNoColumn(xmls, "filecontent"),localPath);//生成文件
					
					dImpl.update();
				}
				
			}else{
				return "login error";
			}
		}catch(Exception ex){
			System.out.println("插入失败 "+CDate.getNowTime()+" ApplyOpenService.insertInfoopens ");
			ex.printStackTrace();
			return ex.toString();
		}finally{
			dImpl.closeStmt(); 
			dCn.closeCn();
		}
		return "success";
	}
	
	/**
	 * 依申请公开处理结果反馈给新点
	 * @param feedbackXmls
	 */ 
	public int sendFeedbackMessage(String infoid,String feedbackXmls){
		
		//重新找到对应新点ID
		String xml="<?xml version=\"1.0\" encoding=\"utf-8\"?>";
		xml=xml+"<infoopenfeedback>";
		xml=xml+"<messgaeid>"+infoid+"</messgaeid>";
		xml=xml+"<step>"+CTools.dealString(CASUtil.getUserColumn(feedbackXmls, "step")).trim()+"</step>";
		xml=xml+"<status>"+CTools.dealString(CASUtil.getUserColumn(feedbackXmls, "status")).trim()+"</status>";
		xml=xml+"<feedback>"+CTools.dealString(CASUtil.getUserColumn(feedbackXmls, "feedback")).trim()+"</feedback>";
		xml=xml+"<isovertime>"+CTools.dealString(CASUtil.getUserColumn(feedbackXmls, "isovertime")).trim()+"</isovertime>";
		xml=xml+"<finishtime>"+CTools.dealString(CASUtil.getUserColumn(feedbackXmls, "finishtime")).trim()+"</finishtime>";
		xml=xml+"</infoopenfeedback>";
 

		String uid = "hr_pudong";
		String pwd = "abc456";
		String xdfeedbackservice = "http://192.168.152.214/shpdhrservice/EpointService.asmx?wsdl";//测试地址
		int returnStr = 0;
		String returns = "";
		String gwnamespaceuri = "http://tempuri.org/";
		String gwsoapactionuri = "http://tempuri.org/YsqgkReply";
		try{
			//使用Call
			Service service = new Service();
			Call call = (Call) service.createCall();
			call.setTargetEndpointAddress(new java.net.URL(xdfeedbackservice));
			call.setOperationName(new QName(gwnamespaceuri, "YsqgkReply"));
			call.addParameter(new QName(gwnamespaceuri,"uid"), org.apache.axis.encoding.XMLType.XSD_STRING,javax.xml.rpc.ParameterMode.IN);
			call.addParameter(new QName(gwnamespaceuri,"pwd"), org.apache.axis.encoding.XMLType.XSD_STRING,javax.xml.rpc.ParameterMode.IN);
			call.addParameter(new QName(gwnamespaceuri,"xml"), org.apache.axis.encoding.XMLType.XSD_STRING,javax.xml.rpc.ParameterMode.IN);
			call.setReturnType(org.apache.axis.encoding.XMLType.XSD_STRING);
			call.setUseSOAPAction(true);
			call.setSOAPActionURI(gwsoapactionuri);
			
			returns= (String) call.invoke(new Object[] {uid,pwd,xml});
			if(!"".equals(returns)){
				returnStr = Integer.parseInt(returns);
			}


		}catch(Exception ex){
			ex.printStackTrace();
		} 
		return returnStr;
		
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
	/**
	 * 还原编码后的特殊字符
	 * @param xmls
	 * @return
	 */
	private String getCleanXmls(String xmls){
		  xmls = xmls.replaceAll("&amp;","&");
		  xmls = xmls.replaceAll("&quot;","");
		  xmls = xmls.replaceAll("&lt;","<");
		  xmls = xmls.replaceAll("&gt;",">");
		  xmls = xmls.replaceAll("&nbsp;"," ");
		  return xmls;
	}
	/**
	 * 将 String 进行 BASE64 编码 
	 * @param s
	 * @return
	 */
	private static String getBASE64(String s) { 
		if (s == null) return null; 
		return (new sun.misc.BASE64Encoder()).encode( s.getBytes() ); 
	} 
	/**
	 * 将 File 进行 BASE64 编码 
	 * @param filePath
	 * @return
	 */
	private static String readFile(String filePath) {
	 String result = "";//处理结果
	  try {
		   BASE64Encoder encoder = new BASE64Encoder();
		   File file = new File(filePath);
		   FileInputStream in = new FileInputStream(file);
		   byte[] b = new byte[(int) file.length()];
		   in.read(b);
		    result =encoder.encode(b);
		   in.close();
		   return result;
	  } catch (Exception e) {
		  System.out.println(new java.util.Date() + "--" + e.getMessage());
	  }
	  return result;
	 }
	/**
	 * 将 BASE64 编码的字符串 s 进行解码 
	 * @param s
	 * @return
	 */
	private static String getFromBASE64(String s) { 
		String getes = "";//返回值
		if (s == null) return getes; 
		BASE64Decoder decoder = new BASE64Decoder(); 
		try { 
			byte[] b = decoder.decodeBuffer(s); 
			getes = new String(b);
			return getes; 
		} catch (Exception e) { 
			System.out.println(new java.util.Date() + "--" + e.getMessage());
			return getes;  
		} 
	}
	/**
	 * main
	 * @param args
	 */ 
	public static void main(String args[]){
		ApplyOpenService apply = new ApplyOpenService();
		//apply.updateStatus("885", "administrator", "sweetbox1111.", "true");
		//System.out.println("---"+apply.sendXmls("administrator", "hello@2012"));
		String xmls = "<?xml version=\"1.0\" encoding=\"utf-8\" ?><infoopen><messgaeid>167</messgaeid><operater>0</operater><name>测试6677</name><papertype>身份证</papertype><papernumber>370205197405213513</papernumber><paddress>浦东1111111111111</paddress><postalcode></postalcode><tel>13800138000</tel><peopleemail></peopleemail><companyname></companyname><deputy></deputy><linkman></linkman><companytel></companytel><companypostalcode></companypostalcode><companyemail></companyemail><companyaddress></companyaddress><content>浦东浦东浦东浦东</content><sendtime>2016-11-03</sendtime><filecontent></filecontent><filelength>0</filelength><fileoldname></fileoldname><filenewname></filenewname><fileextension></fileextension><catchnum>PD201600142RPPJA</catchnum><purpose></purpose><free></free><offer>0</offer><getmethod>0</getmethod><dept>XB2</dept><ip>101.231.77.118</ip></infoopen>";
		System.out.println("----"+apply.insertInfoopens(xmls, "administrator", "hello@2012"));
		//String xmls = "<?xml version=\"1.0\" encoding=\"utf-8\"?><infoopenfeedback><messgaeid>42809</messgaeid><status>1</status><feedback>我是回复内容</feedback><isovertime>0</isovertime><finishtime>2016-11-02</finishtime></infoopenfeedback>";
		//System.out.println("返回值======"+apply.sendFeedbackMessage("150",xmls));
		
	}
	
}
