<%@ page contentType="text/html; charset=GBK" %>
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

</script>
<%
String OPType = "";
String strTitle = "业务列表";
String dtId = "";
String sqlStr = "";
String pr_name = "";                          //项目名称
String wo_applyPeople = "";                   //申请人	
String wo_projectname="";
String pr_applyTime = "";                     //项目申请时间
String pr_timeLimit = "";		      //项目时限
String pr_task = "项目办理";
String isOverTime = "";                       //项目是否已经超时
String color = "",overTitle="";               //项目超时的时候，设置标志的颜色和title
String applyTime = "";
String status = "";
String beginTime = "";
String endTime = "";
String dt_id="";
String wo_sparehour="";
String wo_isovertime="";

OPType = CTools.dealString(request.getParameter("OPType")).trim();
wo_applyPeople = CTools.dealString(request.getParameter("applyPeople")).trim();
beginTime = CTools.dealString(request.getParameter("beginTime")).trim();
endTime = CTools.dealString(request.getParameter("endTime")).trim();
pr_name = CTools.dealString(request.getParameter("pr_name")).trim();
status = CTools.dealString(request.getParameter("status")).trim();
dt_id = CTools.dealString(request.getParameter("dt_id")).trim();
wo_isovertime=CTools.dealString(request.getParameter("wo_isovertime").trim());
if (status.equals(""))
{
	status = "'1'";
}

if (OPType.equals("search"))
{
	strTitle = "查询结果";	
	status = CTools.dealString(request.getParameter("status1")).trim();;
}

//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 
%>
<table class="main-table" width="100%" align="center">
<form name="formData" method="post">
	<tr class="title1" width="100%">
		<td colspan="9" align="center"><font size="2"><%=strTitle%></font></td>
	</tr>
	<tr width="100%">
		<td colspan="9" align="center">
			<table cellspacing="1" border="0" width="100%">
				<tr width="100%" class="bttn">
					<td align="center" class="outset-table">&nbsp;</td>
					<td align="center" class="outset-table"><div title="红色表示超时，绿色表示未超时，黄色表示即将超时">●</div></td>
					<td align="center" class="outset-table">状态</td>
					<td align="center" class="outset-table">项目名称</td>
					<td align="center" class="outset-table">办理部门</td>
					<td align="center" class="outset-table">提交日期</td>
					<td align="center" class="outset-table">项目时限</td>
					<td align="center" class="outset-table">项目监控</td>
				</tr>
<%

sqlStr = "select a.wo_status,a.wo_id,a.wo_sparehour,a.pr_id,a.wo_isovertime, a.wo_projectname,to_char(a.wo_applytime,'yyyy-mm-dd hh24:mi:ss') wo_applytime,b.pr_timelimit, c.dt_name ";
sqlStr += "from tb_work a,tb_proceeding b, tb_deptinfo c ";
sqlStr += "where a.wo_status in(" +status+ ") and a.wo_projectname like '%"+pr_name+"%' and a.wo_applypeople like '%"+wo_applyPeople+"%' and a.pr_id=b.pr_id and b.dt_id=c.dt_id";

if (!dt_id.equals(""))
{
	sqlStr += " and c.dt_id="+dt_id ;
}
if (!beginTime.equals(""))
{
 	sqlStr += " and a.wo_applytime > to_date('" + beginTime + " 00:00:00','yyyy-mm-dd hh24:mi:ss') ";
}
if (!endTime.equals(""))
{
	sqlStr += " and a.wo_applytime < to_date('" + endTime + " 23:59:59','yyyy-mm-dd hh24:mi:ss')";
}
if (!wo_isovertime.equals(""))
{
	if (wo_isovertime.equals("1"))
	{
		sqlStr +=" and nvl(a.wo_isovertime,'0')='1'";
	}
	else
	{
		sqlStr +=" and nvl(a.wo_isovertime,'0') <>'1'";
	}
}

sqlStr += " order by wo_applytime desc";
Vector vPage = dImpl.splitPage(sqlStr,request,20);
if (vPage!=null)
{
	for (int i=0;i<vPage.size();i++)
	{
		Hashtable content = (Hashtable)vPage.get(i);
		wo_sparehour=content.get("wo_sparehour").toString();
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
					 <td align="center" title="<%=wo_projectname%>" onclick="openMonitorWindow('<%=content.get("wo_id").toString()%>')" style="cursor:hand">
					<%
					
					if(wo_projectname.length()>15)
					{
						wo_projectname=wo_projectname.substring(0,15);
						out.println(wo_projectname+"...");
					}
					else out.println(wo_projectname);
					%>
		</td>
					<td align="center"><%=content.get("dt_name").toString()%></td>
					<td align="center"><%
										applyTime = content.get("wo_applytime").toString();
										out.print(applyTime);
									   %></td>
					<td align="center"><%=content.get("pr_timelimit").toString()%>天</td>
					<td align="center" onclick="openMonitorWindow('<%=content.get("wo_id").toString()%>')" style="cursor:hand">
							查看
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
			</table>
		</td>
	</tr>
</form>
<tr>
	<td colspan="9" align="right"><%out.print(dImpl.getTail(request));%></td>
</tr>
</table>
<script>

function openMonitorWindow(wo_id)
{
	var w=850;
	var h=500;
	var url="/system/app/dealwork/WorkMonitor.jsp?wo_id="+wo_id;
	window.open(url,"项目监控","top=100px,left=100px,width="+w+",height="+h+",toolbar=no,location=no,derectories=no,status=yes,menubar=no,resizable=yes,scrollbars=yes");
}
</script>
<%
  dImpl.closeStmt();
  dCn.closeCn();
  } catch (Exception ex) {
	System.out.println(new java.util.Date() + "--"
			+ request.getServletPath() + " : " + ex.getMessage());
} finally {
	if(dImpl != null)
	dImpl.closeStmt();
	if(dCn != null)
	dCn.closeCn();
}
%>

<%@include file="/system/app/skin/bottom.jsp"%>
