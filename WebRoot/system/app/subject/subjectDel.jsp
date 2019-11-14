<%
/*
栏目删除页面
by honeyday 2002-12-4

*/
%>
<%@page contentType="text/html; charset=GBK"%>
<%@page import="java.sql.*"%>
<%@page import="java.io.*"%>
<%@page import="java.util.*"%>
<%@page import="com.component.database.*"%>
<%@page import="com.util.*"%>
<%
/*定义变量  开始*/
String strId="";
String SJ_parentid="0";//父id
/*定义变量  结束*/
/*获取参数  开始*/
strId=CTools.dealNumber(request.getParameter("strId")).trim();//
SJ_parentid=CTools.dealString (request.getParameter("sj_id"));
/*获取参数  结束*/
/*程序主体  开始*/
//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 

//dImpl.hasSubObject(); //判断该项目的下面是否有子项，如果有则不允许删除！
boolean aa;

aa=dImpl.hasSubObject("tb_subject","sj_parentid",Long.parseLong(strId));
if (aa)
{
  out.print("<script>");
  out.print("alert('该项目下包含有子项目，在子项目没有完全删除前将无法删除该项目！');");
  out.print("window.location='subjectList.jsp?sj_id="+ SJ_parentid+"';");
  out.print("</script>");
}
else
{

  try
  {
    dImpl.delete("tb_subject","sj_id",Integer.parseInt(strId));

    dImpl.closeStmt();
    dCn.closeCn();
    out.print("<script>");
    out.print("alert('成功删除！');");
    out.print("window.location='subjectList.jsp?sj_id="+ SJ_parentid+"';");
    out.print("</script>");
    //response.sendRedirect("subjectList.jsp");
  }
  catch(Exception e)
  {
    out.println("error message:" + e.getMessage());
  }
}
/*程序主体  结束*/

	session.setAttribute("_InfoSubject","");
%>

<%@include file="../skin/bottom.jsp"%>
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

