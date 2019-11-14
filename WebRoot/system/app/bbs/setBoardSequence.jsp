<%@ page contentType="text/html; charset=GBK" %>
<%@ page import="com.component.database.*" %>
<%@ page import="java.io.*" %>


<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%@page import="com.util.*"%>
<%
boolean b = false;
String curpage = CTools.dealString(request.getParameter("curPage")).trim();

//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl jdo=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 jdo = new CDataImpl(dCn); 

jdo.setTableName("forum_board");
jdo.setPrimaryFieldName("fm_id");
b = jdo.setSequence("boardid","fm_sequence",request);
dCn.closeCn();
} catch (Exception ex) {
	System.out.println(new java.util.Date() + "--"
			+ request.getServletPath() + " : " + ex.getMessage());
} finally {
	if(jdo != null)
	jdo.closeStmt();
	if(dCn != null)
	dCn.closeCn();
}
response.sendRedirect("board_manager.jsp?page="+curpage);
%>