<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%
CDataCn dCn = null;
CDataImpl dImpl = null;
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn);
//
String pr_id="";
pr_id = CTools.dealString(request.getParameter("pr_id")).trim();
String sql_list = " select x.pc_id,x.pc_timelimit,z.pr_name,y.dt_name from tb_proceedingcorr x,tb_deptinfo y,tb_proceeding_new z where x.pr_id=z.pr_id and x.dt_id=y.dt_id and z.pr_id='"+pr_id+"' ";

%>
<%@include file="/system/app/skin/skin4/template/list_top.jsp"%>
<!--    模块名称开始    -->
该项目相关协办部门列表
<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/list_function.jsp"%>                                                            
<!--    功能按钮开始    -->
<img src="/system/images/new.gif" border="0" onclick="window.location='CorrDeptInfo.jsp?OPType=Add&pr_id=<%=pr_id%>'" title="新增协办部门" style="cursor:hand" align="middle" WIDTH="16" HEIGHT="16">
新增协办部门
<img src="/system/images/goback.gif" border="0" onclick="javascript:history.back();" title="返回" style="cursor:hand" align="middle">
返回
<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/list_listtop.jsp"%>                                                                                        
<!--    列表开始    -->
<table class="FindAreaTable1" cellspacing="1" rules="cols" border="0" id="ctl00_DataGrid_DataGrid1" style="border-width:0px;">

        <form name="formData">
        <tr class="bttn">
            <td width="30%" class="outset-table" align="center">项目名称</td>
			<td width="20%" class="outset-table" align="center">相关协办部门名称</td>
            <td width="10%" class="outset-table" align="center">协办部门办事时限</td>
			<td width="10%" class="outset-table" align="center">操作</td>
        </tr>
		<%
		Vector vectorList = dImpl.splitPage(sql_list,request,20);
		if(vectorList!=null)
		{
			for(int i=0;i<vectorList.size();i++)
			{
				Hashtable content = (Hashtable)vectorList.get(i);
			    if(i % 2 == 0)  out.print("<tr class=\"line-even\">");
				else out.print("<tr class=\"line-odd\">");
		%>
                <td align="center"><%=content.get("pr_name")%></td>
                <td align="center" nowrap><%=content.get("dt_name")%></td>
                <td align="center"><%=content.get("pc_timelimit")%></td>
				<td align="center">
				<a href="CorrDeptInfo.jsp?OPType=Edit&pc_id=<%=content.get("pc_id")%>&pr_id=<%=pr_id%>"><img class="hand" border="0" src="../../images/modi.gif" title="编辑该部门" WIDTH="16" HEIGHT="16"></a>&nbsp;
		        <a href="CorrDeptDel.jsp?OPType=Del&pc_id=<%=content.get("pc_id")%>&pr_id=<%=pr_id%>"><img class="hand" border="0" src="../../images/delete.gif" title="删除该部门" WIDTH="16" HEIGHT="16" onclick="return window.confirm('确认要删除该记录么?');"></a>
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