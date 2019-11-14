<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/import.jsp"%>
<%@page import="com.util.CMessage"%>
<%
//java.util.Date FinishTime = new java.util.Date();
String FinishTime = CDate.getNowTime();
CDataCn dCn = new CDataCn(); //新建数据库连接对象
CDataImpl dImpl = new CDataImpl(dCn); //新建数据接口对象
CDataImpl dImpl_conn = new CDataImpl(dCn); //新建数据接口对象

//---------附件update by dongliang ----
com.jspsmart.upload.SmartUpload uploader = new com.jspsmart.upload.SmartUpload();
uploader.initialize(pageContext);
uploader.setDeniedFilesList("exe,bat,jsp");
uploader.upload();


String strStatus = "";					//投诉状态，１：待处理信件；２，处理中信件；３．已处理信件
String cw_subject = "";
String cw_parentid = "";
String deptconn="";
String ma_content="";
  String cw_isopen = "";

strStatus = request.getParameter("cw_status");

cw_subject = CTools.dealUploadString(uploader.getRequest().getParameter("strSubject")).trim();

ma_content = CTools.dealUploadString(uploader.getRequest().getParameter("strFeedback")).trim();

cw_parentid = CTools.dealUploadString(uploader.getRequest().getParameter("cw_parentid")).trim();
  cw_isopen = CTools.dealUploadString(uploader.getRequest().getParameter("cw_isopen")).trim();
deptconn = CTools.dealUploadString(uploader.getRequest().getParameter("deptconn")).trim();
//---------update by dongliang -----
String cw_id = request.getParameter("cw_id").toString();
String ma_title = cw_subject+"：您的信访事项有最新反馈信息，请登录“上海浦东”门户网站或通过电子邮件查询。";
if(ma_content.equals(""))
ma_content = "回复已经通过E-mail反馈给您了！";

dCn.beginTrans();

String receiverId = "";
String receiverName ="";
String senderId = "";
String senderName = "";
String senderDtId = "";
String senderDesc = "";
String strTitle = "给申请人发消息";
String sql_conn="";
String temp_feedback="";
String temp_status ="";
Hashtable content_conn=null;
//-------------新增---------------
String wa_path = ""; 
String path = dImpl.getInitParameter("workattach_save_path");
//String ispublish = CTools.dealString(request.getParameter("ispublish"));
if ("".equals(cw_parentid)) {
	cw_parentid = cw_id;
  }
com.app.CMySelf mySelf = (com.app.CMySelf)session.getAttribute("mySelf");

if (mySelf!=null&&mySelf.isLogin())
{
	senderId = Long.toString(mySelf.getMyID());
	senderName = mySelf.getMyName();
	senderDtId = Long.toString(mySelf.getDtId());
}

