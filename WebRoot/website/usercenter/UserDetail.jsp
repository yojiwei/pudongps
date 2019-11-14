<%@ page contentType="text/html; charset=GBK"%>
<title>临时用户</title>
<%@include file="/website/include/import.jsp"%>
<%

//Update 20061231
String uid = CTools.dealString(request.getParameter("uid")).trim();
String pwd = CTools.dealString(request.getParameter("pwd")).trim();
%>
<script language="javascript">
function printWindow()
{
	var obj = opBar;
	obj.style.display="none";
	window.print();
	window.close();
}
</script>

<table width="100%" cellspacing="1" border="0" bgcolor="black">
	<tr>
		<td colspan="2" align="center" bgcolor="#FFFFFF">网站为您生成了临时用户</td>
	</tr>
	<tr>
		<td width="15%" align="right" bgcolor="#FFFFFF">用户名：</td>
		<td align="left" bgcolor="#FFFFFF"><%=uid%></td>
	</tr>
	<tr>
		<td width="15%" align="right" bgcolor="#FFFFFF">密码：</td>
		<td align="left" bgcolor="#FFFFFF"><%=pwd%></td>
	</tr>
	<tr id="opBar" style="display:">
		<td colspan="2" align="center" bgcolor="#FFFFFF">
			<input type="button" name="btnClose" value="关闭" onclick="javascript:window.close();">&nbsp;
			<input type="button" name="btnPrint" value="打印" onclick="printWindow();">
		</td>
	</tr>
</table>
