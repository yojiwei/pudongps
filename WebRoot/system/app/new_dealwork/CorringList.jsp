<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%
CMySelf self = (CMySelf)session.getAttribute("mySelf");

String selfdtid = String.valueOf(self.getDtId());
String sender_id = String.valueOf(self.getMyID());

//
CDataCn dCn = null;
CDataImpl dImpl = null;
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn);
//
String sqlCorring="";
String status="";
String overtitle="";
String wo_projectname="";
String wo_sparehour="";
String dt_name = "";

sqlCorring="select  x.wo_projectname,x.wo_sparehour,x.wo_isovertime,x.wo_status, x.wo_applypeople, to_char(x.wo_applytime,'yyyy-mm-dd hh24:mi:ss') wo_applytime, x.wo_id, x.pr_id,y.pr_timelimit,z.dt_name from tb_work x,tb_proceeding_new y,tb_deptinfo z where x.wo_status='8' and x.pr_id=y.pr_id ";
if(!"11883".equals(selfdtid)){
	sqlCorring += "and y.dt_id="+selfdtid+" ";
}
sqlCorring += "and y.dt_id=z.dt_id order by x.wo_applytime desc";

%>
<%@include file="/system/app/skin/skin4/template/list_top.jsp"%>
<!--    模块名称开始    -->
协调中业务列表
<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/list_function.jsp"%>                                                            
<!--    功能按钮开始    -->
<img src="/system/images/menu_about.gif" border="0" onclick="javascript:window.location.href='WorkQuery.jsp' " title="查找" style="cursor:hand" align="absmiddle">
查找
<img src="/system/images/goback.gif" border="0" onclick="javascript:history.back();" title="返回" style="cursor:hand" align="absmiddle">
返回
<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/list_listtop.jsp"%>                                                                                        
<!--    列表开始    -->
<table class="FindAreaTable1" cellspacing="1" rules="cols" border="0" id="ctl00_DataGrid_DataGrid1" style="border-width:0px;">
		 <tr class="bttn">
			<td width="5%" align="center" class="outset-table" ><div title="红色表示超时，绿色表示未超时，黄色表示即将超时">●</div></td>
			<td width="8%" align="center" class="outset-table" >状态</td>
			<td width="30%" class="outset-table" align="center">项目名称</td>
			<td width="10%" class="outset-table" align="center">申请人</td>
			<td width="20%" class="outset-table" align="center">申请时间</td>
			<td width="10%" align="center" class="outset-table" >项目时限</td>
			<%
			//如果是超级管理员administrator显示全部
			if(!"11883".equals(selfdtid)){
			%>
			<td width="10%" class="outset-table" align="center">操作</td>
			<%
			}else{
			%>
			<td width="10%" class="outset-table" align="center">部门</td>
			<%}%>
      </tr>
		<%
		Vector vectorPage = dImpl.splitPage(sqlCorring,request,20);
		if(vectorPage!=null)
		{
			for(int i=0;i<vectorPage.size();i++)
			{
				Hashtable content = (Hashtable)vectorPage.get(i);
				wo_sparehour=content.get("wo_sparehour").toString();
				dt_name = CTools.dealNull(content.get("dt_name"));
			    if(i % 2 == 0)  out.print("<tr class=\"line-even\">");
				else out.print("<tr class=\"line-odd\">");
		%>
				<td align="center" nowrap>
				<%
			    if(content.get("wo_isovertime").toString().equals("0")||content.get("wo_isovertime").toString().equals(""))
				{
					overtitle="未超时,还剩"+wo_sparehour+"小时";
				%>	
				<div align="center" title=<%=overtitle%>><font color="green">●</font></div>
				<%
					}
					else if(content.get("wo_isovertime").toString().equals("1"))
				{ 
						overtitle="已超时"+wo_sparehour.substring(1,wo_sparehour.length())+"小时";
				%>
					<div align="center" title=<%=overtitle%>><font color="red">●</font></div>
				<%
				}
			    %>
				</td>
				<td align="center" nowrap>
				<%
					switch(Integer.parseInt(content.get("wo_status").toString()))
				{
							case 1:status = "进行中";break;
							case 2:status = "待补件";break;
							case 3:status = "已通过";break;
							case 4:status = "未通过";break;
							case 8:status = "协调中";break;				
				}
				  out.println(status);
				%>
				</td>
        <td align="center" onclick="openMonitorWindow('<%=content.get("wo_id").toString()%>')" style="cursor:hand">
				<%
					wo_projectname=content.get("wo_projectname").toString();
					if(wo_projectname.length()>15)
					{
						wo_projectname=wo_projectname.substring(0,15);
						out.println(wo_projectname+"...");
					}
					else out.println(wo_projectname);
		%>
		</td>
                <td align="center"><%=content.get("wo_applypeople").toString()%></td>
                <td align="center"><%=content.get("wo_applytime").toString()%></td>
                <td align="center"><%=content.get("pr_timelimit").toString()%>天</td>
               <%
	    //如果是超级管理员administrator显示全部
			if(!"11883".equals(selfdtid)){
	    %>
	    <td align="center">
			<a href="../cooperate/CorrForm.jsp?OPType=Corragain&wo_id=<%=content.get("wo_id")%>&pr_id=<%=content.get("pr_id")%>">
			<img src="/system/images/clip.gif" title="再次协同" width="15" height="15" border="0"></a>
			<img src="/system/images/hammer.gif" title="撤销协调单" width="20" height="20" border="0" style="cursor:hand" onclick="openRemovewindow('<%=content.get("wo_id")%>')">
			</td>
			<%}else{%>
			<td align="center">
				<%=dt_name%>
			</td>
			<%}%>
            </tr>
</form>
<%
    }
  }
  else
  {
    out.println("<tr><td colspan=10>没有记录！</td></tr>");
  }
%>
</table>
<script>
function openRemovewindow(wo_id)
{
	var w=500;
	var h=300;
	var url="RemoveCorr.jsp?wo_id="+wo_id;
	window.open(url,"撤销协调单","top=300px,left=300px,width="+w+",height="+h+",toolbar=no,location=no,derectories=no,status=no,menubar=no,resizable=yes,scrollbars=no");
}
</script>
<script>
function openMonitorWindow(wo_id)
{
	var w=750;
	var h=500;
	var url="WorkMonitor.jsp?wo_id="+wo_id;
	window.open(url,"项目监控","top=100px,left=100px,width="+w+",height="+h+",toolbar=no,location=no,derectories=no,status=no,menubar=no,resizable=yes,scrollbars=yes");
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