<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<table class="main-table" width="100%">
<form name="formData" action="formatResult.jsp" method="post">
<tr>
	<td align="left" colspan="2"><strong>此操作影响很大，谨慎使用！</strong></td>
</tr>
<tr>
	<td height="18" colspan="2">  </td>
</tr>
<tr>
	<td width="50"> </td>
	<td align="left">
		<input type="checkbox" name="sel" value="1" class="checkbox1">&nbsp;前台用户&nbsp;&nbsp;<br>
		<input type="checkbox" name="sel" value="2" class="checkbox1">&nbsp;部门列表（包括后台用户）&nbsp;&nbsp;<br>
		<input type="checkbox" name="sel" value="3" class="checkbox1">&nbsp;网上办事&nbsp;&nbsp;<br>
		<input type="checkbox" name="sel" value="4" class="checkbox1">&nbsp;监督投诉内容&nbsp;&nbsp;
	</td>
</tr>
<tr>
	<td height="18" colspan="2">  </td>
</tr>
<tr>
	<td align="center" colspan="2">
		<input type="button" value="确定" onclick="checkForm()">&nbsp;&nbsp;
		<input type="button" value="返回" onclick="javascript:window.history.go(-1);">
	</td>
</tr>
</form>
</table>
<script language="javascript">
function checkSelect()
{
	var r = false;
	var obj = formData.sel;
	if (typeof(obj)=="")
	{
		alert("内部错误，不存在要检验的checkbox");
		return false;
	}
	if (typeof(obj.length)=="undefined")
	{
		if (obj.checked) r = true;
	}
	else
	{
		var length = obj.length;
		for (var i=0;i<length;i++)
		{
			if (obj[i].checked)
			{
				r = !r;
				break;
			}
		}
	}
	return r;
}

function checkForm()
{
	if (checkSelect())
	{
		if (confirm("警告:执行此操作将清空相关数据库，而且操作不可恢复！确实要继续吗？"))
		{
			formData.submit();
		}
	}
	else
	{
		alert("没有选择要初始化的模块！");
	}
}
</script>
<%@include file="/system/app/skin/bottom.jsp"%>