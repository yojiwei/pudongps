<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%
String strTitle = "查询结果";
CDataCn dCn = null;
CDataImpl dImpl = null;
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn);
//
String cg_ep_name="";
String cg_ep_kind="";
String cg_chargedepartment="";
String cg_grade="";
String sWhere="";
cg_ep_name=CTools.dealString(request.getParameter("cg_ep_name")).trim();
cg_ep_kind=CTools.dealString(request.getParameter("cg_ep_kind")).trim();
cg_chargedepartment=CTools.dealString(request.getParameter("cg_chargedepartment")).trim();
cg_grade=CTools.dealString(request.getParameter("cg_grade")).trim();


if (!cg_ep_name.equals(""))
	{
		sWhere += " and cg_ep_name like '%" + cg_ep_name + "%'";
	}
if (!cg_ep_kind.equals(""))
	{
		sWhere += " and cg_ep_kind like '%" + cg_ep_kind + "%'";
	}
if (!cg_chargedepartment.equals(""))
	{
		sWhere += " and cg_ep_code like '%" + cg_chargedepartment + "%'";
	}
if (!cg_grade.equals(""))
	{
		sWhere += " and cg_grade = '" + cg_grade + "'";
	}

String strSql="select cg_id,cg_ep_code,cg_ep_name,cg_ep_kind,cg_grade,cg_sequence from tb_kjcreditgrade where 1=1 "+ sWhere +" order by cg_sequence,cg_id desc";
Vector vectorPage = dImpl.splitPage(strSql,request,20);

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
 <form name="formData">
    <tr class="bttn">
        <td width="44%" class="outset-table">单位名称</td>
        <td width="18%" class="outset-table">企业类型</td>
        <td width="10%" class="outset-table">主管部门</td>
        <td width="12%" class="outset-table">会计信用等级</td>
        <td width="8%" class="outset-table">排序</td>
        <td width="8%" class="outset-table">操作</td>
    </tr>
<%
  if(vectorPage!=null)
  {
    for(int j=0;j<vectorPage.size();j++)
    {
      Hashtable content = (Hashtable)vectorPage.get(j);
      if(j % 2 == 0)  out.print("<tr class=\"line-even\">");
      else out.print("<tr class=\"line-odd\">");
%>
        <td align="center"><%=CTools.dealNull(content.get("cg_ep_name"))%></td>
        <td align="center"><%=CTools.dealNull(content.get("cg_ep_kind"))%></td>
        <td align="center"><%=CTools.dealNull(content.get("cg_ep_code"))%></td>
        <td align="center"><%=CTools.dealNull(content.get("cg_grade"))%></td>
        <td align=center><input type=text class=text-line name='<%="module"+CTools.dealNull(content.get("cg_id"))%>' value="<%=CTools.dealNull(content.get("cg_sequence"))%>" size=4 maxlength=4></td>
        <td align="center"><a href="creditGradeInfo.jsp?OPType=Edit&cg_id=<%=CTools.dealNull(content.get("cg_id"))%>"><img class="hand" border="0" src="/system/images/modi.gif" title=编辑" WIDTH="16" HEIGHT="16"></a>
				&nbsp;
				<a href="creditGradeDel.jsp?OPType=del&cg_id=<%=CTools.dealNull(content.get("cg_id"))%>">
				<img class="hand" border="0" src="/system/images/delete.gif" title="删除" WIDTH="16" HEIGHT="16" onclick="return window.confirm('确认要删除该记录么?');"></a>
				</td>
    </tr>
<%
    }
%>
	</form>
<%
  }
  else
  {
    out.println("<tr><td colspan=6>没有记录！</td></tr>");
  }
%>
</table>
<!--    列表结束    -->
<%@include file="/system/app/skin/skin4/template/list_bottom.jsp"%> 
<%
}
catch(Exception ex){
	System.out.println(new java.util.Date() + "--"
			+ request.getServletPath() + " : " + ex.getMessage());
}
finally{
	dImpl.closeStmt();
	dCn.closeCn(); 
}
%>
<%@include file="/system/app/skin/bottom.jsp"%>