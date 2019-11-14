<%@page contentType="text/html; charset=GBK"%>
<%@page import="java.sql.*"%>
<%@page import="java.io.*"%>
<%@page import="java.util.*"%>
<%@page import="com.component.database.*"%>
<%@page import="com.util.*"%>
<%
String cl_id;
cl_id=CTools.dealNumber(request.getParameter("cl_id")).trim();
//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 
try
{
  dImpl.delete("tb_consultation","cl_id",Integer.parseInt(cl_id));

  dImpl.closeStmt();
  dCn.closeCn();

 // out.println("成功删除！");

  response.sendRedirect("SulList.jsp");
}
catch(Exception e)
{
  out.println("error message:" + e.getMessage());
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
