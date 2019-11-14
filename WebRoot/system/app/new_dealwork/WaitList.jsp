<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<script language="javascript">
function completeAdd(val)
{
	if (confirm("您已经得到所有需要的文件，确认吗？"))
	{
		formData.action = "CompleteAdd.jsp?wo_id="+val;
		formData.submit();
	}
}

function reCheckWoId(valueName,valueId){
	if (confirm("您需要将\""+valueName+"\"重新提交到内网，确认吗？")){
		formData.action = "projectReCheck.jsp?wo_id="+valueId;
		formData.submit();
	}
}

</script>
<%
String OPType = "";
String strTitle = "在补件项目列表";
String dtId = "";
String sqlStr = "";
String pr_name = "";                          //项目名称
String wo_applyPeople = "";                   //申请人	
String wo_projectname="";
String pr_applyTime = "";                     //项目申请时间
String pr_timeLimit = "";		      						//项目时限
String pr_task = "办理";
String pr_reCheck = "提交内网";
String isOverTime = "";                       //项目是否已经超时
String color = "",overTitle="";               //项目超时的时候，设置标志的颜色和title
String applyTime = "";
String status = "";
String beginTime = "";
String endTime = "";
String wo_id = "";
String pr_id = "";
String wo_sparehour="";
String dt_name = "";

OPType = CTools.dealString(request.getParameter("OPType")).trim();
wo_applyPeople = CTools.dealString(request.getParameter("applyPeople")).trim();
beginTime = CTools.dealString(request.getParameter("beginTime")).trim();
endTime = CTools.dealString(request.getParameter("endTime")).trim();
pr_name = CTools.dealString(request.getParameter("pr_name")).trim();
status = CTools.dealString(request.getParameter("status")).trim();
if (status.equals(""))
{
	strTitle = "待处理业务列表";
	status = "'1'";
}

if (OPType.equals("search"))
{
	strTitle = "查询结果";	
	status = CTools.dealString(request.getParameter("status1")).trim();;
}

CDataCn dCn = null;
CDataImpl dImpl = null;

CDataCn msgDcn = null;
CDataImpl msgDimpl = null;

try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn);

msgDcn = new CDataCn(); 
msgDimpl = new CDataImpl(msgDcn);

com.app.CMySelf mySelf = (com.app.CMySelf)session.getAttribute("mySelf"); //当前用户的部门id

if(mySelf!=null)
{
	dtId = Long.toString(mySelf.getDtId());
}
else
{
	response.sendRedirect("/system/app/index.jsp");
	out.close();
}
sqlStr = "select a.wo_status,a.wo_id,a.wo_sparehour,a.pr_id,a.wo_isovertime,a.wo_applypeople,a.wo_projectname,to_char(a.wo_applytime,'yyyy-mm-dd hh24:mi:ss') wo_applytime,b.pr_timelimit,c.dt_name ";
sqlStr += "from tb_work a,tb_proceeding_new b,tb_deptinfo c ";
sqlStr += "where a.wo_status in(" +status+ ") and a.wo_projectname like '%"+pr_name+"%' and a.wo_applypeople like '%"+wo_applyPeople+"%' and a.pr_id=b.pr_id and b.dt_id=c.dt_id ";

//update by 20091228
//如果是超级管理员administrator显示全部
if(!"11883".equals(dtId)){
	sqlStr += "and c.dt_id="+dtId;	
}
if (!beginTime.equals(""))
{
 	sqlStr += " and a.wo_applytime > to_date('" + beginTime + " 00:00:00','yyyy-mm-dd hh24:mi:ss') ";
}
if (!endTime.equals(""))
{
	sqlStr += " and a.wo_applytime < to_date('" + endTime + " 23:59:59','yyyy-mm-dd hh24:mi:ss')";
}
sqlStr += " order by wo_applytime desc";





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
		<td align="center" class="outset-table"><div title="红色表示超时，绿色表示未超时，黄色表示即将超时">●</div></td>
		<td align="center" class="outset-table">状态</td>
		<td align="center" class="outset-table">项目名称</td>
		<td align="center" class="outset-table">提交人</td>
		<td align="center" class="outset-table">提交日期</td>
		<td align="center" class="outset-table">项目时限</td>
		<%
		//如果是超级管理员administrator显示全部
		if(!"11883".equals(dtId)){
		%>
		<td align="center" class="outset-table">任务处理</td>
		<%
		}else{
		%>
		<td align="center" class="outset-table">部门</td>
		<%}%>
	</tr>
<%




