<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%
String fi_id = "";
String fi_title = "";
String sqlStr = "select fi_id as id ,fi_title as name from tb_frontinfo where fs_id=(select fs_id from tb_frontsubject where fs_code='flushcache') order by fi_sequence,fi_id";
//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 

%>
<table class="main-table" width="100%">
  <tr class="bttn" width="100%">
    <td align="center" width="10%">序号</td>
	<td align="center" width="60%">名称</td>

    <td align="center" width="15%">刷新页面</td>
  </tr>
<%
Vector vPage = dImpl.splitPage(sqlStr,request,20);
if (vPage != null)
{
  for(int j=0;j<vPage.size();j++)
  {
   Hashtable content = (Hashtable)vPage.get(j);
   fi_id = content.get("id").toString();
   fi_title = content.get("name").toString();
   if(j % 2 == 0)  out.print("<tr class=\"line-even\">");
   else out.print("<tr class=\"line-odd\">");
%>
  <td align="center"><%=j+1%></td>
  <td align="center"><%=fi_title%></td>
 
  <td align="center"><a href="CacheFlush.jsp?fi_id=<%=fi_id%>">刷新</a></td>
 </tr>
<%
  }
/*分页的页脚模块*/
out.println("<tr><td colspan=7>" + dImpl.getTail(request) + "</td></tr>"); //输出尾部文件
}
else
{
out.println("<tr><td colspan=7 align='right'>没有记录！</td></tr>"); //输出尾部文件
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