<%@ page contentType="text/html; charset=GBK" %>
<%@include file="/system/app/skin/import.jsp"%>
<%
CMySelf self = (CMySelf)session.getAttribute("mySelf");
String selfdtid = String.valueOf(self.getDtId());
String sender_id = String.valueOf(self.getMyID());

String cw_id = "";
String cp_id = "";
String co_id = "";
String co_corropioion = "";

cw_id = CTools.dealString(request.getParameter("cw_id")).trim();
co_id = CTools.dealString(request.getParameter("co_id")).trim();
co_corropioion = CTools.dealString(request.getParameter("co_corropioion")).trim();

//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 
//操作涉及到tb_correspond 暂存
dCn.beginTrans();

//往投诉协同表里加数据
dImpl.edit("tb_correspond","co_id",co_id);
dImpl.setValue("co_status","1",CDataImpl.STRING);
dImpl.update();
dImpl.setClobValue("co_corropioion",co_corropioion);//投诉反馈

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
response.sendRedirect("SignedCorrList.jsp");
%>