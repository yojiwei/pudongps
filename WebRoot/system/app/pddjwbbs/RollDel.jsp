<%@ page contentType="text/html; charset=GBK" %>
<%@include file="../skin/import.jsp"%>
<%
String ro_id = CTools.dealString(request.getParameter("ro_id")).trim();

//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 	dCn = new CDataCn("pddjw"); 
 	dImpl = new CDataImpl(dCn); 
	dImpl.delete("forum_roll","ro_id",ro_id);
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

response.sendRedirect("RollList.jsp");
%>
