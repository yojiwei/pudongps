<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%@include file="/system/app/skin/skin4/template/info_top.jsp"%>
<!--    模块名称开始    -->
互动事项查询
<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/info_funtion.jsp"%>
<!--    功能按钮开始    -->
互动事项查询
<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/info_main.jsp"%>
<!--    表单提交开始    -->
<table align="center" width="100%" CELLPADDING="1" cellspacing="1">
<form name="formData" method="post" action="QueryList.jsp">
	<tr class="line-even">
		<td width="15%" align="right">申请人</td>
		<td align="left"><input name="applyPeople" class="text-line" maxlength="20"></td>
	</tr>
	<tr class="line-odd">
		<td width="15%" align="right">申请时间</td>
		<td align="left"><input name="beginTime" style="cursor:hand" class="text-line" readonly size="10" onclick="showCal()">&nbsp;至&nbsp;<input style="cursor:hand" name="endTime" class="text-line" readonly size="10" onclick="showCal()"></td>
	</tr>
	<tr class="line-even">
		<td width="15%" align="right">主题</td>
		<td align="left"><input name="pr_name" size="40" class="text-line" maxlength="40"></td>
	</tr>
	<tr class="line-odd">
		<td width="15%" align="right">事项状态</td>
		<td align="left">
			<input type="checkbox" name="status" class="checkbox1" value="1" checked>待处理
			<input type="checkbox" name="status" class="checkbox1" value="2" checked>进行中
			<input type="checkbox" name="status" class="checkbox1" value="3" checked>已完成
			<input type="checkbox" name="status" class="checkbox1" value="8" checked>协调中
		</td>
	</tr>
	<tr class="title1" width="100%">
		<td colspan="2" class="outset-table">
			<input type="submit" class="bttn" value="搜索">&nbsp;
			<input type="reset" class="bttn" value="重写">&nbsp;
		</td>
	</tr>
</form>
</table>
<!--    表单提交结束    -->
<%@include file="/system/app/skin/skin4/template/info_bottom.jsp"%> 
<%@include file="/system/app/skin/bottom.jsp"%>
                                     
