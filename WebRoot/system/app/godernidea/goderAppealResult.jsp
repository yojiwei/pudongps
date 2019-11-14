<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/import.jsp"%>
<%@page import="com.util.CMessage"%>
<%
  CDataCn dCn = null; //新建数据库连接对象
  CDataImpl dImpl = null; //新建数据接口对象
  CDataImpl dImpl_conn = null; //新建数据接口对象
  try{
  	dCn = new CDataCn();
    dImpl = new CDataImpl(dCn);
  	dImpl_conn = new CDataImpl(dCn);
  	
  	String strStatus = CTools.dealString(request.getParameter("cw_status"));//投诉完成
  	String cw_id = CTools.dealString(request.getParameter("cw_id"));
  	String cw_parentid = CTools.dealString(request.getParameter("cw_parentid"));
  	String cw_subject = CTools.dealString(request.getParameter("strSubject"));
  	String ma_title = cw_subject+"：处理完成";
  	String ma_content = CTools.dealString(request.getParameter("strFeedback"));
  	String finishtime =  CTools.dealString(request.getParameter("cw_finishtime"));
  	String cw_emailtype = CTools.dealString(request.getParameter("cw_emailtype"));//信箱类型
  	if(ma_content.equals(""))
  	ma_content = "回复已经通过E-mail反馈给您了！";
  	
  	String deptconn = CTools.dealString(request.getParameter("deptconn"));
	  
  dCn.beginTrans();

  String sqlStr = "select cw_applyingname,us_id from tb_connwork where cw_id='"+cw_id+"'";
  String receiverId = "";
  String receiverName ="";
  String senderId = "";
  String senderName = ""; 
  String senderDtId = "";
  String senderDesc = "";
  String temp_feedback = "";
 
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
	if(!receiverId.equals("")){
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
 }
}

  if(!deptconn.equals(""))
  {
  	dImpl_conn.addNew("tb_connwork","cw_id",CDataImpl.PRIMARY_KEY_IS_VARCHAR);//新增网上咨询
  	dImpl_conn.setValue("cp_id","o11000",CDataImpl.STRING);//事项id
  	dImpl_conn.setValue("cw_applyingname",CTools.dealString(request.getParameter("applyname").trim()),CDataImpl.STRING);
	dImpl_conn.setValue("cw_applyingdept",CTools.dealString(request.getParameter("applydept").trim()),CDataImpl.STRING);
	dImpl_conn.setValue("cw_applytime",finishtime,CDataImpl.DATE); //投诉时间
	dImpl_conn.setValue("cw_finishtime",finishtime,CDataImpl.DATE); //投诉时间
	dImpl_conn.setValue("cw_status","18",CDataImpl.INT); //投诉状态
	dImpl_conn.setValue("cw_isovertime","0",CDataImpl.INT); //投诉状态
	dImpl_conn.setValue("cw_isstat","0",CDataImpl.INT); //投诉状态
	
	dImpl_conn.setValue("us_id",CTools.dealString(request.getParameter("us_id")),CDataImpl.STRING);//投诉人
	dImpl_conn.setValue("cw_email",CTools.dealString(request.getParameter("strEmail").trim()),CDataImpl.STRING);//投诉人Email
	dImpl_conn.setValue("cw_telcode",CTools.dealString(request.getParameter("strTel").trim()),CDataImpl.STRING);//投诉人Email
	
	dImpl_conn.setValue("cw_subject","金点子信箱:"+CTools.dealString(request.getParameter("strSubject")),CDataImpl.STRING);
	//dImpl_conn.setValue("cw_code",CTools.dealString(request.getParameter("cp_id").trim()),CDataImpl.STRING);//投诉主题
	//out.println("----------"+ma_title);
	//if(true)return;
	dImpl_conn.setValue("cw_transmittime",finishtime,CDataImpl.DATE);//部门转发时间
	dImpl_conn.setValue("cw_parentid",cw_id,CDataImpl.STRING);//转发源记录
	dImpl_conn.setValue("cw_emailtype",cw_emailtype,CDataImpl.STRING);
	
	dImpl_conn.setValue("cw_managetime",finishtime,CDataImpl.DATE); //
	dImpl_conn.setValue("cw_trans_id",deptconn,CDataImpl.STRING); //
	dImpl_conn.update();
	dImpl_conn.setClobValue("cw_content",CTools.dealString(request.getParameter("strContent")));//投诉内容
	dImpl_conn.setClobValue("cw_feedback",ma_content);//投诉反馈
  }

  dCn.commitTrans();

  response.sendRedirect("goderAppealInfo.jsp");
  
} catch (Exception ex) {
	System.out.println(new java.util.Date() + "--"
			+ request.getServletPath() + " : " + ex.getMessage());
} finally {
  dImpl_conn.closeStmt();
  dImpl.closeStmt();
  dCn.closeCn();
}
   
%>

