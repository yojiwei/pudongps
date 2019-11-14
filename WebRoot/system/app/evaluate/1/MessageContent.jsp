<%@page contentType="text/html; charset=GBK" %>
<%@include file="/system/app/skin/pophead.jsp"%>
<%
CDataCn dCn = new CDataCn(); //新建数据库连接对象
CDataImpl dImpl = new CDataImpl(dCn); //新建数据接口对象
String oe_content="";
String oe_id  = CTools.dealString(request.getParameter("oe_id")).trim();
String sql_content  = "select oe_advice from tb_onlineevaluate where oe_id='"+oe_id+"'";
Hashtable content = dImpl.getDataInfo(sql_content);
if(content!=null)
{
	oe_content = content.get("oe_advice").toString();
}
%>
<table class="main-table" width="100%">
<tr>
<td>
	<table class="content-table" width="100%">
	<form name="formData">
	<tr class="title1">
	<td align="center">
		<table WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="1">
		<tr width="100%" align="center">
		<td width="15%" valign="center"><font size="3"><b>留言内容</b></font></td>
		</tr>
		<tr width="100%" align="center" class="line-even">
		<td width="100%" valign="center">
			<textarea name="oe_content" class="text-line" cols="50%"rows=15 readonly><%=oe_content%></textarea>
		</td>
		</tr>
		<tr align="center" width="100%">
		<td>
		<input class="bttn" name="close" value="关闭" type="button" onclick="window.close();">
		</td>
		</tr>
		</table>
	</td>
	</tr>
	
	</form>
	</table>
</td>
</tr>
</table>

<%
dImpl.closeStmt();
dCn.closeCn();
%>
<%@include file="/system/app/skin/popbottom.jsp"%>
