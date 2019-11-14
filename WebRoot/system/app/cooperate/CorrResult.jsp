<%@ page contentType="text/html; charset=GBK" %>
<%@include file="/system/app/skin/head.jsp"%>
<%@page import="com.component.database.*"%>
<%@page import="com.app.*"%>
<%
String choice="";
String wo_id="";
String pr_id="";
String selfdtid="";
String co_question="";
String co_mainopioion="";
String co_corropioion="";
String corrdt_id="";
String sender_id="";
String pc_timelimit="";
String optype="";
//if(true)return;
CMySelf self = (CMySelf)session.getAttribute("mySelf");
//out.println(self.getDtId());
selfdtid = String.valueOf(self.getDtId());
sender_id = String.valueOf(self.getMyID());

choice=CTools.dealString(request.getParameter("choice")).trim();
wo_id=CTools.dealString(request.getParameter("wo_id")).trim();
pr_id=CTools.dealString(request.getParameter("pr_id")).trim();
co_question=CTools.dealString(request.getParameter("co_question")).trim();
co_mainopioion=CTools.dealString(request.getParameter("co_mainopioion")).trim();
corrdt_id=CTools.dealString(request.getParameter("corrdt_id")).trim();
pc_timelimit = CTools.dealString(request.getParameter("pc_timelimit")).trim();
optype = CTools.dealString(request.getParameter("OPType")).trim();
/*out.println(selfdtid);
out.println(sender_id);
out.println(wo_id);
out.println(pr_id);*/
//out.println(co_question);
//out.println(co_mainopioion);
/*
out.println(corrdt_id);
out.println(pc_timelimit);
*/
//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 

DataDealImpl dDealImpl = new DataDealImpl(dCn.getConnection()); //数据交换实现

dCn.beginTrans();
String co_id = dImpl.addNew("tb_correspond","co_id",CDataImpl.PRIMARY_KEY_IS_VARCHAR);

dImpl.setValue("wo_id",wo_id,CDataImpl.STRING);
dImpl.setValue("co_status","1",CDataImpl.STRING);
dImpl.update();

dImpl.setClobValue("co_question",co_question);
dImpl.setClobValue("co_mainopioion",co_mainopioion);


String de_id = dImpl.addNew("tb_documentexchange","de_id",CDataImpl.PRIMARY_KEY_IS_VARCHAR);

dImpl.setValue("de_type","1",CDataImpl.STRING);
dImpl.setValue("de_primaryid",co_id,CDataImpl.STRING);
dImpl.setValue("de_status","1",CDataImpl.STRING);
dImpl.setValue("de_senddeptid",selfdtid,CDataImpl.STRING);
dImpl.setValue("de_receiverdeptid",corrdt_id,CDataImpl.STRING);
dImpl.setValue("de_sendtime",(new java.util.Date()).toLocaleString(),CDataImpl.DATE);
dImpl.setValue("de_senderid",sender_id,CDataImpl.INT);
dImpl.setValue("de_requesttime",pc_timelimit,CDataImpl.INT);
dImpl.setValue("de_isovertime","0",CDataImpl.STRING);
dImpl.setValue("de_isstat","0",CDataImpl.STRING);

dImpl.update();

dImpl.edit("tb_work","wo_id",wo_id);
dImpl.setValue("wo_status","8",CDataImpl.STRING);
dImpl.update();

if(dCn.getLastErrString().equals(""))
{
  dCn.commitTrans();
}
else
{
  dCn.rollbackTrans();
}
%>
<%
dImpl.closeStmt();
dCn.closeCn();

if(choice.equals("0"))
{
	out.println("<script>alert('协调单已发送，按确定继续协调！')</script>");
	response.sendRedirect("/system/app/cooperate/CorrForm.jsp?OPType=Corragain&wo_id="+wo_id+"&pr_id="+pr_id);
}
else
{
	if(optype.equals("Corr"))
	{
		out.println("<script>alert('协调单已发送，按确定返回！');</script>");
		out.println("<script>window.close();</script>");
		out.println("<script>window.opener.location.href='/system/app/dealwork/WaitList.jsp';</script>");
	}
	else
	{
		out.println("<script>alert('协调单已发送，按确定返回！');</script>");
		out.println("<script>window.close();</script>");
		out.println("<script>window.location.href='/system/app/dealwork/CorringList.jsp';</script>");
	}
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

%>
<%@include file="/system/app/skin/bottom.jsp"%>
