<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/import.jsp"%>
<%
CMySelf self = (CMySelf)session.getAttribute("mySelf");
String selfdtid = String.valueOf(self.getDtId());
String sender_id = String.valueOf(self.getMyID());

String begin_time = CTools.dealString(request.getParameter("begin_time")).trim();
String end_time = CTools.dealString(request.getParameter("end_time")).trim();
String sqlStr = "select ul_id,ul_time,us_id,uk_id,us_name,ul_ip,to_char(ul_logintime,'yyyy-mm-dd hh24:mi:ss') ul_logintime,ul_action,us_uid from jk_userlogin where ul_logintime > to_date('"+begin_time+" 00:00:00','yyyy-mm-dd hh24:mi:ss') and ul_logintime < to_date('"+end_time+" 23:59:59','yyyy-mm-dd hh24:mi:ss') order by ul_logintime desc";
//out.println(sqlStr);//out.close();
String ul_id = "";
String us_id = "";
String us_uid = "";
String us_name = "";
String uk_id = "";
String ul_ip = "";
String ul_logintime = "";
String ul_action = "";

String strTitle = "前台用户登录监控列表("+begin_time+"至"+end_time+")";
//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 
StringBuffer outputStr = new StringBuffer();
outputStr.append("<table width='100%' border='1'>");
                outputStr.append("<tr>");
                       outputStr.append("<td valign='center'><span align='left'>"+strTitle+"</span>&nbsp;&nbsp;&nbsp;&nbsp;");
                       outputStr.append("</td>");
                outputStr.append("</tr>");
outputStr.append("</table>");
outputStr.append("<table width='100%'>");
  outputStr.append("<tr width='100%'>");
    outputStr.append("<td width='10%'>用户名</td>");
    outputStr.append("<td width='30%'>用户姓名</td>");
	outputStr.append("<td width='10%'>注册类型</td>");
    outputStr.append("<td width='30%'>用户登录IP</td>");
    outputStr.append("<td width='10%'>用户登录时间</td>");
  outputStr.append("</tr>");

Vector vPage = dImpl.splitPage(sqlStr,10000000,1);
if (vPage != null)
{
  for(int j=0;j<vPage.size();j++)
  {
   Hashtable content = (Hashtable)vPage.get(j);
   ul_id = content.get("ul_id").toString();
   us_uid = content.get("us_uid").toString();
   us_name = content.get("us_name").toString();
   uk_id = content.get("uk_id").toString();
   ul_ip = content.get("ul_ip").toString();
   ul_logintime = content.get("ul_logintime").toString();
   ul_action = content.get("ul_action").toString();
   outputStr.append("<tr>");
 
  outputStr.append("<td>"+us_uid+"</td>");
  outputStr.append("<td>"+us_name+"</td>");
  outputStr.append("<td>");
  if(uk_id.equals("o1")) 
  {outputStr.append("个人");}
  else {outputStr.append("法人");}
  outputStr.append("</td>");
  outputStr.append("<td>"+ul_ip+"</td>");
  outputStr.append("<td>"+ul_logintime+"</td>");
  outputStr.append("</tr>");
  }
}
outputStr.append("</table>");
dImpl.closeStmt();
dCn.closeCn();
	response.setContentType("application/download");
	response.setHeader("Content-Disposition","attachment;filename="+strTitle+".xls");
	out.print(outputStr.toString());
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