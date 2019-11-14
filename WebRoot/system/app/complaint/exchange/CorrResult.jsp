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

out.println(co_id);
cw_id = CTools.dealString(request.getParameter("cw_id")).trim();
co_id = CTools.dealString(request.getParameter("co_id")).trim();
co_corropioion = CTools.dealString(request.getParameter("co_corropioion")).trim();
de_id = CTools.dealString(request.getParameter("de_id")).trim();
Receiverid = CTools.dealString(request.getParameter("senderid")).trim();
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
dImpl.setValue("cw_status","4",CDataImpl.INT);
dImpl.update();

//往投诉协同表里加数据
dImpl.edit("tb_correspond","co_id",co_id);
dImpl.setValue("co_status","3",CDataImpl.STRING);
dImpl.update();
dImpl.setClobValue("co_corropioion",co_corropioion);//投诉反馈

//往文件交换箱中加数据
dImpl.edit("tb_documentexchange","de_id",de_id);
dImpl.setValue("de_status","4",CDataImpl.STRING);
dImpl.setValue("de_senddeptid",selfdtid,CDataImpl.STRING);
dImpl.setValue("de_receiverdeptid",Receiverid,CDataImpl.STRING);
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
dImpl.closeStmt();
dCn.closeCn();
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