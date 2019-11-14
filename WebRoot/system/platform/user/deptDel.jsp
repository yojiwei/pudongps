<%
/**************************************
this page is made by honeyday 2002-12-6
***************************************/
%>
<%@page contentType="text/html; charset=GBK"%>
<%@page import="java.sql.*"%>
<%@page import="java.io.*"%>
<%@page import="java.util.*"%>
<%@page import="com.component.database.*"%>
<%@page import="com.util.*"%>
<%

String dd_id="";//编号
String dd_name="";//名称
String dt_id="0";//父id
String dt_iswork="0";//活动标志
String strSql="";		//判断部门重复的SQL语句

dd_id=CTools.dealNumber(request.getParameter("dd_id")).trim();
dd_name=CTools.dealString(request.getParameter("dd_name")).trim();
dt_id=CTools.dealNumber(request.getParameter("dt_id")).trim();
dt_iswork=CTools.dealNumber(request.getParameter("dt_iswork")).trim();

//out.print(dd_id);

//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 
try
{
  dImpl.setTableName("tb_deptinfo");
  dImpl.setPrimaryFieldName("dt_id");
	dImpl.delete(dd_id);
  
  dImpl.closeStmt();
  dCn.closeCn();
  String urlRedirect="userList.jsp?list_id="+dt_id;
  response.sendRedirect(urlRedirect);

}
catch(Exception e)
{
  out.println("error message:" + e.toString()) ;
}

%>
<%


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