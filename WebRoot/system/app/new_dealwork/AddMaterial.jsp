<%@ page contentType="text/html; charset=GBK" %>
<title>请填写需补件内容</title>
<%@include file="/system/app/skin/pophead.jsp"%>
<script language="javascript">
function checkForm()
{
	if(formData.wf_reason.value=="")
	{
		alert("补件内容不能为空！");
		formData.wf_reason.focus();
		return false;
	}
	formData.action="AddMaterialResult.jsp";
	formData.submit();
}
</script>
<%
String wo_id = "";
wo_id = CTools.dealString(request.getParameter("wo_id")).trim();

%>
<table class="main-table" width="550" align="center">
<form name="formData" method="post">
<tr class="title1" width="100%">
	<td width="100%" align="left" class="outset-table"><font size=2>补件内容</font></td>
</tr>
<tr class="line-odd" width="100%">
	<td width="100%" align="center">
		<textarea name="wf_reason" class="text-line" cols="70" rows="10"></textarea>
	</td>
</tr>
<tr class="title1" width="100%">
	<td width="100%" align="center" class="outset-table">
		<input type="button" name="btnSubmit" class="bttn" value="确定" onclick="checkForm()">&nbsp;
		<input type="reset" class="bttn" name="btnReset" value="重写">&nbsp;
		<input type="button" class="bttn" value="关闭" name="btnCloseWin" onclick="window.close();">&nbsp;
	</td>
</tr>
<input type="hidden" name="wo_id" value="<%=wo_id%>">
</form>
</table>
<%@include file="/system/app/skin/popbottom.jsp"%>