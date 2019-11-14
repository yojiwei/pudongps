<%@ page contentType="text/html; charset=GBK"%>
<%@include file="/website/include/IsLogin.jsp"%>
<%@include file="/website/include/import.jsp"%>
<title>消息窗口</title>
<%//Update 20061231
String pr_id = CTools.dealString(request.getParameter("pr_id")).trim();
String wo_id = CTools.dealString(request.getParameter("wo_id")).trim();
%>
<script language="javascript">
<!--
function check()
{
	if (formData.receiverName.value=="")
	{
		alert("请选择消息接收单位！");
		return false;
	}
	if (formData.msgTitle.value=="")
	{
		alert("请输入消息标题！");
		formData.msgTitle.focus();
		return false;
	}
	formData.submit();
}

function selectReceiver()
{
	var deptName = event.srcElement;
	var deptId = document.formData.receiverId;
	var obDept = new Object;
	obDept["name"] = deptName.value;
	obDept["id"] = deptId.value; 
	var retVal = showModalDialog("/website/include/SelDept.jsp?pr_id=<%=pr_id%>",obDept,"dialogWidth=300px; dialogHeight=400px; help=no; scroll=no; status=no;");
	if (typeof(retVal)=="undefined") return false;
	else
	{
		deptName.value = retVal["name"];
		deptId.value = retVal["id"];
	}
}
-->
</script>
<link rel="stylesheet" href="/website/include/main.css" type="text/css">
<body topmargin=5>
<form name="formData" action="SendResult.jsp" method="post">
<table width=98% border=0 align="center" cellpadding=0 cellspacing=0>
	<tr>
		<td bgcolor="#D6E1C1">
			<table border=0 width=100% cellspacing=1 cellpadding=0>
				<tr>
					<td width=100% height=25 background="/website/images/title.gif"> <div align="center">消息窗口</div></td>
				</tr>
				<tr>
					<td height="35" bgcolor="#F6F9EE">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
							<td width="20%" height="35"><div align="center">接收单位：</div></td>
							<td height="35">
								<input name="receiverName" size="30" class="text-line-info" value="" readonly onclick="selectReceiver();" style="cursor:hand">
								<input type="hidden" name="receiverId" value=""></td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td height="35" bgcolor="#F6F9EE">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
							<td width="20%" height="35"><div align="center">消息标题：</div></td>
							<td height="35"><input type="text" name="msgTitle" size="30" class="text-line-info" value=""></td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td height="100" bgcolor="#F6F9EE">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr> 
								<td width="20%" height="100"><div align="center">消息内容：</div></td>
								<td height="100"><textarea name="msgContent" cols="30" rows="6" class="text-area-info"></textarea></td>
							</tr>
							<tr> 
								<td height="30" colspan="2"><div align="center"> 
								    <input type="button" name="btnSubmit" value="发送" class="bttn-info" onclick="check()">&nbsp;
								    <input type="reset" name="btnRest" value="重写" class="bttn-info">
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<input type="hidden" name="wo_id" value="<%=wo_id%>">
				</form>
				<tr>
				    <td width=100% height=18 bgcolor="#E3F1D0">
				<div align="right"><font color="#FF0000">Ｘ</font><a href="javascript:window.close()">关闭窗口</a></div></td>
				</tr>
			</table>
		</td>
	</tr>
</table>


