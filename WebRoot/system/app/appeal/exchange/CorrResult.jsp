<%@ page contentType="text/html; charset=GBK" %>
<%@include file="/system/app/skin/import.jsp"%>
<%
CMySelf self = (CMySelf)session.getAttribute("mySelf");
String selfdtid = String.valueOf(self.getDtId());
String sender_id = String.valueOf(self.getMyID());

java.util.Date FeedbackTime = new java.util.Date();
String cw_id = "";
String cp_id = "";
String co_id = "";
String de_id = "";
String co_mainopioion = "";
String co_corropioion = "";
String Receiverid = "";
String Timelimit = "";
String cp_upid = "";

String cw_subject = CTools.dealString(request.getParameter("strSubject"));
String mail_add = CTools.dealString(request.getParameter("strEmail"));
String ma_title = cw_subject+"：处理完成";
String ma_content = CTools.dealString(request.getParameter("cw_fb"));

cw_id = CTools.dealString(request.getParameter("cw_id")).trim();
co_id = CTools.dealString(request.getParameter("co_id")).trim();
co_corropioion = CTools.dealString(request.getParameter("co_corropioion")).trim();
de_id = CTools.dealString(request.getParameter("de_id")).trim();
Receiverid = CTools.dealString(request.getParameter("senderid")).trim();
cp_upid = CTools.dealString(request.getParameter("cp_upid")).trim();
co_mainopioion = CTools.dealString(request.getParameter("co_mainopioion")).trim();
out.println(co_mainopioion);
//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 
//操作涉及到tb_connwork,tb_correspond
dCn.beginTrans();

//往互动表里加数据
dImpl.edit("tb_connwork","cw_id",cw_id);
if(cp_upid.equals("o13"))
{
	dImpl.setValue("cw_status","3",CDataImpl.INT);
	dImpl.setValue("cw_finishtime",FeedbackTime.toLocaleString(),CDataImpl.DATE);
}
else
{
	dImpl.setValue("cw_status","4",CDataImpl.INT);
}
dImpl.update();
if(cp_upid.equals("o13"))
{
	dImpl.setClobValue("cw_feedback",CTools.dealString(request.getParameter("cw_fb")).trim());//投诉反馈

	if(!mail_add.equals(""))
	{
	dImpl.addNew("tb_sendmail","sm_id",CDataImpl.PRIMARY_KEY_IS_VARCHAR);
	dImpl.setValue("sm_subject",ma_title,CDataImpl.STRING);
	dImpl.setValue("sm_mailadd","webmaster@pudong.gov.cn",CDataImpl.STRING);
	dImpl.setValue("sm_issend","0",CDataImpl.STRING);
	dImpl.setValue("sm_receiver",mail_add,CDataImpl.STRING);
	dImpl.setValue("cw_id",cw_id,CDataImpl.STRING);
	dImpl.update();
	dImpl.setClobValue("sm_content",ma_content);//投诉反馈
	}

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
		out.println(receiverId);
		}
		}
}

//往投诉协同表里加数据
dImpl.edit("tb_correspond","co_id",co_id);
dImpl.setValue("co_status","3",CDataImpl.STRING);
dImpl.update();
dImpl.setClobValue("co_corropioion",co_corropioion);//投诉反馈

//往文件交换箱中加数据
dImpl.edit("tb_documentexchange","de_id",de_id);
if(cp_upid.equals("o13"))
{
	dImpl.setValue("de_status","5",CDataImpl.STRING);
	dImpl.setValue("de_feedbacksigntime",FeedbackTime.toLocaleString(),CDataImpl.DATE);
}
else
{
	dImpl.setValue("de_status","4",CDataImpl.STRING);
	dImpl.setValue("de_senddeptid",selfdtid,CDataImpl.INT);
	dImpl.setValue("de_receiverdeptid",Receiverid,CDataImpl.INT);
}

dImpl.setValue("de_fbsignerid",sender_id,CDataImpl.INT);
dImpl.setValue("de_feedbacktime",FeedbackTime.toLocaleString(),CDataImpl.DATE);
dImpl.update();

if(dCn.getLastErrString().equals(""))
{
  dCn.commitTrans();
}
else
{
  dCn.rollbackTrans();
}
} catch (Exception ex) {
	System.out.println(new java.util.Date() + "--"
			+ request.getServletPath() + " : " + ex.getMessage());
} finally {
	if(dImpl != null)
	dImpl.closeStmt();
	if(dCn != null)
	dCn.closeCn();
}
response.sendRedirect("CorrExchange.jsp");
%>