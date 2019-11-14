<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%
String sqlWait="";
String wo_id = "";
String co_id="";
String co_status="";
String dt_id="";
String dt_name = "";
String wo_projectname="";
sqlWait= "select a.wo_id, a.wo_projectname,a.wo_applypeople,to_char(a.wo_applytime,'yyyy-mm-dd hh24:mi:ss') wo_applytime,to_char(b.de_sendtime,'yyyy-mm-dd hh24:mi:ss') de_sendtime,d.dt_id,d.dt_name,c.co_status,c.co_id from tb_work a,tb_documentexchange b,tb_correspond c,tb_deptinfo d where (b.de_status='1' or b.de_status='2') and c.co_status='1' and b.de_type='1' and b.de_primaryid=c.co_id and a.wo_id =c.wo_id  and b.de_receiverdeptid=d.dt_id  order by b.de_sendtime desc";

CDataCn dCn = null;
CDataImpl dImpl = null;
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn);
%>
<%@include file="/system/app/skin/skin4/template/list_top.jsp"%>
<!--    模块名称开始    -->
在办协调单列表
<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/list_function.jsp"%>                                                            
<!--    功能按钮开始    -->
  
<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/list_listtop.jsp"%>                                                                                        
<!--    列表开始    -->
<table class="FindAreaTable1" cellspacing="1" rules="cols" border="0" id="ctl00_DataGrid_DataGrid1" style="border-width:0px;">
 <tr class="bttn">
    <td width="6%" class="outset-table" align="center">序号</td>
    <td width="10%" class="outset-table" align="center">协办事项</td>
    <td width="10%" class="outset-table" align="center">协办单位</td>
    <td width="10%" class="outset-table" align="center">申请人 </td>
    <td width="10%" class="outset-table" align="center">项目申请时间 </td>
    <td width="10%" class="outset-table" align="center">协调单发送时间</td>
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
        co_id = content.get("co_id").toString();
        dt_id=content.get("dt_id").toString();
        dt_name=content.get("dt_name").toString();
        wo_projectname=content.get("wo_projectname").toString();
			  if(i % 2 == 0)  out.print("<tr class=\"line-even\">");
				else out.print("<tr class=\"line-odd\">");
  %>
	<td align="center"><%=i+1%></td>
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
	<td align="center"><%=content.get("dt_name")%></td>
	<td align="center"><%=content.get("wo_applypeople")%></td>
	<td align="center"><%=content.get("wo_applytime")%></td>
	<td align="center"><%=content.get("de_sendtime")%></td>
	<td align="center"><a href="#" onclick="javascript:window.open('UrgentInfo.jsp?wo_id=<%=wo_id%>&dt_name=<%=dt_name%>&dt_id=<%=dt_id%>&co_id=<%=co_id%>','催办单','Top=0px,Left=0px,Width=470px, Height=225px,toolbar=no,location=no,derectories=no,status=no,menubar=no,scrollbars=yes');">催办</a></td>
	<td align="center"><a href="#" onclick="javascript:window.open('SupervisalInfo.jsp?wo_id=<%=wo_id%>&dt_name=<%=dt_name%>&dt_id=<%=dt_id%>&co_id=<%=co_id%>','督办单','Top=0px,Left=0px,Width=470px, Height=290px,toolbar=no,location=no,derectories=no,status=no,menubar=no,scrollbars=yes');">督办</a></td>

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
<%
        }
  }
  else
  {
    out.println("<tr><td colspan=10>没有记录！</td></tr>");
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