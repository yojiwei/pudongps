<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/system/app/skin/head.jsp"%>
<%
//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 

String em_id = CTools.dealString(request.getParameter("em_id")).trim();
try
{
  dImpl.delete("tb_examine","em_id",em_id);

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