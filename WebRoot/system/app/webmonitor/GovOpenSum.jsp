<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%
String strTitle = "政务公开统计";
%>
<table class="main-table" width="100%">
<form name="formData" action="GovOpenSumResult.jsp" method="post">
	<tr class="title1">
		<td width="100%" colspan="9" align="left">&nbsp;&nbsp;<%=strTitle%></td>
	</tr>
	<tr>
		<td>起始日期：</td>
		<td><input class="text-line" name="beginDate" readonly onclick="showCal()" style="cursor:hand"></td>
		<td>截止日期：</td> 
		<td><input class="text-line" name="endDate" readonly onclick="showCal()" style="cursor:hand"></td>
	</tr>
	<tr class=title1>
		<td width="100%" colspan="9" align="center">
			<input type=submit value=" 确 定 " class="bttn">&nbsp;&nbsp;
			<input type="reset" value=" 重 选 " class="bttn">
		</td>
	</tr>
</table>
<%@include file="/system/app/skin/bottom.jsp"%>