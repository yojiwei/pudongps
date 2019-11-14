<%@page contentType="text/html; charset=GBK"%>
<%@ include file="../skin/head.jsp"%>
<%String ne_date_begin=(new java.util.Date()).toLocaleString();//查询时间起始
ne_date_begin = ne_date_begin.substring(0,ne_date_begin.length()-8);
ne_date_begin = ne_date_begin.toString();
String ne_date_end=(new java.util.Date()).toLocaleString();//查询结束起始
ne_date_end = ne_date_end.substring(0,ne_date_end.length()-8);
ne_date_end = ne_date_end.toString();
%>
<form action="NewsList.jsp">
<table class="main-table" width="100%">
<tr align="center">
<td colspan='2'>查询相关日期的新闻发布情况</td>
</tr>
<tr class="bttn">
<td width="30%" class="outset-table">发布日期查询起始日
<input type="date" size="20" name="ne_date_begin" onclick="javascript:showCal()" style="cursor:hand" class=text-line  readonly value="<%=ne_date_begin%>">
</td>
<td width="30%" class="outset-table">发布日期查询中止日
<input type="date" size="20" name="ne_date_end" onclick="javascript:showCal()" style="cursor:hand" class=text-line  readonly value="<%=ne_date_end%>">
</td>
</tr>
<tr align="center">
<td colspan='2'>
<input type="submit" class="bttn" name="fsubmit" value="查询">
          <input type="hidden" name="OPType" value="Search">
<input type="reset" class="bttn" name="freset" value="重 写">
</td>
</tr>
</table>
</form>
