<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%
String OPType = "";
String strTitle = "查询列表";
String sqlStr = "";
String cp_name = "";                          //项目名称
String cw_applyPeople = "";                   //申请人
String cp_applyTime = "";                     //项目申请时间
String cp_timeLimit = "";		      //项目时限
String isOverTime = "";                       //项目是否已经超时
String color = "",overTitle="";               //项目超时的时候，设置标志的颜色和title
String applyTime = "";
String status = "";
String statusStr = "";
String beginTime = "";
String endTime = "";
String statuSet = "";
String dt_id = "";
String cw_isovertime = "";
String cp_id = "";

cw_applyPeople = CTools.dealString(request.getParameter("applyPeople")).trim();
beginTime = CTools.dealString(request.getParameter("beginTime")).trim();
endTime = CTools.dealString(request.getParameter("endTime")).trim();
cp_name = CTools.dealString(request.getParameter("pr_name")).trim();
statuSet = CTools.dealString(request.getParameter("status1")).trim();
dt_id = CTools.dealString(request.getParameter("dt_id")).trim();
cp_id = CTools.dealString(request.getParameter("cp_id")).trim();
cw_isovertime=CTools.dealString(request.getParameter("cw_isovertime").trim());
//
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
  
<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/list_listtop.jsp"%>                                                                                        
<!--    列表开始    -->
<table class="FindAreaTable1" cellspacing="1" rules="cols" border="0" id="ctl00_DataGrid_DataGrid1" style="border-width:0px;">
<form name="formData" method="post">
<tr width="100%" class="bttn">
	<td align="center" class="outset-table" >&nbsp;</td>
	<td align="center" class="outset-table" ><div title="红色表示超时，绿色表示未超时，黄色表示即将超时">●</div></td>
	<td align="center" class="outset-table" >受理单位</td>
	<td align="center" class="outset-table" >事项类型</td>
	<td align="center" class="outset-table" >主题</td>
	<td align="center" class="outset-table" >提交人</td>
	<td align="center" class="outset-table" >状态</td>
	<td align="center" class="outset-table" >提交日期</td>
	<td align="center" class="outset-table" >回复日期</td>
	<td align="center" class="outset-table" >任务处理</td>
</tr>
<%
sqlStr = "select distinct a.cw_status,a.cw_id,a.cp_id,a.cw_isovertime,a.cw_applyingname,a.cw_subject,to_char(a.cw_applytime,'yyyy-mm-dd') cw_applytime,to_char(a.cw_finishtime,'yyyy-mm-dd') cw_finishtime,b.cp_name,b.cp_timelimit,b.dt_name,b.cp_upid,trunc(SYSDATE-cw_applytime) a_time ";
sqlStr += "from tb_connwork a,tb_connproc b,tb_deptinfo c ";
sqlStr += "where a.cw_status in(" +statuSet+ ") and (a.cw_subject like '%"+cp_name+"%' and a.cw_applyingname like '%"+cw_applyPeople+"%') and a.cp_id=b.cp_id";

if(!cp_id.equals(""))
{
	sqlStr +=" and (b.cp_upid='" + cp_id + "' or b.cp_id='" + cp_id + "')" ;
}
if(!dt_id.equals(""))
{
        sqlStr += " and b.dt_id=c.dt_id and c.dt_id="+dt_id ;
}
if (!beginTime.equals(""))
{
 	sqlStr += " and a.cw_applytime > to_date('" + beginTime + " 00:00:00','yyyy-mm-dd hh24:mi:ss') ";
}
if (!endTime.equals(""))
{
	sqlStr += " and a.cw_applytime < to_date('" + endTime + " 23:59:59','yyyy-mm-dd hh24:mi:ss')";
}
if (!cw_isovertime.equals(""))
{
	if (cw_isovertime.equals("1"))
	{
		sqlStr +=" and a.cw_isovertime='1'";
	}
	else
	{
		sqlStr +=" and (a.cw_isovertime='0' or a.cw_isovertime='' or a.cw_isovertime is null)";
	}
}
sqlStr += " order by cw_applytime desc";
Vector vPage = dImpl.splitPage(sqlStr,request,20);
if (vPage!=null)
{
	for (int i=0;i<vPage.size();i++)
	{
		Hashtable content = (Hashtable)vPage.get(i);
		String finishtime = content.get("cw_finishtime").toString();
		status = content.get("cw_status").toString();
		int status_flag = Integer.parseInt(status);
		if(finishtime.equals(""))
		{
			finishtime = "等待回复";
		}
		%>
				<tr width="100%" <%if (i%2==0) out.print("class='line-even'");else out.print("class='line-odd'");%>>
					<td align="center"><%=(i+1)%></td>
					<td>
					<%
					isOverTime = content.get("cw_isovertime").toString();
					if(isOverTime.equals("0")||isOverTime.equals(""))
					{
						color = "green";
						overTitle = "未超时";
					}
					else
					{
						color = "red";
						overTitle = "已超时";
					}
					out.print("<div align='center' title='"+overTitle+"'><font color='"+color+"'>●</font></div>");
					%>
					</td>
					<td align="center"><%=content.get("dt_name").toString()%>
					</td>
					<td align="center"><%=content.get("cp_name").toString()%>
					</td>
					<td align="center"><%=content.get("cw_subject").toString()%>
					</td>
					<td align="center"><%=content.get("cw_applyingname").toString()%></td>
					<td align="center">
					<%
					switch(status_flag)
					{
						case 1:
							out.print("待处理");
							break;
						case 2:
							out.print("处理中");
							break;
						case 3:
							out.print("已完成");
							break;
						case 8:
							out.print("转办中");
							break;
						default:
							break;
					}
					%>
					</td>					
					<td align="center"><%
						applyTime = content.get("cw_applytime").toString();
						out.print(applyTime);
					%></td>
					<td align="center"><%=finishtime%></td>
					<td align="center">
					<span style="cursor:hand" onclick="javascript:window.location='AppealInfo.jsp?cw_id=<%=content.get("cw_id").toString()%>&cw_status=<%=content.get("cw_status").toString()%>'">查 看</span>
					</td>
				</tr>
		<%
	}
}
else
{
	out.print("<tr class='line-even'><td colspan='10'>没有匹配记录</td></tr>");
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