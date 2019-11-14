<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%
String OPType = ""; 
String strTitle = "查询列表";
String dtId = "";
String sqlStr = "";
String cp_name = "";                          //项目名称
String cw_applyPeople = "";                   //申请人
String cp_applyTime = "";                     //项目申请时间
String cp_timeLimit = "";		      //项目时限
String cp_tasks = "项目办理";
String isOverTime = "";                       //项目是否已经超时
String color = "",overTitle="";               //项目超时的时候，设置标志的颜色和title
String applyTime = "";
String status = "'1'";
String beginTime = "";
String endTime = "";
String cw_isovertime ="";
String cw_isovertimem ="";
String [] statuSet ;

cw_applyPeople = CTools.dealString(request.getParameter("applyPeople")).trim();
beginTime = CTools.dealString(request.getParameter("beginTime")).trim();
endTime = CTools.dealString(request.getParameter("endTime")).trim();
cp_name = CTools.dealString(request.getParameter("pr_name")).trim();

statuSet = request.getParameterValues("status");

if (statuSet!=null)
{
	status = "";
	for(int i=0;i<statuSet.length;i++)
	{
		status += "'"+statuSet[i]+"'";
		status += ",";
	}
	status = status.substring(0,status.length()-1);
}
%>
<%
CDataCn dCn = null;
CDataImpl dImpl = null;
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn);
%>
<!-- 记录日志 -->
<%
String logstrMenu = "信访领导信箱";
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
<img src="../../images/goback.gif" border="0" onclick="javascript:history.back();" title="返回" style="cursor:hand" align="absmiddle">返回
<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/list_listtop.jsp"%>                                                                                        
<!--    列表开始    -->
<table class="FindAreaTable1" cellspacing="1" rules="cols" border="0" id="ctl00_DataGrid_DataGrid1" style="border-width:0px;">
<form name="formData" method="post">
	<tr width="100%" class="bttn">
		<td align="center" class="outset-table" >&nbsp;</td>
		<td align="center" class="outset-table" ><div title="红色表示超时，绿色表示未超时，黄色表示即将超时">●</div></td>
		<td align="center" class="outset-table" >状态</td>
		<td align="center" class="outset-table" >主题</td>
		<td align="center" class="outset-table" >提交人</td>
		<td align="center" class="outset-table" >提交日期</td>
		<td align="center" class="outset-table" >处理时限</td>
		<td align="center" class="outset-table" >任务处理</td>
	</tr>
<%
com.app.CMySelf mySelf = (com.app.CMySelf)session.getAttribute("mySelf"); //当前用户的部门id
dtId = Long.toString(mySelf.getDtId());

sqlStr = "select a.cw_status,a.cw_id,a.cp_id,a.cw_isovertime,a.cw_applyingname,a.cw_subject,to_char(a.cw_applytime,'yyyy-mm-dd hh24:mi:ss') cw_applytime,b.cp_timelimit ";
sqlStr += "from tb_connwork a,tb_connproc b,tb_deptinfo c ";
sqlStr += "where b.cp_id='o11100' and a.cw_status in(" +status+ ") and a.cp_id=b.cp_id and b.dt_id=c.dt_id";
 
if(!cp_name.equals(""))
{
	sqlStr += " and a.cw_subject like '%"+cp_name+"%' ";
}
if(!cw_applyPeople.equals(""))
{
	sqlStr += " and a.cw_applyingname like '%"+cw_applyPeople+"%'";
}
sqlStr += " and a.cp_id=b.cp_id and b.dt_id=c.dt_id " ;

//administrator管理员
if(!"11883".equals(dtId)){
	sqlStr += " and c.dt_id="+dtId+"";
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
		%>
				<tr width="100%" <%if (i%2==0) out.print("class='line-even'");else out.print("class='line-odd'");%>>
					<td><%=(i+1)%></td>
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
					<td align="center">
						<%
						status = content.get("cw_status").toString();
						switch(Integer.parseInt(status))
						{
							case 1:status = "待处理";break;
							case 2:status = "进行中";break;
							case 3:status = "已完成";break;
							case 8:status = "协调中";break;
						}
						out.print(status);
						%>
					</td>                     
					<td>
					<%=content.get("cw_subject").toString()%>
					</td>
					<td align="center"><%=content.get("cw_applyingname").toString()%></td >
					<td align="center"><%
					applyTime = content.get("cw_applytime").toString();
					out.print(applyTime);
				   %></td>
					<td align="center"><%=content.get("cp_timelimit").toString()%>天</td>
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

<script type="text/javascript">
function unload_word(){  
 var url=location.href; 
 formData.pages.value=document.getElementById("contents").innerHTML;
 //alert(formData.pages.value);
 formData.action='../unload_word.jsp';
 formData.submit();

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