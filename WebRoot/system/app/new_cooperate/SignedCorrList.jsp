<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%
CDataCn dCn = null;
CDataImpl dImpl = null;
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn);
//
String optype="";
CMySelf self = (CMySelf)session.getAttribute("mySelf");

String dt_id="";
dt_id = String.valueOf(self.getDtId());
String sqlSigned="";
String wo_projectname="";
String overtitle="";
String strTitle="已签收协调单";
sqlSigned = " select x.de_isovertime,x.de_sparehour,s.ui_name,x.de_status,z.wo_projectname,z.pr_id,u.dt_name,z.wo_applypeople,y.co_id,y.wo_id,x.de_id,x.de_senddeptid, ";
sqlSigned += " to_char(x.de_sendtime,'yyyy-mm-dd hh24:mi:ss') de_sendtime,to_char(x.de_signtime,'yyyy-mm-dd hh24:mi:ss') de_signtime,";
sqlSigned += " to_char(x.de_feedbacktime,'yyyy-mm-dd hh24:mi:ss') de_feedbacktime,to_char(x.de_feedbacksigntime,'yyyy-mm-dd hh24:mi:ss') de_feedbacksigntime";
sqlSigned +=" from tb_documentexchange x,tb_correspond y,tb_work z,tb_deptinfo u,tb_userinfo s ";
sqlSigned += " where x.de_status in('2','4') and x.de_receiverdeptid="+dt_id+" and y.co_status='1' ";
sqlSigned += " and x.de_type='1' and x.de_primaryid=y.co_id and y.wo_id=z.wo_id and x.de_senddeptid=u.dt_id and x.de_senderid=s.ui_id";
sqlSigned += " order by x.de_feedbacksigntime desc,x.de_feedbacktime desc,x.de_signtime desc,x.de_sendtime desc ";

String de_sparehour="";
%>
<%@include file="/system/app/skin/skin4/template/list_top.jsp"%>
<!--    模块名称开始    -->
<%=strTitle%>
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
      <td width="10%" class="outset-table" align="center">发送部门</td>
      <td width="10%" class="outset-table" align="center">发送人</td>
			<td width="10%" class="outset-table" align="center">发送时间</td>
			<td width="10%" class="outset-table" align="center">签收时间</td>
			<td width="10%" class="outset-table" align="center">反馈时间</td>
			<td width="10%" class="outset-table" align="center" nowrap>反馈签收时间</td>
			<td width="5%" class="outset-table" align="center">操作</td>
			</tr>
		<%
		Vector vectorSigned=dImpl.splitPage(sqlSigned,request,20);
		if(vectorSigned!=null)
		{
			for(int i=0;i<vectorSigned.size();i++)
			{
				Hashtable contSigned = (Hashtable)vectorSigned.get(i);
				de_sparehour=contSigned.get("de_sparehour").toString();
				if(i%2==0) out.println("<tr class=\"line-even\">");
				else out.print("<tr class=\"line-odd\">");
		%>
		 <td align="center">
		 <%
		if(contSigned.get("de_isovertime").toString().equals("")||contSigned.get("de_isovertime").toString().equals("0"))
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
				if(contSigned.get("de_status").toString().equals("2")) 
				{
				out.println("发送签收"); 
				optype="dealwith";
				}
				else if(contSigned.get("de_status").toString().equals("5"))
				{
					out.println("反馈签收");
					optype="finish";
				}
				else 
				{
					out.println("需补件已全");
					optype="Recorr";
				}
				%>
		 </td>
    	 <td align="center" onclick="openMonitorWindow('<%=contSigned.get("wo_id").toString()%>')" style="cursor:hand">
		 <%
					wo_projectname=contSigned.get("wo_projectname").toString();
					if(wo_projectname.length()>15)
				{
					wo_projectname=wo_projectname.substring(0,15);
					out.println(wo_projectname+"...");
				}
				else out.println(wo_projectname);
		%>
		 </td>
	     <td align="center"><%=contSigned.get("dt_name").toString()%></td>
	     <td align="center"><%=contSigned.get("ui_name").toString()%></td>
		 <td align="center">
		<%=contSigned.get("de_sendtime").toString()%>
		 </td>
         <td align="center">
		<%=contSigned.get("de_signtime").toString()%>
		 </td>
		 <td align="center">
		<%=contSigned.get("de_feedbacktime").toString()%>
		 </td>
		 <td align="center">
		 <%=contSigned.get("de_feedbacksigntime").toString()%>
		</td>
		 <td align="center">
		 <a href="/system/app/cooperate/CorrForm.jsp?OPType=<%=optype%>&co_id=<%=contSigned.get("co_id")%>">处理</a>
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
    </td>
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