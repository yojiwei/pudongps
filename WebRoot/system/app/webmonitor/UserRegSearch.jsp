<%@ page contentType="text/html; charset=GBK" %>
<%@include file="/system/app/skin/head.jsp"%>
<%
CDate searchtime = new CDate();
//String ul_time = searchtime.getNowTime();
String ul_time=(new java.util.Date()).toLocaleString();//发布时间
ul_time = ul_time.substring(0,ul_time.length()-8);
%>
<table align="center" width="100%" class="main-table">
<form name="formData" method="post" action="UserRegList.jsp">
	<tr class="title1" width="100%">
		<td class="outset-table">用户注册查询
		</td>
	</tr>
	<tr class="line-odd">
		<td align="center">
			<input name="ul_begintime" style="cursor:hand" class="text-line" readonly size="10" onclick="showCal()" value="<%=ul_time%>">
			--
			<input name="ul_endtime" style="cursor:hand" class="text-line" readonly size="10" onclick="showCal()" value="<%=ul_time%>">
		</td>
	</tr>
	<tr class="title1" width="100%">
		<td class="outset-table">
			<input type="submit" class="bttn" value="搜索">&nbsp;
			<input type="reset" class="bttn" value="重写">&nbsp;
		</td>
	</tr>
<input type="hidden" name="OPType" value="search">
<input type="hidden" name="status1" value="">
</form>
</table>
<%@include file="/system/app/skin/bottom.jsp"%>