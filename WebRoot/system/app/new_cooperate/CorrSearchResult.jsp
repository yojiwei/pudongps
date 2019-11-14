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
String sqlSearCorr="";
String wo_projectname="";
String de_senddeptid="";
String de_receiverdeptid="";
String wo_applypeople="";
String de_status="";
String de_sparehour="";
String overtitle="";

wo_projectname=CTools.dealString(request.getParameter("wo_projectname")).trim();
de_senddeptid=CTools.dealString(request.getParameter("de_senddeptid")).trim();
wo_applypeople=CTools.dealString(request.getParameter("wo_applypeople")).trim();
de_status=CTools.dealString(request.getParameter("de_status")).trim();
de_receiverdeptid = CTools.dealString(request.getParameter("de_receiverdeptid")).trim();

sqlSearCorr =" select x.de_isovertime,x.de_sparehour,x.de_status,to_char(x.de_sendtime,'yyyy-mm-dd hh24:mi:ss') de_sendtime,to_char(x.de_signtime,'yyyy-mm-dd hh24:mi:ss') de_signtime,to_char(x.de_feedbacktime,'yyyy-mm-dd hh24:mi:ss') de_feedbacktime,to_char(x.de_feedbacksigntime,'yyyy-mm-dd hh24:mi:ss') de_feedbacksigntime, ";
sqlSearCorr += " x.de_id,x.de_senddeptid,y.co_id,z.wo_id,z.pr_id,z.wo_projectname,z.wo_applypeople,u.dt_name senddept,w.dt_name receivedept ";
sqlSearCorr += " from tb_documentexchange x,tb_correspond y,tb_work z,tb_deptinfo u,tb_deptinfo w ";
sqlSearCorr += " where x.de_type='1' and x.de_primaryid=y.co_id and y.wo_id=z.wo_id and x.de_senddeptid=u.dt_id ";
sqlSearCorr += " and x.de_receiverdeptid=w.dt_id  ";

if(!wo_projectname.equals(""))
{
	sqlSearCorr += " and z.wo_projectname like'%"+wo_projectname+"%' ";
}
if(de_receiverdeptid.equals("0")&&!de_senddeptid.equals("0"))
{   
	sqlSearCorr += " and x.de_senddeptid ="+de_senddeptid;
		
}
if(de_senddeptid.equals("0")&&!de_receiverdeptid.equals("0"))
{   
	sqlSearCorr += " and x.de_receiverdeptid ="+de_receiverdeptid;
		
}
if(de_senddeptid.equals("0")&&de_receiverdeptid.equals("0"))        
{   
	sqlSearCorr += " and (x.de_senddeptid ="+selfdtid+" or x.de_receiverdeptid="+selfdtid+") ";
		
}
if(!wo_applypeople.equals(""))
{
	sqlSearCorr += " and z.wo_applypeople like '%"+wo_applypeople+"%' ";
}
if(de_status.equals("0"))
{
	sqlSearCorr += " and (x.de_status=1 or x.de_status=2 or x.de_status=4 or x.de_status=5) ";
}
if(!de_status.equals("")&&!de_status.equals("0"))
{
	sqlSearCorr += " and x.de_status='"+de_status+"' ";
}
sqlSearCorr +=" order by x.de_feedbacksigntime desc,x.de_feedbacktime desc,x.de_signtime desc,x.de_sendtime desc ";

%>
<%@include file="/system/app/skin/skin4/template/list_top.jsp"%>
<!--    模块名称开始    -->
协调单查询结果
<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/list_function.jsp"%>                                                            
<!--    功能按钮开始    -->
<img src="/system/images/menu_about.gif" border="0" onclick="javascript:window.location.href='/system/app/cooperate/CorrSearch.jsp' " title="查找" style="cursor:hand" align="middle">
查找
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
			<td width="10%" class="outset-table" align="center">反馈签收时间</td>
			<td width="5%" class="outset-table" align="center">操作</td>
			</tr>
		<%
		Vector vectorSearCorr=dImpl.splitPage(sqlSearCorr,request,20);
		if(vectorSearCorr!=null)
		{
			for(int i=0;i<vectorSearCorr.size();i++)
			{
				Hashtable contSearCorr = (Hashtable)vectorSearCorr.get(i);
				de_sparehour=contSearCorr.get("de_sparehour").toString();
				if(i%2==0) out.println("<tr class=\"line-even\">");
				else out.print("<tr class=\"line-odd\">");
		%>
		 <td align="center">
		 <%
		if(contSearCorr.get("de_isovertime").toString().equals("")||contSearCorr.get("de_isovertime").toString().equals("0"))
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
			if(contSearCorr.get("de_status").toString().equals("1")) 
				{
				out.println("发送");
				}
			else if(contSearCorr.get("de_status").toString().equals("2")) 
				{
				out.println("发送签收");
				}
			else if(contSearCorr.get("de_status").toString().equals("4")) 
				{
				out.println("反馈发送");
				}
				else 
				{
					out.println("反馈签收");
				}
				%>
				</td>
				<td align="center" onclick="openMonitorWindow('<%=contSearCorr.get("wo_id")%>')" style="cursor:hand">
				 <%
					wo_projectname=contSearCorr.get("wo_projectname").toString();
					if(wo_projectname.length()>15)
				{
					wo_projectname=wo_projectname.substring(0,15);
					out.println(wo_projectname+"...");
				}
				else out.println(wo_projectname);
				%>
		</td>	    
		<td align="center"><%=contSearCorr.get("senddept").toString()%></td>
	     <td align="center"><%=contSearCorr.get("receivedept").toString()%></td>
		 <td align="center">
		<%=contSearCorr.get("de_sendtime").toString()%>
		 </td>
         <td align="center">
		<%=contSearCorr.get("de_signtime").toString()%>
		 </td>
		 <td align="center">
		<%=contSearCorr.get("de_feedbacktime").toString()%>
		 </td>
		 <td align="center">
		 <%=contSearCorr.get("de_feedbacksigntime").toString()%>
		</td>
		 <td align="center">
		 <a href="/system/app/cooperate/CorrForm.jsp?OPType=See&wo_id=<%=contSearCorr.get("wo_id")%>&co_id=<%=contSearCorr.get("co_id")%>&de_id=<%=contSearCorr.get("de_id")%>&
		  de_senddeptid=<%=contSearCorr.get("de_senddeptid")%>">查看</a>
		  </td>
		 </tr>
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