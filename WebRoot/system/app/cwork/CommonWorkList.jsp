<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%
String strTitle = "常用事务列表";
String workId = "";
String OType    = CTools.dealString(request.getParameter("OType")).trim();
String userKind = CTools.dealString(request.getParameter("userKind")).trim();
String workName = CTools.dealString(request.getParameter("workName")).trim();
String sqlStr = "select a.*,b.uk_name from tb_commonwork a,tb_userkind b where a.cw_name like '%"+workName+"%' and a.uk_id like '%"+userKind+"%' and a.uk_id=b.uk_id order by a.cw_sequence asc";
if (OType.equals("query"))
{
	strTitle += ">>搜索结果";
}

CDataCn dCn = null;
CDataImpl dImpl = null;
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn);
%>
<%@include file="/system/app/skin/skin4/template/list_top.jsp"%>
<!--    模块名称开始    -->
<%=strTitle%>
<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/list_function.jsp"%>                                                            
<!--    功能按钮开始    -->
<img src="../../images/new.gif" border="0" onclick="window.location='CommonWorkInfo.jsp'" title="新建常用事务" style="cursor:hand" align="absmiddle" WIDTH="16" HEIGHT="16">
新建常用事务
<img src="../../images/sort.gif" title="修改排序" border="0" style="cursor:hand" onclick="javascript:setSequence();" width="16",height="16" align="absmiddle">
修改排序
<img src="../../images/goback.gif" border="0" onclick="javascript:history.back();" title="返回" style="cursor:hand" align="absmiddle">
返回
<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/list_listtop.jsp"%>                                                                                        
<!--    列表开始    -->
<table class="FindAreaTable1" cellspacing="1" rules="cols" border="0" id="ctl00_DataGrid_DataGrid1" style="border-width:0px;">
 <form name="formData" method="post">
  <tr class="bttn" width="100%">
    <td align="center" width="10%">事务ID</td>
    <td align="center" width="10%">用户类型</td>
    <td align="center" width="50%">事务名称</td>
    <td align="center" width="10%">状态</td>
    <td align="center" width="10%">编辑</td>
    <td align="center" width="10%">排序</td>
  </tr>
<%
Vector vPage = dImpl.splitPage(sqlStr,request,20);
if (vPage != null)
{
	for (int i=0;i<vPage.size();i++)
	{
		Hashtable content = (Hashtable)vPage.get(i);
		workId = content.get("cw_id").toString();
		%>
		<tr width="100%" <%if (i%2==0) out.print("class='line-odd'");else out.print("class='line-even'");%>>
			<td align="center"><%=content.get("cw_id").toString()%></td>
			<td align="center"><%=content.get("uk_name").toString()%></td>
			<td><%=content.get("cw_name").toString()%></td>
			<td align="center"><%if (content.get("cw_flag").toString().equals("0")) out.print("<div title='事务未启用'><font color='red'>！</font></div>");%></td>
			<td align="center"><a href="CommonWorkInfo.jsp?OType=Edit&workId=<%=workId%>"><img class="hand" border="0" src="../../images/modi.gif" title="编辑" WIDTH="16" HEIGHT="16"></a></td>
			<td align="center"><input class="text-line" name="<%="module" + content.get("cw_sequence").toString()%>" size="5" value="<%=content.get("cw_sequence").toString()%>"></td>
		</tr>
		<%
	}
  %>
  </form>
<%
}
else
{
	out.print("<tr class='line-even'><td>没有匹配记录</td></tr>");
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