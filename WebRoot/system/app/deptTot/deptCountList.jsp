<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%
CMySelf self = (CMySelf)session.getAttribute("mySelf");
String selfdtid = String.valueOf(self.getDtId());
String sender_id = String.valueOf(self.getMyID());
String title = CTools.dealString(request.getParameter("title"));
String tt_type = CTools.dealString(request.getParameter("tt_type"));
String sqlWhere = "";
if (!"".equals(tt_type)) {
	sqlWhere = " and tt_type = " + tt_type;
}
else { 
	sqlWhere = " and tt_type = 0";
	tt_type = "0";
}
String sqlStr = "select * from tb_totdept where tt_flag = 0 " + sqlWhere + " order by tt_sequence";

Hashtable content = null;
Vector vPage = null;
String tt_id = "";
String tt_dtname = "";
String tt_dtids = "";
String tt_dir = "";
String tt_sequence = "";
String strTitle = !"".equals(title) ? title : "统计数据管理列表";
	
CDataCn dCn = null;
CDataImpl dImpl = null;
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn);

vPage = dImpl.splitPage(sqlStr,request,20);
%>
<%@include file="/system/app/skin/skin4/template/list_top.jsp"%>
<!--    模块名称开始    -->
<%=strTitle%>
<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/list_function.jsp"%>                                                            
<!--    功能按钮开始    -->
<img src="../../images/ftp4.gif" border="0" onclick="window.location='deptCountEdit.jsp?tt_type=0&type=add'" title="新建主题" style="cursor:hand" align="absmiddle" WIDTH="16" HEIGHT="16">
新建主题
<img src="../../images/new.gif" border="0" onclick="window.location='deptCountEdit.jsp?tt_type=<%=tt_type%>&type=add&tt_id=<%=tt_type%>'" title="新建数据" style="cursor:hand" align="absmiddle" WIDTH="16" HEIGHT="16">
新建数据
<img src="../../images/dialog/sort.gif" border="0" onclick="setSequence()" title="修改排序" style="cursor:hand" align="absmiddle" WIDTH="15" HEIGHT="15">
修改排序
<img src="../../images/goback.gif" border="0" onclick="javascript:history.back();" title="返回" style="cursor:hand" align="absmiddle">
返回                
<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/list_listtop.jsp"%>                                                                                        
<!--    列表开始    -->
<script language="javascript">
<!--
	function doEdit(obj) {
		location.href = "deptCountEdit.jsp?type=edit&tt_type=" + <%=tt_type%> + "&tt_id=" + obj;
	}
	
	function doDel(obj) {
  		if (!confirm("您确定要删除该数据吗？")) return;
		location.href = "deptCountDel.jsp?type=del&tt_type=" + <%=tt_type%> + "&tt_id=" + obj;
	}
//-->
</script>
<table class="FindAreaTable1" cellspacing="1" rules="cols" border="0" id="ctl00_DataGrid_DataGrid1" style="border-width:0px;">
<form name="formData">
        <tr class="bttn">
		    <td width="15%" height="1" class="outset-table">序号</td>
		    <td width="48%" height="1" class="outset-table">名称</td>
		    <td width="17%" height="1" class="outset-table">代码</td>
		    <td width="10%" height="1" class="outset-table">修改</td>
		    <td width="10%" height="1" class="outset-table">删除</td>
		</tr>
		<%
			int j = 0;
			if (vPage != null) {
				for (int i = 0;i < vPage.size();i++) {
					j++;
					content = (Hashtable)vPage.get(i);
					tt_id = content.get("tt_id").toString();
					tt_dtname = content.get("tt_dtname").toString();
					tt_dtids = content.get("tt_dtids").toString();
					tt_dir = content.get("tt_dir").toString();
					tt_sequence = content.get("tt_sequence").toString();
		%>
        <tr class="<%=i%2==0 ? "line-even" : "line-odd"%>">
		    <td><%=j%></td> 
		    <td>
		    <%
		    	if (tt_type.equals("0")) {
		    %>
		    <a href="javascript:location.href='deptCountList.jsp?tt_id=<%=tt_id%>&tt_type=<%=tt_id%>&display=display'"><%=tt_dtname%></a>
		    <%
		    	}
		    	else {
		    %>
		    <a href="javascript:location.href='deptCountSel.jsp?tt_id=<%=tt_id%>&tt_type=<%=tt_type%>&display=display'"><%=tt_dtname%></a>
		    <%
		    	}
		    %>
		    </td>
		    <td><%=tt_dir%></td>
		    <td>
		    <a href='javascript:doEdit(<%=tt_id%>)'><img src='/system/images/dialog/icon3.gif' border='0' height=16 width=16 title='修改'></a>
		    </td>
		    <td>
		    <a href='javascript:doDel(<%=tt_id%>)'><img src='/system/images/dialog/delete.gif' border='0' height=16 width=16 title='删除'></a>
		    </td>
		</tr>
		<%
				}
			}
			else {
				out.println("<tr><td colspan=25>该栏目暂时没有信息!</td></tr>");
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