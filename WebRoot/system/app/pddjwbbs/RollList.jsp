<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%
CDataCn dCn = null;
CDataImpl dImpl = null;
Vector vectorPage = null;
try{
dCn = new CDataCn("pddjw");
dImpl = new CDataImpl(dCn);
//
String strTitle="";
String sql="";
String ro_content = "";
String ro_id = "";

strTitle = "普通用户管理列表";
sql = "select ro_id,ro_content from forum_roll order by ro_id desc ";

vectorPage = dImpl.splitPage(sql,request,20);
%>
<%@include file="/system/app/skin/skin4/template/list_top.jsp"%>
<!--    模块名称开始    -->
<%=strTitle%>
<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/list_function.jsp"%>                                                            
<!--    功能按钮开始    -->
<img src="/system/images/new.gif" border="0" onclick="window.location='RollInfo.jsp?OPType=Add'" title="新增滚动标题" style="cursor:hand" align="absmiddle" WIDTH="16" HEIGHT="16">
新增滚动标题
<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/list_listtop.jsp"%>
<!--    列表开始    -->
<table class="FindAreaTable1" cellspacing="1" rules="cols" border="0" id="ctl00_DataGrid_DataGrid1" style="border-width:0px;">
<form name="formData">
    <tr class="bttn">
        <td width="2%" class="outset-table" align="center" nowrap>序号</td>
		<td width="22%" class="outset-table" align="center"  nowrap>内容</td>
        <td width="4%" class="outset-table" align="center" nowrap>操作</td>
    </tr>
<%
  if(vectorPage!=null)
  {
    for(int j=0;j<vectorPage.size();j++)
    {
      Hashtable content = (Hashtable)vectorPage.get(j);
      ro_id = CTools.dealNull(content.get("ro_id"));
      ro_content = CTools.dealNull(content.get("ro_content"));

      
      if(j % 2 == 0)  out.print("<tr class=\"line-even\">");
      else out.print("<tr class=\"line-odd\">");
%>
        <td align="center"><%=ro_id%></td>
        <td align="center"><%=ro_content%></td>
    <td align="center">
    <a href="RollInfo.jsp?OPType=Edit&ro_id=<%=ro_id%>">
		<img class="hand" border="0" src="../../images/modi.gif" title="编辑" WIDTH="16" HEIGHT="16"></a>&nbsp;
		<a href="RollDel.jsp?ro_id=<%=ro_id%>"><img class="hand" border="0" src="../../images/delete.gif" title="删除" WIDTH="16" HEIGHT="16" onclick="return window.confirm('确认要删除该记录么?');"></a>
        </td>
    </tr>
</form>
<%
    }
  }
  else
  {
    out.println("<tr><td colspan=20>没有记录！</td></tr>");
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