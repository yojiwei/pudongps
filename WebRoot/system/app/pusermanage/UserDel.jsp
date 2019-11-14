<%@ page contentType="text/html; charset=GBK" %>
<%@include file="../skin/import.jsp"%>
<%
String us_id = request.getParameter("us_id");

CDataCn dCn=new CDataCn();
CDataImpl dImpl=new CDataImpl(dCn);

dImpl.delete("tb_user","us_id",us_id);
dImpl.closeStmt();
dCn.closeCn();

response.sendRedirect("UserList.jsp");
%>
