<%@ page contentType="text/html; charset=GBK" %>
<%@include file="../skin/import.jsp"%>
<%
String us_id = request.getParameter("us_id");

//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 
dImpl.delete("tb_user","us_id",us_id);
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

response.sendRedirect("UserList.jsp");
%>
