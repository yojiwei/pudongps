<%@page contentType="text/html; charset=GBK"%>
<%@ include file="../skin/head.jsp"%>
<%@ page import="com.beyondbit.web.publishinfo.Messages" %>

<%
String path              = "";
String fileName          = "";
String DL_directory_name = "";
String sqlStr            = "";
String in_id			 = "";
String tm_code			 = "";
String oPage=CTools.dealString(request.getParameter("oPage")).trim();
//String oPage1=UnEscape(oPage);
//out.println(oPage);
//if(true)return;
fileName = CTools.dealString(request.getParameter("fileName")).trim();
in_id = CTools.dealString(request.getParameter("in_id")).trim();
//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 


sqlStr = "select distinct filepath from accessories where id="+in_id;
Hashtable content = dImpl.getDataInfo(sqlStr);
if (content!=null)
{
	DL_directory_name = content.get("filepath").toString();
}
path = Messages.getString("filepath");//获取路径

sqlStr = "select id from accessories where id='"+in_id+"' and filename='"+fileName+"'";
content = dImpl.getDataInfo(sqlStr);
if (content!=null)
{
	String pa_id = content.get("id").toString();
	dImpl.setTableName("accessories");
	dImpl.setPrimaryFieldName("id");
	dImpl.delete(pa_id);
}
//dImpl.executeUpdate(sqlStr);
dImpl.closeStmt();
dCn.closeCn();

boolean successDel=false;
File delFile = new File(path+DL_directory_name+"\\"+fileName);
//out.print(path+DL_directory_name+"\\"+fileName);
successDel=delFile.delete();

out.print("<SCRIPT LANGUAGE=\"JavaScript\">");
if (!successDel)
{
	out.print("alert('删除该文件时失败！');");
	out.print("window.location.history.back();");
}
else
{
	out.print("alert(\"删除成功！\");");
	out.print("window.location.href='"+oPage+"'");
}

out.print("</SCRIPT>");
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