<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%
String OPType = "";
String strTitle = "已完成列表";
String dtId = "";
String sqlStr = "";
String pr_name = "";                          //项目名称
String wo_applyPeople = "";  //申请人
String wo_projectname="";
String pr_applyTime = "";                     //项目申请时间
String pr_timeLimit = "";		      //项目时限
String isOverTime = "";                       //项目是否已经超时
String color = "",overTitle="";               //项目超时的时候，设置标志的颜色和title
String applyTime = "";
String status = "";

//update20080122
CDataCn dCn = null;
CDataImpl dImpl = null;
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn);
%>
<script language="javascript">
function openMonitorWindow(wo_id)
{
	var w=850;
	var h=500;
	var url="WorkMonitor.jsp?wo_id="+wo_id;
	window.open(url,"项目监控","top=100px,left=100px,width="+w+",height="+h+",toolbar=no,location=no,derectories=no,status=yes,menubar=no,resizable=yes,scrollbars=yes");
}
</script>
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
					<td align="center" class="outset-table" >状态</td>
					<td align="center" class="outset-table" >项目名称</td>
					<td align="center" class="outset-table" >提交人</td>
					<td align="center" class="outset-table" >提交日期</td>
					<td align="center" class="outset-table" >项目时限</td>
				</tr>
				<%
        com.app.CMySelf mySelf = (com.app.CMySelf)session.getAttribute("mySelf");
        
				if (mySelf!=null)
				{
					dtId = Long.toString(mySelf.getDtId());
				}
				else
				{
					response.sendRedirect("/system/app/index.jsp");
					out.close();
				}
				sqlStr = "select a.wo_status,a.wo_id,a.pr_id,a.wo_isovertime,a.wo_applypeople,a.wo_projectname,to_char(a.wo_applytime,'yyyy-mm-dd hh24:mi:ss') wo_applytime,b.pr_timelimit from tb_work a,tb_proceeding_new b ";
				sqlStr += "where a.wo_status in('3','4') and a.pr_id=b.pr_id and b.dt_id="+dtId+" order by wo_applytime desc";
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
					isOverTime = content.get("wo_isovertime").toString();
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
					<td align="center"><%=content.get("wo_applypeople").toString()%></td>
					<td align="center"><%
										applyTime = content.get("wo_applytime").toString();
										out.print(applyTime);
									   %></td>
					<td align="center"><%=content.get("pr_timelimit").toString()%>天</td>
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