Vector vPage = dImpl.splitPage(sqlStr,request,20);
String msgSql = "";
Vector msgVec = null;
if (vPage!=null)
{
	for (int i=0;i<vPage.size();i++)
	{
		Hashtable content = (Hashtable)vPage.get(i);
		wo_sparehour=CTools.dealNull(content.get("wo_sparehour"));
		wo_id = CTools.dealNull(content.get("wo_id"));
		pr_id = CTools.dealNull(content.get("pr_id"));
		dt_name = CTools.dealNull(content.get("dt_name"));
		pr_timeLimit = CTools.dealNull(content.get("pr_timelimit"));
		%>
				<tr width="100%" <%if (i%2==0) out.print("class='line-even'");else out.print("class='line-odd'");%>>
					<td><%=(i+1)%></td>
					<td>
					<%
					isOverTime = content.get("wo_isovertime").toString();
					if(isOverTime.equals("0")||isOverTime.equals("")||isOverTime.equals("no"))
					{
						color = "green";
						overTitle = "未超时,还剩"+wo_sparehour+"小时";
					}
					else
					{
						color = "red";
						overTitle = "已超时"+wo_sparehour.substring(1,wo_sparehour.length())+"小时";
					}

					//--------------此断代马仅针对外事办有效-----------------update by yanker 20081014----------start------------
					if("34".equals(dtId)){
						msgSql = "select ma_id from tb_message where MA_PRIMARYID='"+ wo_id +"' ";
						msgVec = msgDimpl.splitPage(msgSql,2,1);
						if(msgVec != null){
							color = "orange";
							overTitle = "此申请已提交内网审批！";
						}
					}

					//--------------此断代马仅针对外事办有效-----------------update by yanker 20081014----------end--------------
					out.print("<div align='center' title='"+overTitle+"'><font color='"+color+"'>●</font></div>");
					%>
					</td>
					<td align="center">
						<%
						status = content.get("wo_status").toString();
						switch(Integer.parseInt(status))
						{
							case 1:status = "进行中";break;
							case 2:status = "待补件";break;
							case 3:status = "已通过";break;
							case 4:status = "未通过";break;
							case 8:status = "协调中";break;
						}
						out.print(status);
						%>
					</td>
					<%wo_projectname=content.get("wo_projectname").toString();%>
					 <td align="center" title="<%=wo_projectname%>" onclick="openMonitorWindow('<%=wo_id%>')" style="cursor:hand">
					<%
					
					if(wo_projectname.length()>15)
					{
						wo_projectname=wo_projectname.substring(0,15);
						out.println(wo_projectname+"...");
					}
					else out.println(wo_projectname);
					%>
				</td>
					<td align="center"><%=content.get("wo_applypeople").toString()%></td>
					<td align="center"><%
										applyTime = content.get("wo_applytime").toString();
										out.print(applyTime);
									   %></td>
					<td align="center"><%=(!"5201314".equals(pr_timeLimit))?pr_timeLimit+"天":"无时限"%></td>
					<td align="center">
					<%
					if (status.equals("进行中"))
					{
						//如果是超级管理员administrator显示全部
						if(!"11883".equals(dtId)){
					%>
						<span style="cursor:hand" onclick="javascript:window.location='AppWorkDetail.jsp?wo_id=<%=wo_id%>&pr_id=<%=pr_id%>'"><%=pr_task%></span>
					<%
					if("34".equals(dtId)){
					%>
						<span style="cursor:hand" onclick="javascript:reCheckWoId('<%=wo_projectname.replaceAll("'","\\\\'")%>','<%=wo_id%>')"><%=pr_reCheck%></span>
					
					<%
						}
						}else{
							%>
							<span style="cursor:hand" ><%=dt_name%></span>
							<%	
						}
					}
					else if (status.equals("待补件"))
					{
						//如果是超级管理员administrator显示全部
						if(!"11883".equals(dtId)){
					%>
						<span style="cursor:hand" onclick="completeAdd('<%=wo_id%>');">补件完成</span>
					<%
						}else{
							%>
							<span style="cursor:hand" ><%=dt_name%></span>
							<%	
						}
					}
					else if (status.equals("协调中"))
					{
					%>
						<a href="../cooperate/CorrForm.jsp?OPType=Corragain&wo_id=<%=wo_id%>&pr_id=<%=pr_id%>">
						<img src="/system/images/clip.gif" title="再次协同" width="15" height="15" border="0">
						</a>
						<img src="/system/images/hammer.gif" title="撤销协调单" width="20" height="20" border="0" style="cursor:hand" onclick="openRemovewindow('<%=wo_id%>')">
						</a>
					<%
					}
					else
						out.print("&nbsp;");
					%>
						
					</td>
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
<script>
function openMonitorWindow(wo_id)
{
	var w=500;
	var h=300;
	var url="RemoveCorr.jsp?wo_id="+wo_id;
	window.open(url,"撤销协调单","top=300px,left=300px,width="+w+",height="+h+",toolbar=no,location=no,derectories=no,status=no,menubar=no,resizable=yes,scrollbars=no");
}

function openMonitorWindow(wo_id)
{
	var w=850;
	var h=500;
	var url="WorkMonitor.jsp?wo_id="+wo_id;
	window.open(url,"项目监控","top=100px,left=100px,width="+w+",height="+h+",toolbar=no,location=no,derectories=no,status=yes,menubar=no,resizable=yes,scrollbars=yes");
}
</script>
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