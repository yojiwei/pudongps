<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%
CMySelf self = (CMySelf)session.getAttribute("mySelf");
String selfdtid = String.valueOf(self.getDtId());
String sender_id = String.valueOf(self.getMyID());

String begin_time = CTools.dealString(request.getParameter("begin_time")).trim();
String end_time = CTools.dealString(request.getParameter("end_time")).trim();
String sqlStr = "select us_id,ul_id,ul_time,us_id,uk_id,us_name,ul_ip,to_char(ul_logintime,'yyyy-mm-dd hh24:mi:ss') ul_logintime,ul_action,us_uid from jk_userlogin where ul_logintime > to_date('"+begin_time+" 00:00:00','yyyy-mm-dd hh24:mi:ss') and ul_logintime < to_date('"+end_time+" 23:59:59','yyyy-mm-dd hh24:mi:ss') order by ul_logintime desc";
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
String Excel_url = "/system/app/webmonitor/UserLoginList_Excel.jsp?begin_time="+begin_time+"&end_time="+end_time;
%>
<table class="content-table" width="100%">
                <tr class="title1">
                       <td valign="center"><span align="left"><%=strTitle%></span>&nbsp;&nbsp;&nbsp;&nbsp;
					   <span align="right"><a href="<%=Excel_url%>">导出Excel</a></span>
                       </td>
                </tr>
</table>
<table class="main-table" width="100%">
  <tr class="bttn" width="100%">
    <td align="center" width="10%">用户名</td>
    <td align="center" width="30%">用户姓名</td>
	<td align="center" width="10%">注册类型</td>
    <td align="center" width="30%">用户登录IP</td>
    <td align="center" width="10%">用户登录时间</td>
  </tr>
<%
Vector vPage = dImpl.splitPage(sqlStr,request,20);
if (vPage != null)
{
  for(int j=0;j<vPage.size();j++)
  {
   Hashtable content = (Hashtable)vPage.get(j);
   us_id = content.get("us_id").toString();
   ul_id = content.get("ul_id").toString();
   us_uid = content.get("us_uid").toString();
   us_name = content.get("us_name").toString();
   uk_id = content.get("uk_id").toString();
   ul_ip = content.get("ul_ip").toString();
   ul_logintime = content.get("ul_logintime").toString();
   ul_action = content.get("ul_action").toString();
   if(j % 2 == 0)  out.print("<tr class=\"line-even\">");
   else out.print("<tr class=\"line-odd\">");
 %>
  <td align="center"><%=us_uid%></td>
  <td align="center"><a href="/system/app/usermanage/UserInfo.jsp?OPType=Edit&us_id=<%=us_id%>"><%=us_name%></a></td>
  <td align="center"><%if(uk_id.equals("o1")) {out.print("个人");} else {out.print("法人");}%></td>
  <td align="center"><%=ul_ip%></td>
  <td align="center"><%=ul_logintime%></td>
  </tr>
<%
  }
/*分页的页脚模块*/
out.println("<tr><td colspan=7>" + dImpl.getTail(request) + "</td></tr>"); //输出尾部文件
}
%>
</table>
<%
dImpl.closeStmt();
dCn.closeCn();
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
<%@include file="/system/app/skin/bottom.jsp"%>