String sql_dt = "select dt_name from tb_deptinfo where dt_id="+senderDtId;
Hashtable content1 = dImpl.getDataInfo(sql_dt);
if (content1!=null)
{
	senderDesc = content1.get("dt_name").toString();
}
String sqlStr = "select cw_applyingname,us_id from tb_connwork where cw_id='"+cw_id+"'";
Hashtable content = dImpl.getDataInfo(sqlStr);
if (content!=null)
{
	receiverId = content.get("us_id").toString();
	receiverName = content.get("cw_applyingname").toString();
	//tb_message消息表
	if(!receiverId.equals("")&&!strStatus.equals("9")){
		 ma_content=cw_subject+"&nbsp;&nbsp;"+ma_content;
		 CMessage msg = new CMessage(dImpl);
		 msg.addNew();
		 msg.setValue(CMessage.msgReceiverId,receiverId);
		 msg.setValue(CMessage.msgReceiverName,receiverName);
		 msg.setValue(CMessage.msgTitle,ma_title);
		 msg.setValue(CMessage.msgSenderId,senderId);
		 msg.setValue(CMessage.msgSenderName,senderName);
		 msg.setValue(CMessage.msgSenderDesc,senderDesc);
		 msg.setValue(CMessage.msgIsNew,"1");
		 msg.setValue(CMessage.msgRelatedType,"1");
		 msg.setValue(CMessage.msgPrimaryId,cw_id);
		 msg.setValue(CMessage.msgSendTime,new CDate().getNowTime());
		 msg.setValue(CMessage.msgContent,ma_content);
		 msg.update();
		 out.println(receiverId);
	 }
}

  //转办信件----------------------
  if(!deptconn.equals(""))
  {
		dImpl_conn.addNew("tb_connwork","cw_id",CDataImpl.PRIMARY_KEY_IS_VARCHAR);//新增网上咨询
		dImpl_conn.setValue("cp_id",deptconn,CDataImpl.STRING);//事项id
		dImpl_conn.setValue("cw_applyingname",CTools.dealUploadString(uploader.getRequest().getParameter("applyname")).trim(),CDataImpl.STRING);//投诉人姓名
    dImpl_conn.setValue("cw_applyingdept",CTools.dealUploadString(uploader.getRequest().getParameter("applydept")).trim(),CDataImpl.STRING);//投诉人单位
    dImpl_conn.setValue("cw_applytime",FinishTime,CDataImpl.DATE); //投诉时间
    dImpl_conn.setValue("cw_status","1",CDataImpl.INT); //投诉状态---待处理
    dImpl_conn.setValue("us_id",CTools.dealUploadString(uploader.getRequest().getParameter("us_id")).trim(),CDataImpl.STRING);//投诉人
    dImpl_conn.setValue("cw_email",CTools.dealUploadString(uploader.getRequest().getParameter("strEmail").trim()),CDataImpl.STRING);//投诉人Email
    dImpl_conn.setValue("cw_telcode",CTools.dealUploadString(uploader.getRequest().getParameter("strTel").trim()),CDataImpl.STRING);//投诉人Email
    dImpl_conn.setValue("cw_subject",CTools.dealUploadString(uploader.getRequest().getParameter("strSubject").trim()),CDataImpl.STRING);//投诉主题
    dImpl_conn.setValue("cw_code",CTools.dealUploadString(uploader.getRequest().getParameter("cp_id").trim()).trim(),CDataImpl.STRING);//投诉主题
		dImpl_conn.setValue("cw_addresscode",CTools.dealString(uploader.getRequest().getParameter("cw_addresscode").trim()),CDataImpl.STRING);//投诉主题

		dImpl_conn.setValue("cw_transmittime",FinishTime,CDataImpl.DATE);//部门转发时间
		dImpl_conn.setValue("cw_parentid",cw_parentid,CDataImpl.STRING);
		dImpl_conn.update();
		dImpl_conn.setClobValue("cw_content",uploader.getRequest().getParameter("strContent"));
		 //投诉内容

  }else if("3".equals(strStatus)){  //本信件处理完成

	if (!"".equals(cw_parentid)){
		sql_conn = "select cw_status,cw_feedback,cw_parentid from tb_connwork where cw_parentid ='"+cw_parentid+"' order by cw_id";
		Vector vectorPage = dImpl.splitPage(sql_conn,200,1);				
		if(vectorPage!=null){			
			for(int i=0;i<vectorPage.size();i++)
			{
				content_conn = (Hashtable)vectorPage.get(i);
				temp_status = content_conn.get("cw_status").toString();
				if (!"".equals(content_conn.get("cw_feedback").toString())&&!"2".equals(temp_status)){
					temp_feedback += content_conn.get("cw_feedback").toString()+" -> ";					
				}else{
					if(!"".equals(temp_feedback)) temp_feedback = temp_feedback.substring(0,temp_feedback.length()-4)+"：";					
				} 
			}			
			content_conn = dImpl.getDataInfo("select cw_feedback from tb_connwork where cw_id = '"+cw_parentid+"'");
			if (content_conn!=null){
				if (!"".equals(temp_feedback)){
					temp_feedback = content_conn.get("cw_feedback").toString()+" -> " + temp_feedback;
				}else{
					temp_feedback = content_conn.get("cw_feedback").toString()+"：" + temp_feedback;
				}
			} 
			dImpl_conn.edit("tb_connwork","cw_id",cw_parentid);//确定父记录		
			dImpl_conn.setValue("cw_status","18",CDataImpl.INT);		
			dImpl_conn.update();
			dImpl_conn.setClobValue("cw_feedback",temp_feedback+ma_content);//如果无父记录，同步回复信息
		}
	}
  }
 
  //修改本个网上投诉信件为完成
  dImpl.edit("tb_connwork","cw_id",cw_id);//修改网上投诉
  dImpl.setValue("cw_status",CTools.dealNumber(strStatus),CDataImpl.INT);//投诉状态 3 
  dImpl.setValue("cw_finishtime",FinishTime,CDataImpl.DATE); //处理完成时间
  
  //处理中
  if (strStatus.equals("2"))
		  dImpl.setValue("cw_managetime",FinishTime,CDataImpl.DATE); //开始处理时间
		  dImpl.setValue("cw_trans_id",deptconn,CDataImpl.STRING); //处理的部门
		  dImpl.setValue("cw_isopen",cw_isopen,CDataImpl.STRING); //是否前台显示
		  dImpl.update();
		  dImpl.setClobValue("cw_feedback",ma_content);//投诉反馈


 /* 处理上传附件*/
	 int count = uploader.getFiles().getCount(); 
	 if(count > 0){
		  CDate date = new CDate();
		  String today = date.getThisday();
		  int numeral = 0;
		  numeral = (int)(Math.random()*1000000); 
		  wa_path = today + Integer.toString(numeral);//日期+随机
		  java.io.File fileDir = new java.io.File(path + wa_path);
		
		  if( !fileDir.exists() ){ 
			fileDir.mkdirs(); 
		  }
		
		  int savedCount = uploader.save(path+wa_path);
		  if(savedCount > 0 ){
			String fileName = uploader.getFiles().getFile(0).getFileName();
			java.io.File file = new java.io.File(path + wa_path + "\\" + fileName);
		   			
			int random_filenum =(int)(Math.random()*100000);
			String random_realName = today + Integer.toString(random_filenum) + fileName.substring(fileName.indexOf("."));
			java.io.File random_file = new java.io.File(path + wa_path + "\\" + random_realName);
		    file.renameTo(random_file);
		           
            //将附件信息插入数据库			 
			dImpl.addNew("tb_appealattach","aa_id",CDataImpl.PRIMARY_KEY_IS_VARCHAR);
			if (!"".equals(CTools.dealUploadString(uploader.getRequest().getParameter("cw_parentid")).trim())) {
				dImpl.setValue("cw_id",CTools.dealUploadString(uploader.getRequest().getParameter("cw_parentid")).trim(),CDataImpl.STRING);
			}
			else {
				dImpl.setValue("cw_id",cw_id,CDataImpl.STRING);
			}
			dImpl.setValue("aa_path",wa_path,CDataImpl.STRING);
			dImpl.setValue("aa_fileName",fileName,CDataImpl.STRING);
			dImpl.setValue("dt_id",senderDtId,CDataImpl.STRING);
			dImpl.setValue("dt_name",senderDesc,CDataImpl.STRING);
	        dImpl.setValue("aa_im_name",random_realName,CDataImpl.STRING);//附件随即生成文件名
			dImpl.update();
		  } 	
	 }
  dCn.commitTrans();

  dImpl.closeStmt();
  dImpl_conn.closeStmt();
  dCn.closeCn();
  response.sendRedirect("AppealList.jsp?cw_status=" + strStatus);//3
%>