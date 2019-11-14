<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%
CDataCn dCn = null;
CDataImpl dImpl = null;
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn);
//
String sqlWait="";
String status = "";
String wo_id = "";
String wo_projectname="";
String dt_id="";
String dt_name="";
String beginTime="";
String endTime="";
String spareHour = "";
String isOverTime = "";
String color = "";
String work = "";
String code = "";

status = CTools.dealString(request.getParameter("status1")).trim();
beginTime = CTools.dealString(request.getParameter("beginTime")).trim();
endTime = CTools.dealString(request.getParameter("endTime")).trim();
String work_Department=CTools.dealString(request.getParameter("work_Department")).trim();
String applet_people=CTools.dealString(request.getParameter("applet_people")).trim();//事项申请人
dt_name=CTools.dealString(request.getParameter("dt_name")).trim();
work = CTools.dealString(request.getParameter("work")).trim();			//项目名称
code = CTools.dealString(request.getParameter("code")).trim();			//办理人

sqlWait = "select a.wo_id,a.wo_projectname,a.wo_isovertime,a.wo_sparehour,a.wo_applypeople,to_char(a.wo_applytime,'yyyy-mm-dd hh24:mi:ss') wo_applytime ,a.wo_status,b.pr_name,c.dt_id,c.dt_name from tb_work a,tb_proceeding_new b,tb_deptinfo c where 1=1 ";
//办理部门
if (!dt_name.equals("1"))
{
	sqlWait += "and c.dt_id = "+dt_name; 
}
//项目名称 
if (!"".equals(work)) {
	sqlWait += "and a.wo_projectname like '"+ work +"'"; 
}
//事项申请人
if(!"".equals(applet_people))
	sqlWait += " and a.wo_applypeople like '%"+applet_people+"%'";

if(work == null || work.equals(""))
	work="%";
	sqlWait += " and a.wo_status in(" +status+ ")  and  a.pr_id=b.pr_id and b.dt_id=c.dt_id  ";

//办理人
if(!"".equals(code)){
	sqlWait += " and a.wo_applypeople like '%"+code+"%'";
}
if (!beginTime.equals(""))
{
 	sqlWait += " and a.wo_applytime > to_date('" + beginTime + " 00:00:00','yyyy-mm-dd hh24:mi:ss') ";
}
if (!endTime.equals(""))
{
	sqlWait += " and a.wo_applytime < to_date('" + endTime + " 23:59:59','yyyy-mm-dd hh24:mi:ss')";
}

sqlWait += " order by a.wo_applytime desc";

//out.println(sqlWait);
%>
<%@include file="/system/app/skin/skin4/template/list_top.jsp"%>
<!--    模块名称开始    -->
项目查询结果
<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/list_function.jsp"%>                                                            
<!--    功能按钮开始    -->
项目查询结果
<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/list_listtop.jsp"%>                                                                                        
<!--    列表开始    -->
<table class="FindAreaTable1" cellspacing="1" rules="cols" border="0" id="ctl00_DataGrid_DataGrid1" style="border-width:0px;">
		<tr class="bttn">
            <td width="2%" class="outset-table" align="center">&nbsp;</td>
         <td width="5%" class="outset-table" align="center">状态</td>
            <td width="10%" class="outset-table" align="center">申请人</td>
            <td width="25%" class="outset-table" align="center">项目名称</td>

            <td width="10%" class="outset-table" align="center">主办单位 </td>
            <td width="15%" class="outset-table" align="center">申请时间</td>
            <td width="5%" class="outset-table" align="center">催办</td>
            <td width="5%" class="outset-table" align="center">督办</td>
         </tr>
<%
		Vector vectorPage = dImpl.splitPage(sqlWait,request,20);
		if(vectorPage!=null)
		{
			for(int i=0;i<vectorPage.size();i++)
			{
				Hashtable content = (Hashtable)vectorPage.get(i);
				wo_id = content.get("wo_id").toString();
        wo_projectname= content.get("wo_projectname").toString();
        dt_id=content.get("dt_id").toString();
        dt_name=content.get("dt_name").toString();
        isOverTime = content.get("wo_isovertime").toString();
        spareHour = content.get("wo_sparehour").toString();
			  if(i % 2 == 0)  out.print("<tr class=\"line-even\">");
				else out.print("<tr class=\"line-odd\">");
%>
        <td align="center"><span title="<%if(isOverTime.equals("1")) {color="red";out.print("已超时"+(-Integer.parseInt(spareHour))+"小时");}else {color="green";out.print("未超时,还剩"+spareHour+"小时");}%>"><font color="<%=color%>">●</font></span></td>
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
       <td align="center"><%=content.get("wo_applypeople")%></td>
			 <td nowrap align="left" title="<%=wo_projectname%>" onclick="openMonitorWindow('<%=content.get("wo_id").toString()%>')" style="cursor:hand">
       <%
					if(wo_projectname.length()>15)
					{
						wo_projectname=wo_projectname.substring(0,15);
						out.println(wo_projectname+"...");
					}
					else out.println(wo_projectname);
			 %>
			</td>
      <td align="center"><%=content.get("dt_name")%></td>
      <td align="center"><%=content.get("wo_applytime")%></td>
 			<td align="center"><a href="#" onclick="javascript:window.open('UrgentInfo.jsp?wo_id=<%=wo_id%>&dt_name=<%=dt_name%>&dt_id=<%=dt_id%>','催办单','Top=0px,Left=0px,Width=470px, Height=325px,toolbar=no,location=no,derectories=no,status=no,menubar=no,scrollbars=yes');">催办</a></td>
			<td align="center"><a href="#" onclick="javascript:window.open('SupervisalInfo.jsp?wo_id=<%=wo_id%>&dt_name=<%=dt_name%>&dt_id=<%=dt_id%>','督办单','Top=0px,Left=0px,Width=470px, Height=390px,toolbar=no,location=no,derectories=no,status=no,menubar=no,scrollbars=yes');">督办</a></td>
</form>
<%
    }
  }
  else
  {
    out.println("<tr><td colspan=20>没有记录！</td></tr>");
  }
%>
</table>
<script>
function openMonitorWindow(wo_id)
{
	var w=500;
	var h=300;
	var url="/system/app/dealwork/RemoveCorr.jsp?wo_id="+wo_id;
	window.open(url,"撤销协调单","top=300px,left=300px,width="+w+",height="+h+",toolbar=no,location=no,derectories=no,status=no,menubar=no,resizable=yes,scrollbars=no");
}

function openMonitorWindow(wo_id)
{
	var w=850;
	var h=500;
	var url="/system/app/dealwork/WorkMonitor.jsp?wo_id="+wo_id;
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