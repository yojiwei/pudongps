<%@page contentType="text/html; charset=GBK"%>
<%@ page import="java.sql.ResultSet" %>
<%@include file="../../manage/head.jsp"%>
<%
   CDataCn dCn = null;
   CDataImpl dImpl = null;
try
{
   dCn = new CDataCn(); //新建数据库连接对象
   dImpl = new CDataImpl(dCn); //新建数据接口对象

   dCn.beginTrans();

   dImpl.setTableName("forum_post");
   dImpl.setPrimaryFieldName("post_id");
   String lct_id = "-1";
   String post_id=request.getParameter("post_id");
   String fid=request.getParameter("fid");
   String page1=request.getParameter("page");
   String noteid=request.getParameter("noteid");
   dImpl.edit("forum_post","post_id",Integer.parseInt(post_id));
   
   dImpl.setValue("post_flag","0",CDataImpl.STRING);	
   dImpl.update(); 
%>

<html>
<head>
<link href="../style.css" rel="stylesheet" type="text/css">
<link href="/system/app/skin/skin3/images/style.css" rel="stylesheet" type="text/css">
<title>上海浦东网站后台管理系统</title>
</head>

<body>


</body>
</html>
<%
if (dCn.getLastErrString().equals(""))
{
	dCn.commitTrans();
	out.println("<script language='javascript'>");
	out.println("alert('"+"已成功取消审核！"+"');");	out.println("window.location.href='shownote_smzx.jsp?checkDel=true&fid="+fid+"&noteid="+noteid+"&page="+page1+"'");
	out.println("</script>");
}
else
{
	dCn.rollbackTrans();
	out.println("<script language='javascript'>");
	out.print("alert('取消审核失败！');");
	out.print("window.history.back();");
	out.println("</script>");
}
}
catch(Exception e)
{
	
	out.print(e.toString());
}
finally
{
	dImpl.closeStmt();
     dCn.closeCn();
}
%>