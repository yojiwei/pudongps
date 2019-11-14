<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>

<script LANGUAGE="javascript" src="../infopublish/common/common.js"></script>
<%@include file="/system/app/skin/skin4/template/info_top.jsp"%>
<!--    模块名称开始    -->
用户定制情况查询
<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/info_funtion.jsp"%>
<!--    功能按钮开始    -->

<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/info_main.jsp"%>
<!--    表单提交开始    -->
<table WIDTH="100%" CELLPADDING="0" cellspacing="0" BORDER="0">
<form name="formData" method="post" action="UserTakeList.jsp">
	<tr class="line-even">
		<td width="15%" align="right">定制用户登录名：</td>
		<td align="left"><input name="us_username" class="text-line" maxlength="20"></td>
	</tr>
	<tr class="line-even">
		<td width="15%" align="right">定制用户手机号：</td>
		<td align="left"><input name="us_usertel" class="text-line" maxlength="20"></td>
	</tr>
	<tr class="line-odd">
		<td width="15%" align="right">用户定制时间：</td>
		<td align="left"><input name="beginTime" class="text-line" style="cursor:hand"   onClick="showCal()" value="" size="10" readonly>
		&nbsp;至&nbsp;<input style="cursor:hand" name="endTime" class="text-line" readonly  value="" size="10" onClick="showCal()"></td>
	</tr>
	<tr class="outset-table" width="100%">
		<td colspan="2" class="outset-table">
			<input type="submit" class="bttn" value="查询">&nbsp;
			<input type="reset" class="bttn" value="重写">&nbsp;		</td>
	</tr>
<input type="hidden" name="OPType" value="search">
<input type="hidden" name="status1" value="">
</form>

</table>
<!--    表单提交结束    -->
<%@include file="/system/app/skin/skin4/template/info_bottom.jsp"%> 

<%@include file="/system/app/skin/bottom.jsp"%>
                                     
