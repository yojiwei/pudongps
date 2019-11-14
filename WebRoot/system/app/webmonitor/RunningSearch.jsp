<%@ page contentType="text/html; charset=GBK" %>
<%@include file="/system/app/skin/head.jsp"%>
<%
CDate searchtime = new CDate();
//String ul_time = searchtime.getNowTime();
String ul_time=(new java.util.Date()).toLocaleString();//发布时间
ul_time = ul_time.substring(0,ul_time.length()-8);
%>
<table align="center" width="100%" class="main-table">
<form name="formData" method="post" action="RunningList.jsp">
	<tr class="title1" width="100%">
		<td colspan="2" class="outset-table">网站运行情况查询
		</td>
	</tr>
	<tr class="line-odd">
		<td width="40%" align="right">查询时间：</td>
		<td>
			<input name="begin_time" style="cursor:hand" class="text-line" readonly size="10" onclick="showCal()" value="<%=ul_time%>">&nbsp;至
			<input name="end_time" style="cursor:hand" class="text-line" readonly size="10" onclick="showCal()" value="<%=ul_time%>">
		</td>
	</tr>
	<tr class="title1" width="100%">
		<td colspan="2" class="outset-table">
			<input type="submit" class="bttn" value="搜索">&nbsp;
			<input type="reset" class="bttn" value="重写">&nbsp;
		</td>
	</tr>
<input type="hidden" name="OPType" value="search">
<input type="hidden" name="status1" value="">
</form>
</table>
<%@include file="/system/app/skin/bottom.jsp"%>