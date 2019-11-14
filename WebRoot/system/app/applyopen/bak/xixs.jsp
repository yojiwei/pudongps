<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%
	String id = "";
	String dname = "";
	String reportdate = "";
	String dt_name = "";
	Vector vPage = null;
	Hashtable content = null;
	CMySelf self = (CMySelf)session.getAttribute("mySelf");
	String dt_id="";
	dt_id = String.valueOf(self.getDtId());
	//
CDataCn dCn = null;
CDataImpl dImpl = null;
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn);
%>
<%@include file="/system/app/skin/skin4/template/list_top.jsp"%>
<!--    模块名称开始    -->
信息查看
<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/list_function.jsp"%>                                                            
<!--    功能按钮开始    -->
  
<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/list_listtop.jsp"%>                                                                                        
<!--    列表开始    -->
<table class="FindAreaTable1" cellspacing="1" rules="cols" border="0" id="ctl00_DataGrid_DataGrid1" style="border-width:0px;">
				<tr class="bttn">
					<td width="5%" class="outset-table">
						序号
					</td>
					<td width="10%" class="outset-table">
						报告日期
					</td>
					<td width="15%" class="outset-table">
						部门名称
					</td>
					<td width="5%" class="outset-table">
						报送日期
					</td>
					<td width="5%" class="outset-table">
						查看
					</td>
				</tr>
				<%
					String rpym = "";
					String sqlStr = "select i.id,i.dname,i.reportyear,i.reportmonth,to_char(i.reportdate,'yyyy-mm-dd') as reportdate,d.dt_name from iostat i,tb_deptinfo d where i.did=d.dt_id and i.uiid in (select ui_id from tb_userinfo where dt_id="+dt_id+") order by id desc";
					vPage = dImpl.splitPage(sqlStr, request, 15);
					if (vPage != null) {
						for (int i = 0; i < vPage.size(); i++) {
							content = (Hashtable) vPage.get(i);
							id = content.get("id").toString();
							dname = content.get("dname").toString();
							reportdate = content.get("reportdate").toString();
							dt_name = content.get("dt_name").toString();
							rpym = content.get("reportyear").toString() + "-"
							+ content.get("reportmonth").toString();
							if (i % 2 == 0)
						out.print("<tr class=\"line-even\">");
							else
						out.print("<tr class=\"line-odd\">");
				%>
				<td width="5%">
					<%=i + 1%>
				</td>
				<td width="5%">
					<%=rpym%>
				</td>
				<td width="5%">
					<%=dt_name%>
				</td>
				<td width="10%">
					<%=reportdate%>
				</td>
				<td width="5%">
					<a href="ckList.jsp?id=<%=id%>&reportyear=<%=content.get("reportyear").toString()%>&reportmonth=<%=content.get("reportmonth").toString()%>&dt_name=<%=dt_name%>&dt_id=<%=dt_id%>"><img class="hand" border="0"
							src="../../images/modi.gif" title="查看" WIDTH="16" HEIGHT="16">
					</a>
				</td>
				</tr>
				<%
				}
		} else {
	%>
	<tr>
		<td colspan=10>暂无信息</td>
	</tr>
	<%
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