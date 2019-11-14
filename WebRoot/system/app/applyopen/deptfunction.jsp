<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%
String s_dfunction = "";
String sqlWhere = "";
String strTitle = "";
String sqlStr = "";

Vector vPage = null;
Hashtable content = null;
//
CDataCn dCn = null;
CDataImpl dImpl = null;
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn);

s_dfunction = CTools.dealString(request.getParameter("s_dfunction")).trim();

if(!s_dfunction.equals("")) sqlWhere += " and i.commentinfo like'%"+s_dfunction+"%'";

strTitle = "信息公开一体化 > 机构职能";

sqlStr = "select id,did,dname,dfunction from deptfunction where 1=1"+sqlWhere+" order by did";

vPage = dImpl.splitPage(sqlStr,request,20);
%>
<script language="javascript" src="applyopen.js"></script>
<%@include file="/system/app/skin/skin4/template/list_top.jsp"%>
<!--    模块名称开始    -->
<%=strTitle%>
<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/list_function.jsp"%>                                                            
<!--    功能按钮开始    -->
<img src="../../images/new.gif" border="0" onclick="javascript:window.location.href='deptfunctionInfo.jsp?OPType=add'" title="新增" style="cursor:hand" align="absmiddle">
新增
<img src="../../images/goback.gif" border="0" onclick="javascript:history.back();" title="返回" style="cursor:hand" align="absmiddle">
返回
<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/list_listtop.jsp"%>                                                                                        
<!--    列表开始    -->
<table class="FindAreaTable1" cellspacing="1" rules="cols" border="0" id="ctl00_DataGrid_DataGrid1" style="border-width:0px;">
	<tr class="bttn">
		<td width="5%" class="outset-table"></td>
		<td width="25%" class="outset-table">部门名称</td>
		<td width="65%" class="outset-table">机构职能</td>
		<td width="5%" class="outset-table" nowrap></td>
	</tr><form name="formData" method="post">
	<%
	if(vPage!=null){
		for(int i=0; i<vPage.size(); i++){
			content = (Hashtable)vPage.get(i);
			String dfunction = content.get("dfunction").toString();
			dfunction = dfunction.replaceAll("&","&amp;");
			dfunction = dfunction.replaceAll("<","&lt;");
			dfunction = dfunction.replaceAll(">","&gt;");
			
			if(i%2 == 0) out.print("<tr class=\"line-even\">");
			else out.print("<tr class=\"line-odd\">");
	%>
		<td align="center"><%=+1%></td>
		<td align="center"><%=content.get("dname")%></td>
		<td align="center"><%=dfunction%></td>
		<td align="center"><a href="deptfunctionInfo.jsp?id=<%=content.get("id")%>&OPType=edit"><img class="hand" border="0" src="../../images/modi.gif" title="" WIDTH="16" HEIGHT="16"></a></td>
	</tr>
	<%
		}
		out.println("</form>");
	}else{
		out.println("<tr><td colspan=20></td></tr>");
	}
	%>
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