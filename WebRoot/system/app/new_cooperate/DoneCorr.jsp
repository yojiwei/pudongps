<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%
CDataCn dCn = null;
CDataImpl dImpl = null;
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn);
//
CMySelf self = (CMySelf)session.getAttribute("mySelf");

String dt_id="";
dt_id = String.valueOf(self.getDtId());

String sqlDone="";
String wo_projectname="";
String de_sparehour="";
String overtitle="";
sqlDone = " select x.de_isovertime,x.de_sparehour,x.de_status,to_char(x.de_sendtime,'yyyy-mm-dd hh24:mi:ss') de_sendtime,to_char(x.de_signtime,'yyyy-mm-dd hh24:mi:ss') de_signtime,";
sqlDone += " to_char(x.de_feedbacktime,'yyyy-mm-dd hh24:mi:ss') de_feedbacktime,to_char(x.de_feedbacksigntime,'yyyy-mm-dd hh24:mi:ss') de_feedbacksigntime, ";
sqlDone += " x.de_id,x.de_senddeptid,y.co_id,y.co_status,z.wo_id,z.pr_id,z.wo_projectname,z.wo_applypeople,u.dt_name senddept,w.dt_name receivedept ";
sqlDone += " from tb_documentexchange x,tb_correspond y,tb_work z,tb_deptinfo u,tb_deptinfo w ";
sqlDone += " where x.de_type='1' and x.de_status='5' and (y.co_status='3' or y.co_status='4') and x.de_receiverdeptid="+dt_id+" ";
sqlDone += " and x.de_primaryid=y.co_id and y.wo_id=z.wo_id and x.de_senddeptid=u.dt_id ";
sqlDone += " and x.de_receiverdeptid=w.dt_id order by x.de_feedbacksigntime desc,x.de_feedbacktime desc,x.de_signtime desc,x.de_sendtime desc ";


%>
<%@include file="/system/app/skin/skin4/template/list_top.jsp"%>
<!--    模块名称开始    -->
已办协调单
<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/list_function.jsp"%>                                                            
<!--    功能按钮开始    -->
<img src="/system/images/goback.gif" border="0" onclick="javascript:history.back();" title="返回" style="cursor:hand" align="absmiddle">
返回    
<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/list_listtop.jsp"%>                                                                                        
<!--    列表开始    -->
<table class="FindAreaTable1" cellspacing="1" rules="cols" border="0" id="ctl00_DataGrid_DataGrid1" style="border-width:0px;">
      <form name="formData">
			<tr class="bttn">
			<td width="5%" class="outset-table" align="center"><div title="红色表示超时,绿色表示不超时,黄色表示即将超时">●</div></td>
      <td width="10%" class="outset-table" align="center">状态</td>
      <td width="15%" class="outset-table" align="center">项目名称</td>
      <td width="12%" class="outset-table" align="center">发送部门</td>
      <td width="13%" class="outset-table" align="center">接收部门</td>
			<td width="10%" class="outset-table" align="center">发送时间</td>
			<td width="10%" class="outset-table" align="center">签收时间</td>
			<td width="10%" class="outset-table" align="center">反馈时间</td>
			<td width="10%" class="outset-table" align="center" nowrap>反馈签收时间</td>
			<td width="10%" class="outset-table" align="center">查看</td>
			</tr>
		<%
		Vector vectorDone=dImpl.splitPage(sqlDone,request,20);
		if(vectorDone!=null)
		{
			for(int i=0;i<vectorDone.size();i++)
			{
				Hashtable contDone = (Hashtable)vectorDone.get(i);
				de_sparehour=contDone.get("de_sparehour").toString();
				if(i%2==0) out.println("<tr class=\"line-even\">");
				else out.print("<tr class=\"line-odd\">");
		%>
		 <td align="center">
		 <%
		if(contDone.get("de_isovertime").toString().equals("")||contDone.get("de_isovertime").toString().equals("0"))
				{
					overtitle="未超时,还剩"+de_sparehour+"小时";
			%>
			<div align="center" title=<%=overtitle%>><font color="green">●</font></div>
		<%
			}
			else 
			{
					overtitle="已超时"+de_sparehour.substring(1,de_sparehour.length())+"小时";
			%>
			<div align="center" title=<%=overtitle%>><font color="red">●</font></div>
			<%}%>	
		</td>
		 <td align="center">
		 <%
			if(contDone.get("co_status").toString().equals("3"))
				out.println("已通过");
		%>
		<%
			if(contDone.get("co_status").toString().equals("4"))
				out.println("未通过");
		%>

		 </td>
			<td align="center" onclick="openMonitorWindow('<%=contDone.get("wo_id")%>')" style="cursor:hand">
			<%
					wo_projectname=contDone.get("wo_projectname").toString();
					if(wo_projectname.length()>15)
				{
					wo_projectname=wo_projectname.substring(0,15);
					out.println(wo_projectname+"...");
				}
				else out.println(wo_projectname);
			%>
		</td>	     
		<td align="center"><%=contDone.get("receivedept").toString()%></td>
	     <td align="center"><%=contDone.get("senddept").toString()%></td>
		 <td align="center">
		<%=contDone.get("de_sendtime").toString()%>
		 </td>
         <td align="center">
		<%=contDone.get("de_signtime").toString()%>
		 </td>
		 <td align="center">
		<%=contDone.get("de_feedbacktime").toString()%>
		 </td>
		 <td align="center">
		 <%=contDone.get("de_feedbacksigntime").toString()%>
		</td>
		<td align="center">
		 <a href="/system/app/cooperate/CorrForm.jsp?OPType=See&wo_id=<%=contDone.get("wo_id")%>&co_id=<%=contDone.get("co_id")%>&de_id=<%=contDone.get("de_id")%>&de_senddeptid=<%=contDone.get("de_senddeptid")%>">查看</a>
		  </td>
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