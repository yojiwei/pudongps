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
String selfid="";
String wo_projectname="";
String overtitle="";

dt_id = String.valueOf(self.getDtId());
selfid = String.valueOf(self.getMyID());

String sqlDoing="";

sqlDoing = " select x.de_isovertime,x.de_sparehour,x.de_status,to_char(x.de_sendtime,'yyyy-mm-dd hh24:mi:ss') de_sendtime,to_char(x.de_signtime,'yyyy-mm-dd hh24:mi:ss') de_signtime,";
sqlDoing += "  to_char(x.de_feedbacktime,'yyyy-mm-dd hh24:mi:ss') de_feedbacktime,to_char(x.de_feedbacksigntime,'yyyy-mm-dd hh24:mi:ss') de_feedbacksigntime, ";
sqlDoing += " x.de_id,x.de_senddeptid,y.co_id,z.wo_projectname,z.wo_id,z.pr_id,z.wo_applypeople,u.dt_name senddept,w.dt_name receivedept ";
sqlDoing += " from tb_documentexchange x,tb_correspond y,tb_work z,tb_deptinfo u,tb_deptinfo w ";
sqlDoing += " where x.de_type='1' and (x.de_status='1'or x.de_status='2') and x.de_senddeptid="+dt_id+" ";
sqlDoing += " and x.de_primaryid=y.co_id and y.wo_id=z.wo_id and x.de_senddeptid=u.dt_id and (y.co_status='1' or y.co_status='2') ";
sqlDoing += " and x.de_receiverdeptid=w.dt_id order by x.de_feedbacksigntime desc,x.de_feedbacktime desc,x.de_signtime desc,x.de_sendtime desc ";

String de_sparehour="";
%>
<%@include file="/system/app/skin/skin4/template/list_top.jsp"%>
<!--    模块名称开始    -->
在办协调单
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
      <td width="20%" class="outset-table" align="center">项目名称</td>
      <td width="12%" class="outset-table" align="center">发送部门</td>
      <td width="13%" class="outset-table" align="center">接收部门</td>
			<td width="10%" class="outset-table" align="center">发送时间</td>
			<td width="10%" class="outset-table" align="center">签收时间</td>
			<td width="10%" class="outset-table" align="center">反馈时间</td>
			<td width="10%" class="outset-table" align="center" nowrap>反馈签收时间</td>
			<td width="5%" class="outset-table" align="center">操作</td>
			</tr>
		<%
		Vector vectorDoing=dImpl.splitPage(sqlDoing,request,20);
		if(vectorDoing!=null)
		{
			for(int i=0;i<vectorDoing.size();i++)
			{
				Hashtable contDoing = (Hashtable)vectorDoing.get(i);
				de_sparehour=contDoing.get("de_sparehour").toString();
				if(i%2==0) out.println("<tr class=\"line-even\">");
				else out.print("<tr class=\"line-odd\">");

		%>
		 <td align="center">
		 <%
		if(contDoing.get("de_isovertime").toString().equals("")||contDoing.get("de_isovertime").toString().equals("0"))
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
		 <td align="center"><%if(contDoing.get("de_status").toString().equals("1")) out.println("发送");
								else out.println("发送签收");%></td>
    	 <td align="center" onclick="openMonitorWindow('<%=contDoing.get("wo_id")%>')" style="cursor:hand">
		 <%
					wo_projectname=contDoing.get("wo_projectname").toString();
					if(wo_projectname.length()>15)
				{
					wo_projectname=wo_projectname.substring(0,15);
					out.println(wo_projectname+"...");
				}
				else out.println(wo_projectname);
		%>
		</td>
	     <td align="center"><%=contDoing.get("senddept").toString()%></td>
	     <td align="center"><%=contDoing.get("receivedept").toString()%></td>
		 <td align="center">
		<%=contDoing.get("de_sendtime").toString()%>
		 </td>
         <td align="center">
		<%=contDoing.get("de_signtime").toString()%>
		 </td>
		 <td align="center">
		<%=contDoing.get("de_feedbacktime").toString()%>
		 </td>
		 <td align="center">
		 <%=contDoing.get("de_feedbacksigntime").toString()%>
		</td>
		 <td align="center">
		 <a href="/system/app/cooperate/CorrForm.jsp?OPType=See&wo_id=<%=contDoing.get("wo_id")%>&co_id=<%=contDoing.get("co_id")%>&de_id=<%=contDoing.get("de_id")%>&de_senddeptid=<%=contDoing.get("de_senddeptid")%>">查看</a>
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