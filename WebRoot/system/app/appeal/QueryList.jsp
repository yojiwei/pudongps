<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>

<%
String OPType = "";
String strTitle = "投诉查询列表";
String dtId = "";
String sqlStr = "";
String cp_name = "";                          //项目名称
String cw_applyPeople = "";                   //申请人
String cp_applyTime = "";                     //项目申请时间
String cp_timeLimit = "";		      						//项目时限
String isOverTime = "";                       //项目是否已经超时
String color = "",overTitle="";               //项目超时的时候，设置标志的颜色和title
String applyTime = "";
String status = "'1'";
String beginTime = "";
String endTime = "";
String [] statuSet ;
String cw_isovertime ="";
String cw_isovertimem ="";
cw_applyPeople = CTools.dealString(request.getParameter("applyPeople")).trim();
beginTime = CTools.dealString(request.getParameter("beginTime")).trim();
endTime = CTools.dealString(request.getParameter("endTime")).trim();
cp_name = CTools.dealString(request.getParameter("pr_name")).trim();
status = CTools.dealString(request.getParameter("status1")).trim();

CDataCn dCn = null;
CDataImpl dImpl = null;
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn);
%>
<!-- 记录日志 -->
<%
String logstrMenu = "网上投诉";
String logstrModule = strTitle;
%>
<%@include file="/system/app/writelogs/WriteListLog.jsp"%>
<!-- 记录日志 -->
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
					<td align="center" class="outset-table" width="4%" >序号</td>
					<td align="center" class="outset-table" width="6%"  >状态</td>
					<td align="center" class="outset-table" width="8%" >发信人</td>
					<td align="center" class="outset-table" width="17%" >主题</td>
					<td align="center" class="outset-table" width="13%" >发送时间</td>
					<td align="center" class="outset-table" width="7%" >处理部门</td>
					<td align="center" class="outset-table" width="12%" >处理时限</td>
					<td align="center" class="outset-table" width="9%" >受理超时</td>
					<td align="center" class="outset-table" width="8%" >办理超时</td>
					<td align="center" class="outset-table"  width="16%">操作</td>
				</tr>
<%
    com.app.CMySelf mySelf = (com.app.CMySelf)session.getAttribute("mySelf"); //当前用户的部门id
        
		dtId = Long.toString(mySelf.getDtId());
		String rol_id = String.valueOf(mySelf.getMyID());
		sqlStr = "select a.cw_status,a.cw_id,a.cp_id,a.cw_isovertime,a.cw_isovertimem,a.cw_applyingname,a.cw_subject,to_char(a.cw_applytime,'yyyy-mm-dd hh24:mi:ss') cw_applytime,b.cp_timelimit,b.cp_timelimiting,q.pc_timelimit ,c.dt_name from tb_connwork a,tb_connproc b,tb_deptinfo c,tb_connproccorr q where a.cp_id = b.cp_id and b.dt_id = c.dt_id and q.cp_id(+) = b.cp_id and (b.cp_id='o4'or b.cp_upid='o4')";
		
  	CRoleAccess ado = new CRoleAccess(dCn);
  	if (!ado.isAdmin(rol_id))
 		sqlStr += " and c.dt_id = " + dtId;

		if (!"".equals(status)) {
			sqlStr += " and a.cw_status in (" + status + ")";
		}
		if (!"".equals(cp_name)) {
			sqlStr += " and a.cw_subject like '%"+cp_name+"%'";
		}
		if (!"".equals(cw_applyPeople)) {
			sqlStr += " and a.cw_applyingname like '%"+cw_applyPeople+"%'";
		}
		if (!beginTime.equals(""))
		{
		 	sqlStr += " and a.cw_applytime > to_date('" + beginTime + " 00:00:00','yyyy-mm-dd hh24:mi:ss') ";
		}
		if (!endTime.equals(""))
		{
			sqlStr += " and a.cw_applytime < to_date('" + endTime + " 23:59:59','yyyy-mm-dd hh24:mi:ss')";
		}
		sqlStr += " order by cw_applytime desc";
		
		
		Vector vPage = dImpl.splitPage(sqlStr,request,20);
		if (vPage!=null)
		{
			for (int i=0;i<vPage.size();i++)
			{
				Hashtable content = (Hashtable)vPage.get(i);
				cw_isovertime = content.get("cw_isovertime").toString();
				cw_isovertimem = content.get("cw_isovertimem").toString();
%>
				<tr width="100%" <%if (i%2==0) out.print("class='line-even'");else out.print("class='line-odd'");%>>
					<td><%=(i+1)%></td>
					<td align="center">
						<%
						status = content.get("cw_status").toString();
						switch(Integer.parseInt(status))
						{
							case 1:status = "待处理";break;
							case 2:status = "处理中";break;
							case 3:status = "已完成";break;
							case 8:status = "协调中";break;
						}
						out.print(status);
						%>					</td>

					<td align="center"><%=content.get("cw_applyingname").toString()%></td>
					<td>
					<%=content.get("cw_subject").toString()%>					</td>
					<td align="center">
					<%
						applyTime = content.get("cw_applytime").toString();
						out.print(applyTime);
					%></td>
					<td align="center"><%=content.get("dt_name").toString()%></td>
					<td align="center">
					<%
						if ("待处理".equals(status))
							out.print(content.get("cp_timelimit").toString());
						else if ("处理中".equals(status))
							out.print(content.get("cp_timelimiting").toString());
						else if ("协调中".equals(status))
							out.print(content.get("pc_timelimit").toString());
						else
							out.print("0");
					%>
					天</td>
					<%
			//是否受理、办理超时
			TimeCalendar tc = new TimeCalendar();
			String cmailapplytime = content.get("cw_applytime").toString();
			String cmailid = content.get("cw_id").toString();
			String cmailisovertime = tc.getIsOverTime(cmailapplytime,cmailid,"isovertime");
		  
			if (cmailisovertime.equals("1")){
				out.print("<td align=\"center\"><span style=color:red>是</span></td>");
			 }
			 else{
				out.print("<td align=\"center\">否</td>");
			 }
			String cmailisovertimem = tc.getIsOverTime(cmailapplytime,cmailid,"isovertimem");
			 if (cmailisovertimem.equals("1")){
				out.print("<td align=\"center\"><span style=color:red>是</span></td>");
			 }
			 else{
				out.print("<td align=\"center\">否</td>");
			 }	
			%>
					<td align="center" nowrap>
					<%
					if (status.equals("待处理") || status.equals("处理中"))
					{
					%>
						<span style="cursor:hand" onclick="javascript:window.location='AppealInfo.jsp?cw_id=<%=content.get("cw_id").toString()%>&cw_status=<%=content.get("cw_status").toString()%>'">处 理</span>
					<%
					}
					else
          {
          %>
						<span style="cursor:hand" onclick="javascript:window.location='AppealInfo.jsp?cw_id=<%=content.get("cw_id").toString()%>&cw_status=<%=content.get("cw_status").toString()%>'">查 看</span>
          <%}%></td>
				</tr>
		<%
	}
}
else
{
	out.print("<tr class='line-even'><td colspan='20'>没有匹配记录</td></tr>");
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