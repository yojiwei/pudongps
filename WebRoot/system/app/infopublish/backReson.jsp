<%@page contentType="text/html; charset=GBK"%>
<%@ page import="com.util.CTools" %>
<%@include file="/system/app/islogin.jsp"%>
<html>
<title>退稿意见</title>
<%
	String ct_id = CTools.dealString(request.getParameter("ct_id"));
	String ct_title = CTools.dealString(request.getParameter("ct_title")); 
/*	String bc_Meno = CTools.dealString(request.getParameter("bcMeno"));
	if (!"".equals(bc_Meno)) {
		out.print("<script language='javascript'>alert('编辑成功！');returnValue=\"ok\";alert(returnValue);window.close();</script>");
		return;
	}*/
%>
<head></head>
<script language="javascript">
	function do_cancel() {
		returnValue = "cancel";
		window.close();
	}
	function do_action() {
		if (formData.bcMeno.value.length == 0) {
			alert("请输入退回意见！");
			formData.bcMeno.focus();
			return false;
		}
		if (formData.bcMeno.value != "") {
			if (formData.bcMeno.value.length > 200) {
				alert("退回意见不能超过200个字！");
				formData.bcMeno.focus();
				return false;
			}
		}
		formData.submit();
		//window.close();
	}
</script>
<link href="/system/app/skin/skin3/images/style.css" rel="stylesheet" type="text/css">
<body leftmargin="0">
<iframe name=submitFrm id=submitFrm src=# style="display:none"></iframe>
<form name="formData" target=submitFrm method="post" action="backResonResult.jsp">
<input type="hidden" name="ct_id" value="<%=ct_id%>">
<input type="hidden" name="ct_title" value="<%=ct_title%>">
<table border=0 width=500 bgcolor=white align="left" cellpadding="4">
  <tr class="title1" align=center>
    <td colspan="2">退稿意见</td>
  </tr>
  <tr class="line-even">
	<td width="15%" align="left" colspan="2">
		请说明您对<b><%=ct_title%></b>的意见:
	</td>
  </tr>
  <tr class="line-even">
	<td width="15%" align="right">退回意见：</td>
	<td width="85%" align="left"><textarea name="bcMeno" style="width:380px" rows="6"></textarea></td>
  </tr>  
  <tr class="line-even">
	<td width="15%" align="center" colspan="2">
		<input type="button" name="btns" value="提交" onClick="do_action()">		
		<input type="button" name="btncancel" value="取消" onClick="do_cancel()">
	</td>
  </tr>
</table>
</form>
 </body>
</html>