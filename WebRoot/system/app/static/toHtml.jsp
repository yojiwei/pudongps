<%@page contentType="text/html; charset=GBK"%>
<%@include file="../skin/head.jsp"%>
<%@page import="com.website.*" %>
<table align="center" width="100%" class="main-table">
	<tr class="title1" width="100%">
		<td class="outset-table">正在生成静态页面，请稍候......
		</td>
	</tr>
</table>
<%
	CUrl myurl = new CUrl();
	//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 
	String s_fiid=CTools.dealString(request.getParameter("fi_id")).trim();
	boolean b_flag = false;
	String Url_source = "";
	String Url_destination = "";
	String Url_sql = "select fi_url,fi_content from tb_frontinfo where fi_id='"+s_fiid+"'";
	Hashtable content = dImpl.getDataInfo(Url_sql);
	if(content!=null)
	{
			Url_source = content.get("fi_content").toString();
			Url_destination = content.get("fi_url").toString();
			myurl.getHtml(Url_source, request.getRealPath("/") + Url_destination);
			b_flag = true;
	}
	/*CUrl myurl = new CUrl();
	String indexpath = request.getRealPath("/")+"info\\index.jsp";
	String newspath = request.getRealPath("/")+"info\\news\\NewsIndex.jsp";
    myurl.getHtml("http://192.168.0.55:18080/info/index_1.jsp",indexpath);
	myurl.getHtml("http://192.168.0.55:18080/info/news/NewsIndex_1.jsp",newspath);
	*/
	if(b_flag)
	{
		out.print("<script language='javascript'>");
		out.print("alert('成功生成静态页面！');");
		out.print("history.go(-1);");
		out.print("</script>");
	}
	else
	{
		out.print("<script language='javascript'>");
		out.print("alert('生成静态页面出错！');");
		out.print("history.go(-1);");
		out.print("</script>");
	}	
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