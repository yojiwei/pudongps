<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/system/app/skin/head.jsp"%>
<%
CDataCn dCn = new CDataCn(); //新建数据库连接对象
CDataImpl dImpl = new CDataImpl(dCn); //新建数据接口对象
String em_id = CTools.dealString(request.getParameter("em_id")).trim();
try
{
  dImpl.delete("tb_examine1","em_id",em_id);

  dImpl.closeStmt();
  dCn.closeCn();

  out.println("成功删除！");
  response.sendRedirect("Message.jsp");
}
catch(Exception e)
{
  out.println("error message:" + e.getMessage());
}
%>
<%
dImpl.closeStmt();
dCn.closeCn();
%>
<%@include file="/system/app/skin/bottom.jsp"%>