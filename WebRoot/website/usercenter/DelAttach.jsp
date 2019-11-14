<%@page contentType="text/html; charset=GBK"%>
<%@ page import="com.component.database.*" %>
<%@ page import="com.component.treeview.*" %>
<%@ page import="com.platform.meta.*" %>
<%@ page import="com.platform.module.*" %>
<%@ page import="com.platform.subject.*" %>
<%@ page import="com.platform.user.*" %>
<%@ page import="com.platform.role.*" %>
<%@ page import="com.platform.log.*" %>
<%@ page import="java.util.*" %>
<%@ page import="com.util.CTools" %>
<%@ page import="com.util.*" %>
<%@ page import="java.net.*" %>
<%@ page import="java.io.*" %>
<%
String sqlStr = ""; 
String wa_save_path = "";
String fileName = "";
String sDocument = ""; 
String strAlert = "";
boolean sucDel = false;
String attach = CTools.dealString(request.getParameter("attach")).trim();

//Update 20061231
CDataCn dCn = null;
CDataImpl dImpl = null;
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn); 

dCn.beginTrans();
wa_save_path = dImpl.getInitParameter("workattach_save_path"); //获得所有办事提交附件的存放目录

if (!attach.equals(""))
{
	sqlStr = "select wa_fileName,wa_path from tb_workattach where wa_id='"+attach+"'";
}
if (!sqlStr.equals(""))
{
	Hashtable content = dImpl.getDataInfo(sqlStr);
	if (content!=null)
	{
		fileName = content.get("wa_filename").toString();
		sDocument = content.get("wa_path").toString();
		sDocument = wa_save_path + sDocument + fileName;
	}
	dImpl.delete("tb_workattach","wa_id",attach); //从数据库里删除该纪录
}
if (dCn.getLastErrString().equals(""))
{
	dCn.commitTrans();
	sucDel = true;
	strAlert = "删除文件成功！";
}
else
{
	dCn.rollbackTrans();
	sucDel = false;
	strAlert = "现在不能删除该文件，请稍后再试！";
}
java.io.File sFile = new java.io.File(sDocument);//从文件夹里删除文件
sFile.delete();
%>
<script language="javascript">
alert("<%=strAlert%>");
window.opener.location.reload();
window.close();
</script>

<%
}
catch(Exception e){
//e.printStackTrace();
out.print(e.toString());
}
finally{
dImpl.closeStmt();
dCn.closeCn(); 
}
%>