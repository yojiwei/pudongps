<%@page contentType="text/html; charset=GBK"%>
<%@include file="../skin/head.jsp"%>
<%@page import="com.website.*" %>
<%@ taglib uri="oscache" prefix="cache" %>
<table align="center" width="100%" class="main-table">
	<tr class="title1" width="100%">
		<td class="outset-table">正在刷新页面，请稍候......
		</td>
	</tr>
</table>
<%
	//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 

	String fi_id=CTools.dealNull(request.getParameter("fi_id")).trim();
	String cache_code = "";
	String cache_sql = "select fi_url from tb_frontinfo where fi_id='"+fi_id+"'";
	Hashtable content = dImpl.getDataInfo(cache_sql);
	if(content!=null)
	{
			cache_code = content.get("fi_url").toString();
	}
%>
<cache:flush key="<%=cache_code%>" scope="application"/>
<%
	out.print("<script language='javascript'>");
	out.print("alert('成功刷新页面！');");
	out.print("history.go(-1);");
	out.print("</script>");
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