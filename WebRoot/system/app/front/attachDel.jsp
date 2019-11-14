<%@page contentType="text/html; charset=GBK"%>
<%@ include file="../skin/head.jsp"%>
<%@ page import="com.beyondbit.web.publishinfo.Messages" %>
<%@ page import="java.io.FileFilter" %>
<%@ page import="java.io.FileDescriptor" %>
<%@ page import="java.io.File" %>

<%
String path              = "";
String frim_filename     = "";
String frim_path		 = "";
String fi_id			 = "";
String frim_id			 = "";
String list_id			 = "";

String sqlStr            = "";

fi_id = CTools.dealString(request.getParameter("fi_id")).trim();
list_id = CTools.dealString(request.getParameter("list_id")).trim();
CDataCn dCn = new CDataCn(); //新建数据库连接对象
CDataImpl dImpl = new CDataImpl(dCn); //新建数据接口对象

sqlStr = "select frim_path,frim_filename,frim_id from tb_frontinfo_image where fi_id='"+fi_id+"'";
Hashtable content = dImpl.getDataInfo(sqlStr);
if (content!=null)
{
					frim_path = content.get("frim_path").toString();
					frim_filename = content.get("frim_filename").toString();
					frim_id = content.get("frim_id").toString();
					//删除记录
					dImpl.delete("tb_frontinfo_image","frim_id",frim_id);
				
}
path = dImpl.getInitParameter("front_save_path");//得到路径
dImpl.closeStmt();
dCn.closeCn();

boolean successDel=false;
java.io.File newDir = new java.io.File(path + frim_path);
File flies = null;
if(newDir.exists()&&newDir.isDirectory())
{
	String [] list = newDir.list();
	for(int i=0;i<list.length;i++)
	{		
		flies = new File(path + frim_path+"\\"+list[i]);
		flies.delete();
	}
	successDel=newDir.delete();
}

	
out.print("<SCRIPT LANGUAGE=\"JavaScript\">");
if (!successDel)
{
	out.print("alert('删除该文件时失败！');");
	out.print("window.history.go(-1);");
}
else
{	dImpl.delete(frim_id);
	out.print("alert('成功删除！');");
	out.print("window.location='frontInfo.jsp?fi_id="+fi_id+"&list_id="+list_id+"';");
}
out.print("</SCRIPT>");
%>