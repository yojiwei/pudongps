<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%@include file="/system/app/skin/skin4/template/info_top.jsp"%>
<!--    模块名称开始    -->
工商局用户查询
<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/info_funtion.jsp"%>
<!--    功能按钮开始    -->
工商局用户查询
<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/info_main.jsp"%>
<!--    表单提交开始    -->
<%
String sqlStr  = "";
Vector vPage = null;
Hashtable content = null;
String us_uid = "";
String us_name = "";
String gu_check = "";
String gu_time = "";
CDataCn dCn = null;
CDataImpl dImpl = null;
try {
	dCn = new CDataCn();
	dImpl = new CDataImpl(dCn);
	us_uid = CTools.dealString(request.getParameter("us_uid")).trim();

%>
<table align="center" width="100%" CELLPADDING="1" cellspacing="1">
<form name="formTata" method="post" action="AnswerUser.jsp">
	<input type="hidden" name="status1" value="">
	<tr class="line-even">
		<td width="15%" align="right">用户登录名</td>
		<td align="left"><input name="us_uid" class="text-line" maxlength="20"></td>
	</tr>
	<tr class="title1" width="100%">
		<td colspan="2" class="outset-table">
			<input type="submit" class="bttn" value="查询">&nbsp;
			<input type="reset" class="bttn" value="重写">&nbsp;
		</td>
	</tr>
</form>
</table>
<!--用户表格-->
<table class="FindAreaTable1" cellspacing="1" rules="cols" border="0" id="ctl00_DataGrid_DataGrid1" style="border-width:0px;">
<form name="formData" method="post">
		<tr width="100%" class="bttn">
			<td align="center" class="outset-table" width="4%" >序号</td>
			<td align="center" class="outset-table" width="6%"  >用户名</td>
			<td align="center" class="outset-table" width="8%" >姓名</td>
			<td align="center" class="outset-table" width="17%" >状态</td>
			<td align="center" class="outset-table" width="13%" >时间</td>
			<td align="center" class="outset-table"  width="16%">操作</td>
		</tr>
<%
if(!"".equals(us_uid)){
		sqlStr = "select u.us_uid,u.us_name,g.gu_check,g.gu_time from tb_user u,tb_usergsj g where u.us_uid = g.gu_uid(+)";
		
			sqlStr += " and u.us_uid = '"+us_uid+"'";
		
		sqlStr += " order by g.gu_id desc";
		
		vPage = dImpl.splitPage(sqlStr,request,20);
		if (vPage!=null)
		{
			for (int i=0;i<vPage.size();i++)
			{
				content = (Hashtable)vPage.get(i);
				us_uid = CTools.dealNull(content.get("us_uid"));
				us_name = CTools.dealNull(content.get("us_name"));
				gu_check = CTools.dealNull(content.get("gu_check"));
				gu_time = CTools.dealNull(content.get("gu_time"));
%>
			<tr width="100%" <%if (i%2==0) out.print("class='line-even'");else out.print("class='line-odd'");%>>
				<td><%=(i+1)%></td>
				<td align="center"><%=us_uid%></td>
				<td align="center"><%=us_name%></td>
				<td align="center"><%=gu_check.equals("1")?"开启":"未开启"%></td>
				<td align="center"><%=gu_time%></td>
				<td align="center"><a href="AnswerUserResult.jsp?us_uid=<%=us_uid%>&gu_check=<%=gu_check.equals("1")?"0":"1"%>"><%=gu_check.equals("1")?"关闭":"开启"%></a></td>
			</tr>
		<%
	}
}
}
else
{
	out.print("<tr class='line-even'><td colspan='20'>没有匹配记录</td></tr>");
}
%>
</form>
</table>
<!--    表单提交结束    -->
<%@include file="/system/app/skin/skin4/template/list_bottom.jsp"%> 
<%
	} catch (Exception e) {
	out.print(e.toString());
} finally {
	dImpl.closeStmt();
	dCn.closeCn();
}
%>
<%@include file="/system/app/skin/bottom.jsp"%>
                                     
