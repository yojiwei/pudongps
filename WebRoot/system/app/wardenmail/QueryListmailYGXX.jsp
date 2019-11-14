<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%
//update 20100702
String strTitle = "阳光信箱查询列表";
String dtId = "";                //部门ID
String sqlStr = "";
String cp_name = "";             //项目名称
String cw_applyPeople = "";      //申请人
String cp_applyTime = "";        //项目申请时间
String cp_timeLimit = "";		     //项目时限
String cp_tasks = "项目办理";
String isOverTime = "";          //项目是否已经超时
String color = "";               //项目超时的时候，设置标志的颜色和title
String applyTime = "";           //收信时间
String status = "1";             //信件状态 1待处理、2处理中、8协调中、3已处理、4、已签收、9垃圾、12重复、18父信件完成状态
String beginTime = "";           //开始查询时间
String endTime = "";             //结束查询时间   
String cw_isovertime ="";        //是否办理超时0未超时1超时
String cw_isovertimem ="";	     //是否处理超时0未超时1超时   
String rol_id = "";              //后台登录用户ID  
CDataCn dCn = null;
CDataImpl dImpl = null;
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn);

cw_applyPeople = CTools.dealString(request.getParameter("applyPeople")).trim();
beginTime = CTools.dealString(request.getParameter("beginTime")).trim();
endTime = CTools.dealString(request.getParameter("endTime")).trim();
cp_name = CTools.dealString(request.getParameter("pr_name")).trim();
status = CTools.dealString(request.getParameter("status1")).trim();
%>
<!-- 记录日志 -->
<%
String logstrMenu = "区长信件";
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
					<td align="center" class="outset-table" width="5%" >序号</td>					
					<td align="center" class="outset-table" width="8%"  >状态</td>
					<td align="center" class="outset-table" width="8%" nowrap >区长信箱</td>
					<td align="center" class="outset-table" width="10%" >发信人</td>
					<td align="center" class="outset-table" width="20%" >主题</td>					 
					<td align="center" class="outset-table" width="12%" >发送时间</td>
					<td align="center" class="outset-table" width="12%" >处理时限</td>
					<td align="center" class="outset-table" width="8%" >受理超时</td>
					<td align="center" class="outset-table" width="8%" >办理超时</td>
					<td align="center" class="outset-table"  width="8%">操作</td>
				</tr>
<%
   com.app.CMySelf mySelf = (com.app.CMySelf)session.getAttribute("mySelf"); //当前用户的部门id
	 dtId = Long.toString(mySelf.getDtId());//后台登录用户部门ID
	 rol_id = String.valueOf(mySelf.getMyID());//后台登录用户iD

sqlStr = "select a.cw_status,a.cw_id,a.cp_id,a.cw_isovertime,a.cw_isovertimem,a.cw_applyingname,a.cw_subject,to_char(a.cw_applytime,'yyyy-mm-dd hh24:mi:ss') as cw_applytime,3 as cp_timelimit,s.sj_name,60 as cp_timelimiting from tb_connwork a,tb_subject s where a.cp_id='mailYGXX' and a.wd_id=s.sj_id ";

CRoleAccess ado = new CRoleAccess(dCn);
if (!ado.isAdmin(rol_id)){
	sqlStr += " and b.dt_id = " + dtId;
}
if (!"".equals(status)) {
	sqlStr += " and a.cw_status in(" +status+ ")";
}
if(!cp_name.equals(""))
{
	sqlStr += " and a.cw_subject like '%"+cp_name+"%'";
}
if(!cw_applyPeople.equals(""))
{
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

sqlStr += " order by a.cw_applytime desc";

//out.println(sqlStr);
Vector vPage = dImpl.splitPage(sqlStr,request,20);
if (vPage!=null)
{
	for (int i=0;i<vPage.size();i++)
	{
		Hashtable content = (Hashtable)vPage.get(i);
		cw_isovertime = CTools.dealNull(content.get("cw_isovertime"));
		cw_isovertimem = CTools.dealNull(content.get("cw_isovertimem"));
		%>
				<tr width="100%" <%if (i%2==0) out.print("class='line-even'");else out.print("class='line-odd'");%>>
					<td><%=(i+1)%></td>					
					<td align="center" nowrap>
						<%
						status = CTools.dealNull(content.get("cw_status"));
						if(!"".equals(status)){
							switch(Integer.parseInt(status))
							{
								case 1:status = "待处理";break;
								case 2:status = "进行中";break;
								case 3:status = "已完成";break;
								case 8:status = "协调中";break;
							}
						}else{
							status = "其 他";	
						}
						out.print(status);
						%>
					</td>
					<td nowrap><%=CTools.dealNull(content.get("wd_name"))%></td>
					<td align="center"><%=CTools.dealNull(content.get("cw_applyingname"))%></td>
					<td><%=CTools.dealNull(content.get("cw_subject"))%></td>						
					<td align="center" nowrap>
					<%
						applyTime = CTools.dealNull(content.get("cw_applytime"));
						out.print(applyTime);
				  %></td>
					<td align="center"><%=CTools.dealNull(content.get("cp_timelimit"))%>天</td>
					<td align="center"><%=cw_isovertime.equals("1")?"<font style='color:red'>是</font>":"否"%></td>
					<td align="center"><%=cw_isovertimem.equals("1")?"<font style='color:red'>是</font>":"否"%></td>
					<td align="center">
					<%
          if (status.equals("进行中"))
          {
          %>
             <span style="cursor:hand" onclick="javascript:window.location='AppealInfo.jsp?cw_id=<%=content.get("cw_id").toString()%>&cw_status=<%=content.get("cw_status").toString()%>'">处 理</span>
          <%
          }
          else
          {
          %>
             <span style="cursor:hand" onclick="javascript:window.location='AppealInfo.jsp?cw_id=<%=content.get("cw_id").toString()%>&cw_status=<%=content.get("cw_status").toString()%>'">查 看</span>
          <%}%>
					</td>
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