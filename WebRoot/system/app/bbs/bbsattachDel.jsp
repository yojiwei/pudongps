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
String Board_id			 = "";
String postId			 = "";
String bi_radomname      ="";

Board_id = CTools.dealString(request.getParameter("Board_id")).trim();
postId = CTools.dealString(request.getParameter("postId")).trim();
fileName = CTools.dealString(request.getParameter("fileName")).trim();
in_id = CTools.dealString(request.getParameter("in_id")).trim();
//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 


sqlStr = "select distinct bi_path from tb_bimage where bi_table_id='"+postId+"'";
Hashtable content = dImpl.getDataInfo(sqlStr);
if (content!=null)
{
	DL_directory_name = content.get("bi_path").toString();	
}
//path = Messages.getString("filepath");//获取路径
String contextPath = "attach\\bbs\\";
path = request.getRealPath("/") + contextPath;
//path = dImpl.getInitParameter("bbs_http_path");

sqlStr = "select bi_id,bi_radomname from tb_bimage where bi_table_id='"+postId+"' and bi_filename='"+fileName+"'";
//out.println(sqlStr);
content = dImpl.getDataInfo(sqlStr);
if (content!=null)
{	
	bi_radomname = content.get("bi_radomname").toString();
	String pa_id = content.get("bi_id").toString();
	dImpl.setTableName("tb_bimage");
	dImpl.setPrimaryFieldName("bi_id");
	dImpl.delete(pa_id);
}
//dImpl.executeUpdate(sqlStr);
dImpl.closeStmt();
dCn.closeCn();

boolean successDel=false;
File delFile = new File(path+DL_directory_name+"\\"+bi_radomname);
//out.print(path+DL_directory_name+"\\"+bi_radomname+"<br>");
successDel = delFile.delete();
//response.sendRedirect("postEdit.jsp?post_id='"+postId+"'&fid='"+Board_id+"'");  
out.println(successDel);
out.print("<SCRIPT LANGUAGE=\"JavaScript\">");
if (successDel){
	
	out.print("alert('成功删除！');");
	out.print("window.location.href='postEdit.jsp?post_id="+postId+"&fid="+Board_id+"'");
}else{
	out.print("alert('删除该文件时失败！');");
	out.print("history.back();");	
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