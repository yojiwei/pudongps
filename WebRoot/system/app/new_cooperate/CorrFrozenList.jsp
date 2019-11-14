<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%
String selfdtid="";
String sender_id="";
String wo_projectname="";
String sqlFrozen = "";
String overtitle="";
String de_sparehour="";
CMySelf self = (CMySelf)session.getAttribute("mySelf");

selfdtid = String.valueOf(self.getDtId());
sender_id = String.valueOf(self.getMyID());
//
CDataCn dCn = null;
CDataImpl dImpl = null;
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn);
//
sqlFrozen = " select x.de_isovertime,x.de_id,x.de_status,x.de_sparehour,x.de_senddeptid,y.co_status,z.wo_id,z.pr_id,z.wo_projectname,u.dt_name senddept,v.dt_name receivedept,z.wo_applypeople, ";
sqlFrozen += " to_char(x.de_sendtime,'yyyy-mm-dd hh24:mi:ss') de_sendtime,to_char(x.de_signtime,'yyyy-mm-dd hh24:mi:ss') de_signtime,";
sqlFrozen += " to_char(x.de_feedbacktime,'yyyy-mm-dd hh24:mi:ss') de_feedbacktime,to_char(x.de_feedbacksigntime,'yyyy-mm-dd hh24:mi:ss') de_feedbacksigntime,w.cf_id,to_char(w.cf_endtime,'yyyy-mm-dd hh24:mi:ss') cf_endtime,y.co_id,to_char(w.cf_starttime,'yyyy-mm-dd hh24:mi:ss') cf_starttime ";
sqlFrozen += " from tb_documentexchange x,tb_correspond y,tb_work z,tb_deptinfo u,tb_deptinfo v,tb_correspondfrozen w ";
sqlFrozen += " where x.de_receiverdeptid="+selfdtid+" and x.de_status='2' and x.de_type='1' and x.de_primaryid=y.co_id ";
sqlFrozen += " and y.co_status='2' and y.wo_id=z.wo_id and x.de_senddeptid=u.dt_id and x.de_receiverdeptid=v.dt_id ";
sqlFrozen += " and y.co_id=w.co_id order by w.cf_starttime desc ";


%>
<%@include file="/system/app/skin/skin4/template/list_top.jsp"%>
<!--    模块名称开始    -->
待补件协调单
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
			<td width="2%" class="outset-table" align="center"><div title="红色表示超时,绿色表示不超时,黄色表示即将超时">●</div></td>
      <td width="8%" class="outset-table" align="center">状态</td>
      <td width="15%" class="outset-table" align="center">项目名称</td>
      <td width="12%" class="outset-table" align="center">发送部门</td>
      <td width="10%" class="outset-table" align="center">接收部门</td>
			<td width="8%" class="outset-table" align="center">发送人</td>
			<td width="10%" class="outset-table" align="center">发送时间</td>
			<td width="10%" class="outset-table" align="center">签收时间</td>
			<td width="10%" class="outset-table" align="center">冻结时间</td>
			<td width="10%" class="outset-table" align="center">解冻时间</td>
			<td width="5%" class="outset-table" align="center">操作</td>
			</tr>
		<%
		Vector vectorFrozen=dImpl.splitPage(sqlFrozen,request,20);
		if(vectorFrozen!=null)
		{
			for(int i=0;i<vectorFrozen.size();i++)
			{
				Hashtable contFrozen = (Hashtable)vectorFrozen.get(i);
				de_sparehour=contFrozen.get("de_sparehour").toString();
				if(i%2==0) out.println("<tr class=\"line-even\">");
				else out.print("<tr class=\"line-odd\">");
		%>
		 <td align="center">
		 <%
		if(contFrozen.get("de_isovertime").toString().equals("")||contFrozen.get("de_isovertime").toString().equals("0"))
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
		 <td align="center">待补件</td>
		<td align="center" onclick="openMonitorWindow('<%=contFrozen.get("wo_id").toString()%>')" style="cursor:hand">
			<%
					wo_projectname=contFrozen.get("wo_projectname").toString();
					if(wo_projectname.length()>15)
				{
					wo_projectname=wo_projectname.substring(0,15);
					out.println(wo_projectname+"...");
				}
				else out.println(wo_projectname);
			%>
		 </td>	    
		 <td align="center"><%=contFrozen.get("senddept").toString()%></td>
	   <td align="center"><%=contFrozen.get("receivedept").toString()%></td>
	   <td align="center"><%=contFrozen.get("wo_applypeople").toString()%></td>
		 <td align="center"><%=contFrozen.get("de_sendtime").toString()%></td>
     <td align="center"><%=contFrozen.get("de_signtime").toString()%></td>
		 <td align="center"><%=contFrozen.get("cf_starttime").toString()%></td>
		 <td align="center"><%=contFrozen.get("cf_endtime").toString()%></td>
		 <td align="center">
		 <a href="javascript:checkReason('<%=contFrozen.get("cf_id")%>')"><img src="/system/images/clip.gif" title="查看需补单原因" align="middle" border="0" width="15" height="15"></a>
		 <a href="javascript:checkUndoFrozen('<%=contFrozen.get("de_id").toString()%>','<%=contFrozen.get("co_id").toString()%>','<%=contFrozen.get("cf_id").toString()%>')"><img src="/system/images/unlock.gif" align="middle" border="0" width="15" height="15" title="补单已全"></a>
		  </td>
		</tr>
	</form>
		<%
			}
		}
       else
      {
          out.println("<tr><td colspan=12>没有记录！</td></tr>");
      }
  		%>
</table>
<script>
function checkReason(cf_id)
{
	var w=500;
	var h=300;
	var url="/system/app/cooperate/Frozen.jsp?OPType=See&cf_id="+cf_id;
	window.open(url,"需补件理由","top=300px,left=300px,width="+w+",height="+h+",toolbar=no,location=no,derectories=no,status=no,menubar=no,resizable=yes,scrollbars=no");
}
</script>
<script>
function checkUndoFrozen(de_id,co_id,cf_id)
{
	if(confirm("确定解冻该协调单?"))
	{
		UndoFrozen(de_id,co_id,cf_id);
	}
}

function UndoFrozen(de_id,co_id,cf_id)
{
	window.location.href="/system/app/cooperate/UndoFrozen.jsp?de_id="+de_id+"&co_id="+co_id+"&cf_id="+cf_id;
}
</script>
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