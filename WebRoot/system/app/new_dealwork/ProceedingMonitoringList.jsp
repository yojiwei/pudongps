<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%
String strTitle = "监控办事事项地址变化列表";
String sqlStr = "";
String pr_name = ""; 
String pr_applyTime = "";
String pr_address = "";
String pr_address_new = "";
String dt_name = "";
String pr_id = "";
String id = "";
String status = "";


CDataCn dCn = null;
CDataImpl dImpl = null;

try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn);

sqlStr = "select p.id,p.title,p.status,p.address,p.address_new,to_char(p.updatetime,'yyyy-MM-dd hh24:mi:ss') as updatetime,d.dt_name from tb_proceedingcontrol_new p,tb_deptinfo d where p.dtid = d.dt_id order by p.id desc";

%>
<%@include file="/system/app/skin/skin4/template/list_top.jsp"%>
<!--    模块名称开始    -->
<%=strTitle%>
<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/list_function.jsp"%>                                                            
<!--    功能按钮开始    -->
  
<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/list_listtop.jsp"%>                                                                                        
<!--    列表开始    -->
<table class="FindAreaTable1" cellspacing="1" rules="cols" border="0" id="ctl00_DataGrid_DataGrid1" style="border-width:0px;">
<form name="formData" method="post">
	<tr width="100%" class="bttn">
		<td align="center" class="outset-table">&nbsp;</td>
		<td align="center" class="outset-table">事项名称</td>
		<td align="center" class="outset-table">原办事地址</td>
		<td align="center" class="outset-table">新办事地址</td>
		<td align="center" class="outset-table">修改日期</td>
		<td align="center" class="outset-table">部门</td>
		<td align="center" class="outset-table">操作</td>
	</tr>
<%
Vector vPage = dImpl.splitPage(sqlStr,request,20);
if (vPage!=null)
{
	for (int i=0;i<vPage.size();i++)
	{
		Hashtable content = (Hashtable)vPage.get(i);
		id=CTools.dealNull(content.get("id"));
		pr_name=CTools.dealNull(content.get("title"));
		pr_address = CTools.dealNull(content.get("address"));
		pr_address_new = CTools.dealNull(content.get("address_new"));
		dt_name = CTools.dealNull(content.get("dt_name"));
		pr_applyTime = CTools.dealNull(content.get("updatetime"));
		status = CTools.dealNull(content.get("status"));
		%>
		<tr width="100%" <%if (i%2==0) out.print("class='line-even'");else out.print("class='line-odd'");%>>
			<td><%=(i+1)%></td>
			<td <%if("1".equals(status)){%>style="color:#cccccc;"<%}%>><%=pr_name%></td>
			<td <%if("1".equals(status)){%>style="color:#cccccc;"<%}%>><%=pr_address%></td>
			<td <%if("1".equals(status)){%>style="color:#cccccc;"<%}%>><%=pr_address_new%></td>
			<td <%if("1".equals(status)){%>style="color:#cccccc;"<%}%>><%=pr_applyTime%></td>
			<td <%if("1".equals(status)){%>style="color:#cccccc;"<%}%>><%=dt_name%></td>
			<td><a href="ProceedingMonitoringControl.jsp?id=<%=id%>">通知</a></td>
		</tr>
		<%
	}
}
else
{
	out.print("<tr class='line-even'><td colspan='9'>没有匹配记录</td></tr>");
}
%>
</form>
</table>
<!--    列表结束    -->
<%@include file="/system/app/skin/skin4/template/list_bottom.jsp"%> 
<%
}
catch(Exception e){
	System.out.print(e.toString());
}
finally{
	dImpl.closeStmt();
	dCn.closeCn(); 
}
%>
<%@include file="/system/app/skin/bottom.jsp"%>