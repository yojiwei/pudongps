<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%@page import="com.util.*"%>
<%
String wo_id = "";
String sqlStr = "";
wo_id = CTools.dealString(request.getParameter("id")).trim();

CDataCn dCnWSB=null;   //新建数据库连接对象
CDataImpl dImplWSB=null;  //新建数据接口对象

try{
	
	dCnWSB = new CDataCn(); 
	dImplWSB = new CDataImpl(dCnWSB);

	dImplWSB.edit("TB_PROCEEDINGCONTROL_NEW","id",wo_id);
	dImplWSB.setValue("status","1",CDataImpl.STRING);
	dImplWSB.update();


}catch(Exception e){
	System.out.println("update fail!" + e.getMessage());
}finally{
	dImplWSB.closeStmt();
	dCnWSB.closeCn();
}
out.print("<SCRIPT LANGUAGE=\"JavaScript\">");
out.print("window.location='ProceedingMonitoringList.jsp'");
out.print("</SCRIPT>");
%>