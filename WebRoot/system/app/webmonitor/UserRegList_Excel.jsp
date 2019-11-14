<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/import.jsp"%>
<%
String ul_begintime = CTools.dealString(request.getParameter("begin_time")).trim();
String ul_endtime = CTools.dealString(request.getParameter("end_time")).trim();
String sqlStr = "select us_name,us_id, uk_id,us_uid,ur_ip,to_char(ur_time,'yyyy-mm-dd hh24:mi:ss') ur_time from jk_userregister where ur_time > to_date('"+ul_begintime+" 00:00:00','yyyy-mm-dd hh24:mi:ss') and ur_time < to_date('"+ul_endtime+" 23:59:59','yyyy-mm-dd hh24:mi:ss') order by ur_time desc";

String us_id  = "";
String uk_id = "";
String us_uid = "";
String us_name = "";
String ur_ip = "";
String ur_time = "";

String strTitle = "前台用户注册监控("+ul_begintime+"至"+ul_endtime+")";
//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 

StringBuffer outputStr = new StringBuffer();
outputStr.append("<table width='100%'>");
                outputStr.append("<tr>");
                       outputStr.append("<td valign='center'>"+strTitle);
                       outputStr.append("</td>");
                outputStr.append("</tr>");
outputStr.append("</table>");
outputStr.append("<table width='100%'>");
  outputStr.append("<tr>");
    outputStr.append("<td align='center' width='20%'>身份证号</td>");
	outputStr.append("<td align='center' width='10%'>用户类型</td>");
    outputStr.append("<td align='center' width='30%'>用户姓名</td>");
    outputStr.append("<td align='center' width='10%'>注册IP</td>");
    outputStr.append("<td align='center' width='30%'>注册时间</td>");
  outputStr.append("</tr>");

Vector vPage = dImpl.splitPage(sqlStr,1000000,1);
if (vPage != null)
{
  for(int j=0;j<vPage.size();j++)
  {
   Hashtable content = (Hashtable)vPage.get(j);
   us_id = content.get("us_id").toString();
   uk_id = content.get("uk_id").toString();
   us_uid = content.get("us_uid").toString();
   us_name = content.get("us_name").toString();
   ur_ip = content.get("ur_ip").toString();
   ur_time = content.get("ur_time").toString();
   if (uk_id.equals("o1")) uk_id = "个人";
   else if (uk_id.equals("o2")) uk_id = "法人";
	
  outputStr.append("<tr>");
  outputStr.append("<td>"+us_uid+"</td>");
  outputStr.append("<td>"+uk_id+"</td>");
  outputStr.append("<td>"+us_name+"</td>");
  outputStr.append("<td>"+ur_ip+"</td>");
  outputStr.append("<td>"+ur_time+"</td>");
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