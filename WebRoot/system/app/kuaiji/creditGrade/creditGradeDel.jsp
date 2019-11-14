
<%@page contentType="text/html; charset=GBK"%>
<%@page import="java.sql.*"%>
<%@page import="java.io.*"%>
<%@page import="java.util.*"%>
<%@page import="com.component.database.*"%>
<%@page import="com.util.*"%>
<%@include file="/system/app/skin/import.jsp"%>

<%
/*定义变量  开始*/
String cg_id="";
/*定义变量  结束*/
/*获取参数  开始*/
cg_id=CTools.dealString(request.getParameter("cg_id")).trim();//主键
/*获取参数  结束*/
/*程序主体  开始*/
//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 
//end
try
{
  dImpl.delete("tb_kjcreditgrade","cg_id",cg_id);
  dImpl.update();
  dImpl.closeStmt();
  dCn.closeCn();
  out.println("成功删除！");
  response.sendRedirect("creditGradeList.jsp");
}
catch(Exception e)
{
  out.println("error message:" + e.getMessage());
}
/*程序主体  结束*/
%>
<%@include file="/system/app/skin/bottom.jsp"%>
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
