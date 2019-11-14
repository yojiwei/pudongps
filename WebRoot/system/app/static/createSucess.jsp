<%@page contentType="text/html; charset=GBK"%>
<%@include file="../skin/head.jsp"%>
<%@page import="com.website.*" %>
<table class="FindAreaTable1" cellspacing="1" rules="cols" border="0" id="ctl00_DataGrid_DataGrid1" style="border-width:0px;">
	<tr class="title1" width="100%">
		<td class="outset-table">正在生成静态页面，请稍候......
		</td>
	</tr>
</table>
<%

CUrl myurl = new CUrl();
CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 
	String s_fiid=CTools.dealString(request.getParameter("fi_id")).trim();
	boolean b_flag = false;
	String Url_source = "";
	String Url_destination = "";
	String fi_img  = "";
	String Url_sql = "select fi_url,fi_content,fi_img from tb_frontinfo where fi_id='"+s_fiid+"'";
	Hashtable content = dImpl.getDataInfo(Url_sql);
	if(content!=null)
	{
			Url_source = content.get("fi_content").toString();
			Url_destination = content.get("fi_url").toString();
			fi_img = content.get("fi_img").toString();
			//System.out.println("-----------------------"+Url_source);
			//System.out.println("======================="+Url_destination);
			//System.out.println("-----------------------"+request.getRealPath("/"));
			//myurl.getHtml(Url_source, request.getRealPath("/") + Url_destination);
			b_flag = myurl.createHtml(Url_source,request.getRealPath("/"),Url_destination,fi_img);
			//System.out.println(Url_source + "<br>" + request.getRealPath("/") + "<br>" + Url_destination + "<br>" + fi_img+"<br>"+b_flag);
	}
	
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