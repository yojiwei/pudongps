<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/system/app/skin/head.jsp"%>
<%
//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 


String de_id="";
String co_id="";
String cf_id="";

de_id = CTools.dealString(request.getParameter("de_id")).trim();
co_id = CTools.dealString(request.getParameter("co_id")).trim();
cf_id = CTools.dealString(request.getParameter("cf_id")).trim();
//out.println(de_id);

dCn.beginTrans();

dImpl.edit("tb_correspond","co_id",co_id);
dImpl.setValue("co_status","1",CDataImpl.STRING);
dImpl.update();

dImpl.edit("tb_correspondfrozen","cf_id",cf_id);
dImpl.setValue("cf_endtime",(new java.util.Date()).toLocaleString(),CDataImpl.DATE);
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

response.sendRedirect("/system/app/cooperate/CorrFrozenList.jsp");
%>
<%@include file="/system/app/skin/bottom.jsp"%>