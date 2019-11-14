<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%
String strDateBegin = CTools.dealString(request.getParameter("pr_date1")).trim();
String strDateEnd = CTools.dealString(request.getParameter("pr_date2")).trim();
if (strDateBegin.equals("")) strDateBegin = new CDate().getThisday();
if (strDateEnd.equals("")) strDateEnd = new CDate().getThisday();
String sqlStr="select sum(a.pr_totalconsul) pr_totalconsul, sum(a.PR_CONSULING) PR_CONSULING,";
	sqlStr += "sum(a.PR_CONSULED) PR_CONSULED, sum(a.PR_GREEN) PR_GREEN,";
	sqlStr += "sum(a.PR_WORKING) PR_WORKING, sum(a.PR_DEADWORK) PR_DEADWORK,";
	sqlStr += "sum(a.PR_WORKED) PR_WORKED, sum(a.PR_FROZENWORK) PR_FROZENWORK,";
	sqlStr += "sum(a.PR_CORWORKNUM) PR_CORWORKNUM, b.dt_name ";
	sqlStr += "from jk_proceeding a,tb_deptinfo b ";
	sqlStr += "where a.dt_id=b.dt_id and a.pr_date>='" + strDateBegin + "' and a.pr_date<='" + strDateEnd + "'  ";
	sqlStr += "group by b.dt_name, b.dt_sequence ";
	sqlStr += "order by b.dt_sequence";
String pr_date="";			//日期
String dt_id="";			//单位编号
String pr_totalconsul="";	//办事总计
String pr_consuling="";		//未办事项
String pr_consuled="";		//已办事项
String pr_green="";			//绿色通道事项
String pr_working="";		//进行中事项
String pr_deadwork="";		//未通过事项
String pr_frozenwork="";	//需补件事项
String pr_corworknum="";	//协调中事项
String pr_worked="";		//通过的事项
String dt_name="";			//单位名称


String strTitle = "网上办事情况(" + strDateBegin + "至" + strDateEnd +")";
//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 
%>
<table class="main-table" width="100%">
<form name="formData">
 <tr>
   <td width="100%" colspan="11">
       <table class="content-table" width="100%">
                <tr class="title1">
                        <td colspan="9" align="center">
                                <table WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="1">
                                        <tr>
                                                <td valign="center" align="left"><%=strTitle%></td>
                                                <td valign="center" align="right" nowrap>
                                                        <img src="/system/images/split.gif" align="middle" border="0" WIDTH="5" HEIGHT="8">
                                                        <img src="/system/images/goback.gif" border="0" onclick="javascript:history.back();" title="返回" style="cursor:hand" align="absmiddle">
                                                        <img src="/system/images/split.gif" align="middle" border="0" WIDTH="5" HEIGHT="8">
                                                </td>
                                        </tr>
                                </table>
                        </td>
                </tr>
       </table>
    </td>
  </tr>
  <tr class="bttn" width="100%">
    
    <td align="center" width="9%" class="outset-table">部门名称</td>
    <td align="center" width="9%" class="outset-table">收到办事咨询数</td>
    <td align="center" width="9%" class="outset-table">未处理办事咨询数</td>
    <td align="center" width="9%" class="outset-table">已回复办事咨询数</td>
    <!--<td align="center" width="9%">咨询查看链接</td>-->
    <td align="center" width="9%" class="outset-table">绿色通道申请数</td>
    <td align="center" width="9%" class="outset-table">进行中绿色通道数</td>
    <td align="center" width="9%" class="outset-table">未通过绿色通道数</td>   
    <td align="center" width="9%" class="outset-table">已通过绿色通道数</td>
    <td align="center" width="9%" class="outset-table">需补件绿色通道数</td>
    <td align="center" width="9%" class="outset-table">协调中绿色通道数</td>
    <!--<td align="center" width="9%">办事情况链接</td>-->
   </tr>
<%
int totalconsul = 0;
int totalconsuling = 0;
int totalconsuled = 0;
int totalgreen = 0;
int totalworking = 0;
int totaldeadwork = 0;
int totalfrozenwork = 0;
int totalcorworknum = 0;
int totalworked = 0;

Vector vPage = dImpl.splitPage(sqlStr,100,1);
if (vPage != null)
{
	
  for(int j=0;j<vPage.size();j++)
  {
	   Hashtable content = (Hashtable)vPage.get(j);
	   dt_name = content.get("dt_name").toString();
	   pr_totalconsul = content.get("pr_totalconsul").toString();
	   pr_consuling = content.get("pr_consuling").toString();
	   pr_consuled = content.get("pr_consuled").toString();
	   pr_green = content.get("pr_green").toString();
	   pr_working = content.get("pr_working").toString();   
	   pr_deadwork = content.get("pr_deadwork").toString();
	   pr_frozenwork = content.get("pr_frozenwork").toString();
	   pr_corworknum = content.get("pr_corworknum").toString();
	   pr_worked = content.get("pr_worked").toString();

	   totalconsul += Integer.parseInt(pr_totalconsul);
	   totalconsuling += Integer.parseInt(pr_consuling);
	   totalconsuled += Integer.parseInt(pr_consuled);
	   totalgreen += Integer.parseInt(pr_green);
	   totalworking += Integer.parseInt(pr_working);
	   totaldeadwork += Integer.parseInt(pr_deadwork);
	   totalfrozenwork += Integer.parseInt(pr_frozenwork);
	   totalcorworknum += Integer.parseInt(pr_corworknum);
	   totalworked += Integer.parseInt(pr_worked);
	   
	   if(j % 2 == 0)  out.print("<tr class=\"line-even\">");
	   else out.print("<tr class=\"line-odd\">");
	  %>
	  <td align="center"><%=dt_name%></td>
	  <td align="center"><%=pr_totalconsul%></td>
	  <td align="center"><%=pr_consuling%></td>
	  <td align="center"><%=pr_consuled%></td>
	  <td align="center"><%=pr_green%></td>
	  <td align="center"><%=pr_working%></td>
	  <td align="center"><%=pr_deadwork%></td>
	  <td align="center"><%=pr_worked%></td>
	  <td align="center"><%=pr_frozenwork%></td>
	  <td align="center"><%=pr_corworknum%></td>
	  
	  </tr>
<%
  }
}
%>
<tr>
<td align="center">合计</td>
	  <td align="center"><%=totalconsul%></td>
	  <td align="center"><%=totalconsuling%></td>
	  <td align="center"><%=totalconsuled%></td>
	  <td align="center"><%=totalgreen%></td>
	  <td align="center"><%=totalworking%></td>
	  <td align="center"><%=totaldeadwork%></td>
	  <td align="center"><%=totalfrozenwork%></td>
	  <td align="center"><%=totalcorworknum%></td>
	  <td align="center"><%=totalworked%></td>
	  
	  </tr>
</form>
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