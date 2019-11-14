<%@page contentType="text/html; charset=GBK"%>
<%@page import="java.sql.*"%>
<%@page import="java.io.*"%>
<%@page import="java.util.*"%>
<%@page import="com.component.database.*"%>
<%@page import="com.util.*"%>

<%
String strId;
strId=request.getParameter("strId");
//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 
try
{
  dImpl.delete("tb_initparameter","ip_id",Integer.parseInt(strId));

  dImpl.closeStmt();
  dCn.closeCn();

  out.println("成功删除！");

  response.sendRedirect("parameterList.jsp");
}
catch(Exception e)
{
  out.println("error message:" + e.toString());
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