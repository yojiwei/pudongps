<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>

<%@include file="/system/app/skin/skin4/template/info_top.jsp"%>
<!--    模块名称开始    -->
信箱信件统计查询
<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/info_funtion.jsp"%>
<!--    功能按钮开始    -->

<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/info_main.jsp"%>
<!--    表单提交开始    -->
<script LANGUAGE="javascript" src="../infopublish/common/common.js"></script>
<script src="wdatepicker/WdatePicker.js" type="text/javascript"></script>
<table align="center" width="100%" CELLPADDING="1" cellspacing="1">
	<form name="formData" method="post" >
			<tr class="line-odd">
				<td width="15%" align="right">申请时间</td>
				<td align="left"><input name="beginTime" type="text" class="text-line" size="10" value="" readonly onClick="WdatePicker()" style="cursor:hand">
						&nbsp;至&nbsp;<input name="endTime" type="text" class="text-line" size="10" value="" readonly onClick="WdatePicker()" style="cursor:hand"></td>
			</tr>
			<tr class="outset-table">
				<td align="right" width="100%" colspan="2">                    
					<p align="center">
					<input type="button" class="bttn" value=" 确 定 " name="fsubmit" onclick="fnsubmit();">
					<input type="button" class="bttn" value=" 返 回 " name="freturn" onclick="history.go(-1);"></p>
				</td>
			</tr>
	</form>
</table>
<script language="javascript">
function fnsubmit()
{
	document.formData.action="AppealStaResult.jsp";	
	document.formData.submit();
}
</script>
<!--    表单提交结束    -->
<%@include file="/system/app/skin/skin4/template/info_bottom.jsp"%> 

<%@include file="/system/app/skin/bottom.jsp"%>
                                     
