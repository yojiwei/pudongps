<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%
String OPType = "";
String strTitle = "查询列表";
String dtId = "";
String dt_id = "";
String sqlStr = "";
String cp_name = "";                          //项目名称
String cw_applyPeople = "";                   //申请人                   
String cp_timeLimit = "";		      						//项目时限
String cp_tasks = "项目办理";
String color = "",overTitle="";               //项目超时的时候，设置标志的颜色和title
String status = "'1'";
String beginTime = "";
String endTime = "";
String cw_isovertime ="";
String cw_isovertimem ="";
String cw_ispublish ="";
String cw_processing = "";


beginTime = CTools.dealString(request.getParameter("beginTime")).trim();
endTime = CTools.dealString(request.getParameter("endTime")).trim();
dt_id = CTools.dealString(request.getParameter("dt_id")).trim();
cw_isovertime = CTools.dealString(request.getParameter("isovertime")).trim();
cw_ispublish = CTools.dealString(request.getParameter("ispublish")).trim();
status = CTools.dealString(request.getParameter("status1")).trim();
cw_processing = CTools.dealString(request.getParameter("processing")).trim();


//
CDataCn dCn = null;
CDataImpl dImpl = null;
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn);
%>
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
	<td align="center" class="outset-table" width="10%" >发信人</td>
	<td align="center" class="outset-table" width="32%" >主题</td>					
	<td align="center" class="outset-table" width="16%" >发送时间</td>
	<td align="center" class="outset-table" width="16%" >办理完成时间</td>
	<td align="center" class="outset-table" width="8%" >受理超时</td>
	<td align="center" class="outset-table" width="8%" >办理超时</td>
	<td align="center" class="outset-table" width="10%" >操作</td>
</tr>
<%
sqlStr = "select a.cw_status,a.cw_id,a.cp_id,a.cw_isovertime,a.cw_isovertimem,a.cw_applyingname,to_char(a.cw_applytime,'yyyy-mm-dd hh24:mi:ss') cw_applytime,to_char(a.cw_finishtime,'yyyy-mm-dd hh24:mi:ss') cw_finishtime,a.cw_subject,b.cp_timelimit,b.cp_timelimiting ";
sqlStr += "from tb_connwork a,tb_connproc b,tb_deptinfo c ";
sqlStr += "where a.cp_id=b.cp_id and b.dt_id=c.dt_id";
if (!"".equals(dt_id)) 
	sqlStr += " and c.dt_id = " + dt_id;

if (!beginTime.equals(""))
{
 	sqlStr += " and a.cw_applytime > to_date('" + beginTime + " 00:00:00','yyyy-mm-dd hh24:mi:ss') ";
}
if (!endTime.equals(""))
{
	sqlStr += " and a.cw_applytime < to_date('" + endTime + " 23:59:59','yyyy-mm-dd hh24:mi:ss')";
}
if(cw_isovertime.equals("1")) sqlStr += " and cw_isovertime='1' and cw_status <> 9";
if(cw_isovertime.equals("2")) sqlStr += " and cw_isovertimem='1' and cw_status <> 9";
if(cw_ispublish.equals("1")) sqlStr += " and cw_ispublish='1' and cw_status <> 9";
if(cw_ispublish.equals("0")) sqlStr += " and cw_ispublish<>'1' and cw_status <> 9";
if(cw_processing.equals("0")) sqlStr += " and cw_status not in(3,9,12)";//未处理过
if(cw_processing.equals("1")) sqlStr += " and cw_status=3";//已处理

sqlStr += " order by cw_applytime desc";
Vector vPage = dImpl.splitPage(sqlStr,request,20);
if (vPage!=null)
{
	for (int i=0;i<vPage.size();i++)
	{
		Hashtable content = (Hashtable)vPage.get(i);
		cw_isovertime = content.get("cw_isovertime").toString();
		cw_isovertimem = content.get("cw_isovertimem").toString();
		%>
				<tr width="100%" <%if (i%2==0) out.print("class='line-even'");else out.print("class='line-odd'");%>>
					<td align="center"><%=content.get("cw_applyingname").toString()%></td>
					<td><%=content.get("cw_subject").toString()%></td>					
					<td align="center"><%=content.get("cw_applytime").toString()%></td>
					<td><%=content.get("cw_finishtime").toString()%></td>					
					<td align="center"><%=cw_isovertime.equals("1")?"<font style='color:red'>是</font>":"否"%></td>
					<td align="center"><%=cw_isovertimem.equals("1")?"<font style='color:red'>是</font>":"否"%></td>
					<td align="center">	
	        <span style="cursor:hand" onclick="javascript:window.location='mailtationInfo.jsp?cw_id=<%=content.get("cw_id").toString()%>&cw_status=<%=content.get("cw_status").toString()%>'">查 看</span>	                 
					</td>
				</tr>
		<%
	}
}
else
{
	out.print("<tr class='line-even'><td colspan='19'>没有匹配记录</td></tr>");
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