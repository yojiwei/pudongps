<%@page contentType="text/html; charset=GBK" %>
<%@include file="/system/app/skin/pophead.jsp"%>
<%@page import="com.component.database.*"%>
<%@page import="com.app.*"%>

<%
//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 


String co_id="";
String de_id="";
String cf_id="";
String cf_reason="";
String de_senddeptid="";
String optype="";

co_id = CTools.dealString(request.getParameter("co_id")).trim();
de_id = CTools.dealString(request.getParameter("de_id")).trim();
cf_id = CTools.dealString(request.getParameter("cf_id")).trim();
de_senddeptid = CTools.dealString(request.getParameter("de_senddeptid")).trim();
optype=CTools.dealString(request.getParameter("OPType")).trim();
//out.println(de_id);

String sqlFrozen="";

sqlFrozen = " select cf_reason from tb_correspondfrozen where cf_id='"+cf_id+"' ";
//out.println(sqlFrozen);
Hashtable content = dImpl.getDataInfo(sqlFrozen);
if(content!=null)
{
	cf_reason = content.get("cf_reason").toString();
}
%>

<table class="main-table" width="100%">
<tr>
<td>
	<table class="content-table" width="100%">
	<form name="formData" action="/system/app/cooperate/FrozenResult.jsp">
	<tr class="title1">
	<td align="center">
		<table WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="1">
		<tr width="100%" align="center">
		<td width="15%" valign="center"><font size="3"><b>补件内容</b></font></td>
		</tr>
		<tr width="100%" align="center" class="line-even">
		<td width="100%" valign="center">
			<textarea name="cf_reason" class="text-line" cols="65%"rows=15><%=cf_reason%></textarea>
		</td>
		</tr>
		<tr align="center" width="100%">
		<td>
		
		<input class="bttn" name="confirm" value="确定" type="button" onclick="check();"
		<%
		if(!optype.equals("Frozen"))
		{
			out.println("disabled");
		}
		%>
		>&nbsp;
		<input class="bttn" name="rewrite" value="重写" type="reset"
		<%
		if(!optype.equals("Frozen"))
		{
			out.println("disabled");
		}
		%>
		>&nbsp;
		<input class="bttn" name="close" value="关闭" type="button" onclick="window.close();">
		<input type="hidden" name="co_id" value="<%=co_id%>">
		<input type="hidden" name="de_id" value="<%=de_id%>">
		<input type="hidden" name="de_senddeptid" value="<%=de_senddeptid%>">
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
<script>
function check()
{
	if(formData.cf_reason.value=="")
	{
		alert("请填写理由!");
		formData.cf_reason.focus();
		return false;
	}
	formData.submit();
}
</script>
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
<%@include file="/system/app/skin/popbottom.jsp"%>
