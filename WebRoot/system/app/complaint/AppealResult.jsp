<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/import.jsp"%>
<%@page import="com.util.CMessage"%>
<%
  //java.util.Date FinishTime = new java.util.Date();
  String FinishTime = CDate.getNowTime();
  //System.out.println("a"+FinishTime.toLocaleString()+"a");
 
  CDataCn dCn = new CDataCn(); //新建数据库连接对象
  CDataImpl dImpl = new CDataImpl(dCn); //新建数据接口对象
  String strStatus = request.getParameter("cw_status").toString();//投诉完成
  String cw_id = request.getParameter("cw_id").toString();
   
  String cw_subject = CTools.dealString(request.getParameter("strSubject"));
  String cw_parentid = request.getParameter("cw_parentid").toString();
  String ma_title = cw_subject+"：您的信访事项有最新反馈信息，请登录“上海浦东”门户网站或通过电子邮件查询。";
  String ma_content = CTools.dealString(request.getParameter("strFeedback"));
  String cw_number = CTools.dealString(request.getParameter("cw_number"));
  String cw_emailtype = CTools.dealString(request.getParameter("cw_emailtype"));//信箱类型
  String deptconn = CTools.dealString(request.getParameter("deptconn"));
  if(ma_content.equals(""))
  ma_content = "回复已经通过E-mail反馈给您了！";

  dCn.beginTrans();

String sqlStr = "select cw_applyingname,us_id from tb_connwork where cw_id='"+cw_id+"'";
String receiverId = "";
String receiverName ="";
String senderId = "";
String senderName = "";
String senderDtId = "";
String senderDesc = "";
String strTitle = "给申请人发消息";

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

Hashtable content = dImpl.getDataInfo(sqlStr);
if (content!=null)
{
	receiverId = content.get("us_id").toString();
	receiverName = content.get("cw_applyingname").toString();
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
	//out.println(receiverId);
 }
}

 if(!deptconn.equals("")&&strStatus.equals("8"))
  {
  	dImpl.addNew("tb_connwork","cw_id",CDataImpl.PRIMARY_KEY_IS_VARCHAR);//新增网上咨询
  	dImpl.setValue("cp_id",deptconn,CDataImpl.STRING);//事项id
    	dImpl.setValue("cw_applyingname",CTools.dealString(request.getParameter("applyname").trim()),CDataImpl.STRING);//投诉人姓名
		dImpl.setValue("cw_applyingdept",CTools.dealString(request.getParameter("applydept").trim()),CDataImpl.STRING);//投诉人单位

        dImpl.setValue("cw_applytime",FinishTime,CDataImpl.DATE); //投诉时间
        dImpl.setValue("cw_status","1",CDataImpl.INT); //投诉状态
        dImpl.setValue("us_id",CTools.dealString(request.getParameter("us_id")),CDataImpl.STRING);//投诉人
        dImpl.setValue("cw_email",CTools.dealString(request.getParameter("strEmail").trim()),CDataImpl.STRING);//投诉人Email
        dImpl.setValue("cw_telcode",CTools.dealString(request.getParameter("strTel").trim()),CDataImpl.STRING);//投诉人Email
        dImpl.setValue("cw_subject",CTools.dealString(request.getParameter("strSubject").trim()),CDataImpl.STRING);//投诉主题
	
        dImpl.setValue("cw_code",CTools.dealString(request.getParameter("cp_id").trim()),CDataImpl.STRING);//投诉主题
		dImpl.setValue("cw_transmittime",FinishTime,CDataImpl.DATE);//部门转发时间
		if("".equals(cw_parentid)){
		dImpl.setValue("cw_parentid",cw_id,CDataImpl.STRING);}
		else{
			dImpl.setValue("cw_parentid",CTools.dealString(request.getParameter("cw_parentid").trim()),CDataImpl.STRING);
			}
		dImpl.setValue("dd_id",CTools.dealString(request.getParameter("dd_id").trim()),CDataImpl.STRING);
		dImpl.setValue("cw_ispublish",CTools.dealString(request.getParameter("cw_ispublish").trim()),CDataImpl.STRING);
		dImpl.setValue("cw_emailtype",cw_emailtype,CDataImpl.STRING);
        dImpl.update();
        dImpl.setClobValue("cw_content",CTools.dealString(request.getParameter("strContent")));//投诉内容
  }

  dImpl.edit("tb_connwork","cw_id",cw_id);//修改网上投诉
  dImpl.setValue("cw_status",CTools.dealNumber(strStatus),CDataImpl.INT);//投诉状态
  dImpl.setValue("cw_number",cw_number,CDataImpl.STRING);//投诉状态
  dImpl.setValue("cw_finishtime",FinishTime,CDataImpl.DATE); //处理完成时间
  if (strStatus.equals("2")) dImpl.setValue("cw_managetime",FinishTime,CDataImpl.DATE); //开始处理时间
  dImpl.update();
 
  dImpl.setClobValue("cw_feedback",CTools.dealString(request.getParameter("strFeedback")));//投诉反馈

  out.println(request.getParameter("strFeedback"));
  dCn.commitTrans();
  dImpl.closeStmt();
  dCn.closeCn();
   if (!"".equals(deptconn)){
  	response.sendRedirect("AppealList.jsp?cw_status=8");
   }else{
   	response.sendRedirect("AppealList.jsp?cw_status=" + strStatus);
   }
%>

