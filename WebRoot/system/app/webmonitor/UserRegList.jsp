<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%
CMySelf self = (CMySelf)session.getAttribute("mySelf");
String selfdtid = String.valueOf(self.getDtId());
String sender_id = String.valueOf(self.getMyID());

String ul_begintime = CTools.dealString(request.getParameter("ul_begintime")).trim();
String ul_endtime = CTools.dealString(request.getParameter("ul_endtime")).trim();
String sqlStr = "select us_name,us_id, uk_id,us_uid,ur_ip,to_char(ur_time,'yyyy-mm-dd hh24:mi:ss') ur_time from jk_userregister where ur_time > to_date('"+ul_begintime+" 00:00:00','yyyy-mm-dd hh24:mi:ss') and ur_time < to_date('"+ul_endtime+" 23:59:59','yyyy-mm-dd hh24:mi:ss') order by ur_time desc";

String us_id  = "";
String uk_id = "";
String us_uid = "";
String us_name = "";
String ur_ip = "";
String ur_time = "";

String strTitle = "前台用户注册监控";
//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 

String Excel_url = "/system/app/webmonitor/UserRegList_Excel.jsp?begin_time="+ul_begintime+"&end_time="+ul_endtime;
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
    <td align="center" width="20%">身份证号</td>
	<td align="center" width="10%">用户类型</td>
    <td align="center" width="30%">用户姓名</td>
    <td align="center" width="10%">注册IP</td>
    <td align="center" width="30%">注册时间</td>
  </tr>
<%
Vector vPage = dImpl.splitPage(sqlStr,request,20);
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
   if(j % 2 == 0)  out.print("<tr class=\"line-even\">");
   else out.print("<tr class=\"line-odd\">");
 %>
  <td align="center"><a href="/system/app/usermanage/UserInfo.jsp?OPType=Edit&us_id=<%=us_id%>"><%=us_uid%></a></td>
  <td align="center"><%=uk_id%></td>
  <td align="center"><%=us_name%></td>
  <td align="center"><%=ur_ip%></td>
  <td align="center"><%=ur_time%></td>
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
%>
<%@include file="/system/app/skin/bottom.jsp"%>
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