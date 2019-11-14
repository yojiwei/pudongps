<%@ page contentType="text/html; charset=GBK" %>
<%@include file="/system/app/skin/head.jsp"%>
<%@page import="com.component.database.*"%>
<%@page import="com.app.*"%>

<%
String sqlRe="";
String co_id="";
String de_id="";
String co_corropioion="";
String choice="";
String de_receiverdeptid="";
String selfdtid="";
String sender_id="";
String de_senddeptid="";
String optype="";

co_id=CTools.dealString(request.getParameter("co_id")).trim();
de_id=CTools.dealString(request.getParameter("de_id")).trim();
co_corropioion=CTools.dealString(request.getParameter("co_corropioion")).trim();
choice=CTools.dealString(request.getParameter("choice")).trim();
de_receiverdeptid=CTools.dealString(request.getParameter("de_senddeptid")).trim();
optype=CTools.dealString(request.getParameter("OPType")).trim();
//out.println(choice);
//out.println(de_senddeptid);

CMySelf self = (CMySelf)session.getAttribute("mySelf");
//out.println(self.getDtId());
selfdtid = String.valueOf(self.getDtId());
sender_id = String.valueOf(self.getMyID());
//out.println(selfdtid);
//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 

dCn.beginTrans();

dImpl.edit("tb_correspond","co_id",co_id);
if(choice.equals("0"))
{
	dImpl.setValue("co_status","3",CDataImpl.STRING);
    
}
else if(choice.equals("1"))
{
	dImpl.setValue("co_status","4",CDataImpl.STRING);

}
else if(choice.equals("2"))
{
	dImpl.setValue("co_status","2",CDataImpl.STRING);
}
else 	
{
	dImpl.setValue("co_status","1",CDataImpl.STRING);
}
dImpl.update();
dImpl.setClobValue("co_corropioion",co_corropioion);

dImpl.edit("tb_documentexchange","de_id",de_id);
//out.print(de_id);
if(choice.equals("0")||choice.equals("1"))
{
	//out.print("selfdtid="+selfdtid+"<br>");
	//out.print("de_receiverdeptid="+de_receiverdeptid+"<br>");
	//out.print("sender_id"+sender_id+"<br>");
	//out.print("ok");
	dImpl.setValue("de_status","4",CDataImpl.STRING);
	dImpl.setValue("de_senddeptid",selfdtid,CDataImpl.INT);
	dImpl.setValue("de_receiverdeptid",de_receiverdeptid,CDataImpl.INT);
	dImpl.setValue("de_feedbacktime",(new java.util.Date()).toLocaleString(),CDataImpl.DATE);
	dImpl.setValue("de_fbsenderid",sender_id,CDataImpl.INT);
}
else
{
	//out.print("asdfasd");
	dImpl.setValue("de_status","2",CDataImpl.STRING);
}
dImpl.update();


//out.println(dCn.getLastErrString());
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
} catch (Exception ex) {
	System.out.println(new java.util.Date() + "--"
			+ request.getServletPath() + " : " + ex.getMessage());
} finally {
	if(dImpl != null)
	dImpl.closeStmt();
	if(dCn != null)
	dCn.closeCn();
}
if(optype.equals("Recorr"))
{
	response.sendRedirect("/system/app/docexchange/CorrExchange.jsp");
}
else
{
	response.sendRedirect("/system/app/cooperate/SignedCorrList.jsp");
}
%>
<%@include file="/system/app/skin/bottom.jsp"%>
