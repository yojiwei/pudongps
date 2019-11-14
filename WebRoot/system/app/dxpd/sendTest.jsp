<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<script src="/my.js"></script>
<script language="javascript">
function doAction(){
	String.prototype.Trim = function() {
	  var m = this.match(/^\s*(\S+(\s+\S+)*)\s*$/);
	  return (m == null) ? "" : m[1];
	}
	String.prototype.isMobile = function() {
	  return (/^(?:13\d|15[089])-?\d{5}(\d{3}|\*{3})$/.test(this.Trim()));
	}
	var form = document.formData;
	if(form.content.value==""){
		alert("请输入短信发送内容");
		return false;
	}
	if(form.tel.value==""){
		alert("请输入正确手机号码");
		return false;
	}
	//else{
	//	if (!form.tel.value.isMobile()){
	//		alert("请输入正确的手机号码!");
	//		form.tel.focus();
	//		return false;
  //   	}
	//}
	form.submit();
}
</script>
<%@include file="/system/app/skin/skin4/template/info_top.jsp"%>
<!--    模块名称开始    -->
短信发送测试
<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/info_funtion.jsp"%>
<!--    功能按钮开始    -->
短信发送测试
<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/info_main.jsp"%>
<!--    表单提交开始    -->
<table align="center" width="100%" CELLPADDING="1" cellspacing="1">
<form name="formData" method="post" action="sendTestResult.jsp">
	<tr class="line-even">
		<td width="15%" align="right">短信发送内容</td>
	  <td align="left"><input name="content" class="text-line" size="50" maxlength="30">&nbsp;<span style="color:red">*</span></td>
	</tr>
	<tr class="line-even">
		<td width="15%" align="right">手机号码</td>
	  <td align="left"><input name="tel" size="40" class="text-line" maxlength="500">&nbsp;<span style="color:red">*</span></td>
	</tr>
	<tr class="title1" width="100%">
		<td colspan="2" class="outset-table">
			<input type="button" class="bttn" value="提交" onClick="doAction();">&nbsp;
			<input type="reset" class="bttn" value="重置">&nbsp;
		</td>
	</tr>
</form>
</table>
<!--    表单提交结束    -->
<%@include file="/system/app/skin/skin4/template/info_bottom.jsp"%> 
<!--    表单提交结束    -->
<%@include file="/system/app/skin/bottom.jsp"%>
                                     
