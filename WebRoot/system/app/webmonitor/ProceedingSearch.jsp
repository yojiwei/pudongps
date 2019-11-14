<%@page contentType="text/html; charset=GBK"%>
<%@ include file="../skin/head.jsp"%>
<%String pr_date=(new java.util.Date()).toLocaleString();//查询日期
pr_date = pr_date.substring(0,pr_date.length()-8);
String strSql= "select distinct d.dt_id,d.dt_name from tb_deptinfo d,tb_proceeding p where d.dt_id=p.dt_id ";
//out.print(strSql);
String dt_name=""; //部门名称
String dt_id="";//部门ID
%>
<form action="ProceedingList.jsp">
<table class="main-table" width="100%">
	<tr class="title1">
		<td colspan='2' align="left">&nbsp;查询网上办事情况</td>
	</tr>
	<tr class="line-even">
		<td width="15%" align="right">日期：</td>
		<td align="left">&nbsp;
			<input name="pr_date1" size="8" onclick="javascript:showCal()" style="cursor:hand" class=text-line  readonly> 至 <input name="pr_date2" size="8" onclick="javascript:showCal()" style="cursor:hand" class=text-line  readonly>
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
