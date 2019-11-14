<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/import.jsp"%>
<%
CMySelf self = (CMySelf)session.getAttribute("mySelf");
String selfdtid = String.valueOf(self.getDtId());
String sender_id = String.valueOf(self.getMyID());

String begin_time = CTools.dealString(request.getParameter("begin_time")).trim();
String end_time = CTools.dealString(request.getParameter("end_time")).trim();
String sqlStr = "select sl_id,sl_time,ui_id,ui_uid,ui_name,sl_ip,to_char(sl_logintime,'yyyy-mm-dd hh24:mi:ss') sl_logintime,sl_action,ui_role,sl_dept from jk_syslogin where sl_logintime > to_date('"+begin_time+" 00:00:00','yyyy-mm-dd hh24:mi:ss') and sl_logintime < to_date('"+end_time+" 23:59:59','yyyy-mm-dd hh24:mi:ss') order by sl_logintime desc";
//out.println(sqlStr);//out.close();
String sl_id = "";
String ui_id = "";
String ui_uid = "";
String ui_name = "";
String sl_ip = "";
String sl_logintime = "";
String sl_action = "";
String ui_role = "";
String sl_dept = "";

String strTitle = "后台维护人员登录监控列表("+begin_time+"至"+end_time+")";
//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 

StringBuffer outputStr = new StringBuffer();
outputStr.append("<table width='100%'>");
                outputStr.append("<tr>");
                       outputStr.append("<td valign='center'><span>"+strTitle+"</span>&nbsp;&nbsp;&nbsp;&nbsp;");
                       outputStr.append("</td>");
                outputStr.append("</tr>");
outputStr.append("</table>");
outputStr.append("<table width='100%'>");
  outputStr.append("<tr width='100%'>");
    outputStr.append("<td align='center' width='10%'>用户帐号</td>");
    outputStr.append("<td align='center' width='10%'>用户姓名</td>");
	outputStr.append("<td align='center' width='20%'>权限角色</td>");
	outputStr.append("<td align='center' width='20%'>所属单位</td>");
    outputStr.append("<td align='center' width='20%'>用户登录IP</td>");
	outputStr.append("<td align='center' width='10%'>用户登录时间</td>");
  outputStr.append("</tr>");

Vector vPage = dImpl.splitPage(sqlStr,1000000,1);
if (vPage != null)
{
  for(int j=0;j<vPage.size();j++)
  {
   Hashtable content = (Hashtable)vPage.get(j);
   sl_id = content.get("sl_id").toString();
   ui_uid = content.get("ui_uid").toString();
   ui_name = content.get("ui_name").toString();
   ui_role = content.get("ui_role").toString();
   sl_dept = content.get("sl_dept").toString();
   sl_ip = content.get("sl_ip").toString();
   sl_logintime = content.get("sl_logintime").toString();
   sl_action = content.get("sl_action").toString();

  outputStr.append("<tr>");
  outputStr.append("<td align='center'>"+ui_uid+"</td>");
  outputStr.append("<td align='center'>"+ui_name+"</td>");
  outputStr.append("<td align='center'>"+ui_role+"</td>");
  outputStr.append("<td align='center'>"+sl_dept+"</td>");
  outputStr.append("<td align='center'>"+sl_ip+"</td>");
  outputStr.append("<td align='center'>"+sl_logintime+"</td>");
  outputStr.append("</tr>");

  }
}

outputStr.append("</table>");

dImpl.closeStmt();
dCn.closeCn();
	response.setContentType("application/download");
	response.setHeader("Content-Disposition","attachment;filename="+strTitle+".xls");
	out.print(outputStr.toString());
	
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