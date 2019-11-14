<%@page contentType="text/html; charset=GBK"%>
<%@include file="../skin/import.jsp"%>

<%
String path              = "";
String fileName          = "";
String DL_directory_name = "";
String sqlStr            = "";
String projectId        = "";

fileName = CTools.dealString(request.getParameter("fileName")).trim();
projectId = CTools.dealString(request.getParameter("projectId")).trim();
//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 


sqlStr = "select distinct pa_path from tb_proceedingattach where pr_id='"+projectId+"'";
Hashtable content = dImpl.getDataInfo(sqlStr);
if (content!=null)
{
	DL_directory_name = content.get("pa_path").toString();
}
path = dImpl.getInitParameter("prattach_save_path"); //获取路径

sqlStr = "select pa_id from tb_proceedingattach where pr_id='"+projectId+"' and pa_filename='"+fileName+"'";
content = dImpl.getDataInfo(sqlStr);
if (content!=null)
{
	dImpl.delete("tb_proceedingattach","pa_id",content.get("pa_id").toString());
}
//dImpl.executeUpdate(sqlStr);
dImpl.closeStmt();
dCn.closeCn();

boolean successDel=false;
File delFile = new File(path+DL_directory_name+"\\\\"+fileName);
//out.print(delFile.length());
successDel=delFile.delete();
if (successDel)
{
	out.print("<SCRIPT LANGUAGE=\"JavaScript\">");
	out.print("window.location='ProceedingInfo.jsp?projectId="+projectId+"'");
	out.print("</SCRIPT>");
}
else
{
	out.print("<SCRIPT LANGUAGE=\"JavaScript\">");
	out.print("alert('删除该文件时失败！');");
	out.print("window.location='ProceedingInfo.jsp?projectId="+projectId+"'");
	out.print("</SCRIPT>");
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