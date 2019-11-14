<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<jsp:directive.page import="com.util.TimeCalendar"/>
<%
CDataCn dCn = null;
CDataImpl dImpl = null;
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn);
//
String strTitle ="";
String beginTime = "";
String endTime = "";
String cp_name = "";
String dt_id = "";
String sqlStr = "";//选事项
String sqlStr_dt = "";//选部门
String sqlStr_cw1 = "";//选在办总数
String sqlStr_cw2 = "";//选在办超时
String sqlStr_cw3 = "";//选已办总数
String sqlStr_cw4 = "";//选已办超时
String sqlStr_cw5 = "";
Hashtable content_cw = null;//选事项
Hashtable content_cw1 = null;//选在办总数
Hashtable content_cw2 = null;//选在办超时
Hashtable content_cw3 = null;//选已办总数
Hashtable content_cw4 = null;//选已办超时
Hashtable content_cw5 = null;
String cp = CTools.dealString(request.getParameter("cp"));
TimeCalendar tc = new TimeCalendar();
String cp_id = "";
String cp_upid = "";
String dtId = CTools.dealString(request.getParameter("dt_id"));
String sqlWhere = dtId.equals("0")?"":" and a.dt_id='" + dtId + "'";
int count1 = 0;
int count2 = 0;
int count3 = 0;
int count4 = 0;
int count5 = 0;
int count6 = 0;

beginTime = CTools.dealString(request.getParameter("beginTime")).trim();
endTime = CTools.dealString(request.getParameter("endTime")).trim();
 int j = 0;//区分互动事项类型
j = Integer.parseInt(cp);
switch(j)
{
	  case 1:
           sqlStr_dt = "select a.dt_name,b.dt_id,b.cp_name,b.cp_upid from tb_deptinfo a ,tb_connproc b where a.dt_id=b.dt_id and b.cp_id in('o1','o5','o2','o3') " + sqlWhere + " order by dt_name desc";
		 				strTitle="";
           break;
      case 2:
           sqlStr_dt = "select a.dt_name,b.dt_id,b.cp_name,b.cp_upid from tb_deptinfo a ,tb_connproc b where a.dt_id=b.dt_id and b.cp_upid='o6' " + sqlWhere + " order by dt_name desc";
		 				strTitle="";
           break;
      case 3:
           sqlStr_dt = "select a.dt_name,b.dt_id,b.cp_name,b.cp_upid from tb_deptinfo a ,tb_connproc b where a.dt_id=b.dt_id and (b.cp_id in('o4','o8','o9')) " + sqlWhere + " order by dt_name desc"; 
		 			 strTitle="投诉信箱汇总统计表";
           break;
      case 4:
           sqlStr_dt = "select a.dt_name,b.dt_id,b.cp_name,b.cp_upid from tb_deptinfo a ,tb_connproc b where a.dt_id=b.dt_id and b.cp_upid='o7' " + sqlWhere + " order by dt_sequence";   
					 strTitle="咨询信箱汇总统计表";
					 break;
	  case 5:
           sqlStr_dt = "select a.dt_name,b.dt_id,b.cp_name,b.cp_upid from tb_deptinfo a ,tb_connproc b where a.dt_id=b.dt_id and b.cp_upid='o10000' " + sqlWhere + " order by dt_sequence";  
		 strTitle="街道领导信箱汇总统计表";
           break;
      default:
           break;
}
//
String time_interval="";
if (!beginTime.equals(""))
{
time_interval += " and a.cw_applytime > to_date('" + beginTime + " 00:00:00','yyyy-mm-dd hh24:mi:ss') ";
}
if (!endTime.equals(""))
{
time_interval += " and a.cw_applytime < to_date('" + endTime + " 23:59:59','yyyy-mm-dd hh24:mi:ss')";
}
%>
<%@include file="/system/app/skin/skin4/template/list_top.jsp"%>
<!--    模块名称开始    -->
<%=strTitle%>
<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/list_function.jsp"%>                                                            
<!--    功能按钮开始    -->
<img src="../../images/dialog/return.gif" border="0" onclick="javascript:history.back();" title="返回" style="cursor:hand" align="absmiddle" WIDTH="14" HEIGHT="14">
<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/list_listtop.jsp"%>                                                                                        
<!--    列表开始    -->
<table class="FindAreaTable1" cellspacing="1" rules="cols" border="0" id="ctl00_DataGrid_DataGrid1" style="border-width:0px;">
  <tr class="bttn"> 
    <td width="9%" class="outset-table" nowrap rowspan="2">序号</td>
    <td width="9%" class="outset-table" nowrap rowspan="2" align="center">部门</td>
    <td colspan="2" nowrap class="outset-table" >收到信件</td>           
    <td class="outset-table" nowrap colspan="2">超时信件</td>
		<td class="outset-table" nowrap colspan="2">是否公开</td>
  </tr>
  <tr class="bttn">
    <td width="14%" class="outset-table" nowrap align="center" >未处理</td> 
    <td width="12%" class="outset-table" nowrap align="center" >已处理</td>
    <td width="17%" nowrap class="outset-table">受理超时</td>
    <td width="17%" nowrap class="outset-table">办理超时</td>
		<td width="7%" nowrap class="outset-table">是 </td>
    <td width="15%" nowrap class="outset-table">否</td>
  </tr>
  <%

  Vector vPage = dImpl.splitPage(sqlStr_dt,request,200);
     if (vPage!=null)

     {				  
	     for (int i=0;i<vPage.size();i++)
	     {
		Hashtable content = (Hashtable)vPage.get(i);
		dt_id = content.get("dt_id").toString();
		cp_name = content.get("cp_name").toString();
		cp_upid = content.get("cp_upid").toString();		 
		%>
<tr width="100%" <%if (i%2==0) out.print("class='line-even'");else out.print("class='line-odd'");%>>
	<td align="center"><%=i+1%>					</td>
	<td align="center"><%=content.get("dt_name").toString()%></td>					
	<%
	  sqlStr = "select count(a.cw_id) from tb_connwork a,tb_connproc b where a.cp_id=b.cp_id and b.dt_id="+dt_id;
	  if(!"".equals(cp_upid)){
		  switch(j)
		  {
			case 1:
				sqlStr += " and b.cp_upid='"+cp_upid+"'";
				break;
			case 2:
				sqlStr += " and b.cp_upid='"+cp_upid+"'";
				break;
			case 3:
				break;
		  }
	  }
	  sqlStr += time_interval;
	  content_cw = dImpl.getDataInfo(sqlStr);
	  count1 += Integer.parseInt(content_cw.get("count(a.cw_id)").toString());
	  //未处理
	  String sqlnotOverStr = "";
	  Hashtable content_cwnotOver = null;
	  sqlnotOverStr = "select count(a.cw_id) from tb_connwork a,tb_connproc b where a.cp_id=b.cp_id and a.cw_status not in(2,8,3,9,12) and b.dt_id="+dt_id;
	  if(!"".equals(cp_upid)){
	  switch(j)
	  {
		case 1:
			sqlnotOverStr += " and b.cp_upid='"+cp_upid+"'";
			break;
		case 2:
			sqlnotOverStr += " and b.cp_upid='"+cp_upid+"'";
			break;
		case 3:
			break;
	  }
	  }
	  sqlnotOverStr += time_interval;
	  content_cwnotOver = dImpl.getDataInfo(sqlnotOverStr);
	  //已处理
	  String sqlOverStr = "";
	  Hashtable content_cwOver = null;
	  sqlOverStr = "select count(a.cw_id) from tb_connwork a,tb_connproc b where a.cp_id=b.cp_id and a.cw_status in(3,9) and b.dt_id="+dt_id;
	  if(!"".equals(cp_upid)){
	  switch(j)
	  {
		case 1:
			sqlOverStr += " and b.cp_upid='"+cp_upid+"'";
			break;
		case 2:
			sqlOverStr += " and b.cp_upid='"+cp_upid+"'";
			break;
		case 3:
			break;
	  }
	  }
	  sqlOverStr += time_interval;
	  content_cwOver = dImpl.getDataInfo(sqlOverStr);
	%>
	<td align="center"><A HREF="/system/app/stat/mailtationList.jsp?beginTime=<%=beginTime%>&endTime=<%=endTime%>&dt_id=<%=dt_id%>&processing=0"><%=content_cwnotOver.get("count(a.cw_id)").toString()%></A></td>                    
	<td align="center"><A HREF="/system/app/stat/mailtationList.jsp?beginTime=<%=beginTime%>&endTime=<%=endTime%>&dt_id=<%=dt_id%>&processing=1"><%=content_cwOver.get("count(a.cw_id)").toString()%></A></td>

  <%
	  //受理超时
	  String countovertime = tc.getCoutOvertime(dt_id,time_interval,"isovertime",cp_upid);
	  count3 += Integer.parseInt(countovertime);
%>
<td align="center"><A HREF="#"><%=countovertime%></A>              </td>
<%
	  //办理超时
	  String countovertimem = tc.getCoutOvertime(dt_id,time_interval,"isovertimem",cp_upid);
	  count4 += Integer.parseInt(countovertimem);
%>
<td align="center"><A HREF="#"><%=countovertimem%></A>            </td>
	  <%
	//公开
sqlStr_cw4 = "select count(a.cw_id) ";
	  sqlStr_cw4 += "from tb_connwork a,tb_connproc b  ";
	  sqlStr_cw4 += "where a.cw_status <> 9 and a.cw_ispublish='1' and a.cp_id=b.cp_id and b.dt_id="+dt_id;
	  
	  if(!"".equals(cp_upid)){
	  switch(j)
	  {
		case 1:
			sqlStr_cw4 += " and b.cp_upid='"+cp_upid+"'";
			break;
		case 2:
			sqlStr_cw4 += " and b.cp_upid='"+cp_upid+"'";
			break;
		case 3:
			break;
	  }
	  }
	  sqlStr_cw4 += time_interval;
	  
	  content_cw4 = dImpl.getDataInfo(sqlStr_cw4);
	  count5 += Integer.parseInt(content_cw4.get("count(a.cw_id)").toString());
%>
<td align="center"><A HREF="/system/app/stat/mailtationList.jsp?beginTime=<%=beginTime%>&endTime=<%=endTime%>&dt_id=<%=dt_id%>&ispublish=1"><%=content_cw4.get("count(a.cw_id)").toString()%></A>	          </td>
	  <%
	//不公开
sqlStr_cw5 = "select count(a.cw_id) ";
	  sqlStr_cw5 += "from tb_connwork a,tb_connproc b  ";
	  sqlStr_cw5 += "where a.cw_status <> 9 and a.cw_ispublish<>'1' and a.cp_id=b.cp_id and b.dt_id="+dt_id;
	  if(!"".equals(cp_upid)){
	  switch(j)
	  {
		case 1:
			sqlStr_cw5 += " and b.cp_upid='"+cp_upid+"'";
			break;
		case 2:
			sqlStr_cw5 += " and b.cp_upid='"+cp_upid+"'";
			break;
		case 3:
			break;
	  }
	  }
	  sqlStr_cw5 += time_interval;
	  content_cw5 = dImpl.getDataInfo(sqlStr_cw5);
	  count6 += Integer.parseInt(content_cw5.get("count(a.cw_id)").toString());
%>
<td align="center"><A HREF="/system/app/stat/mailtationList.jsp?beginTime=<%=beginTime%>&endTime=<%=endTime%>&dt_id=<%=dt_id%>&ispublish=0"><%=content_cw5.get("count(a.cw_id)").toString()%></A>          </td>
</tr>
<%
  }
%>
<tr class="line-even">
   <td align="center">合计</td>
	<td align="center">-</td>
	<td colspan="2" align="center"><%=count1%></td>					
	<td align="center"><%=count3%></td>
	<td align="center"><%=count4%></td>
	<td align="center"><%=count5%></td>
	<td align="center"><%=count6%></td>	
</tr>
<%
}
else
{
	out.print("<tr class='line-even'><td colspan='5'>没有匹配记录</td></tr>");
}
%>                               
</table>
<SCRIPT LANGUAGE="javascript"> 
<!-- 
function AutomateExcel() 
{ 
// Start Excel and get Application object. 
var oXL = new ActiveXObject("Excel.Application"); 
// Get a new workbook. 
var oWB = oXL.Workbooks.Add(); 
var oSheet = oWB.ActiveSheet; 
var table = document.all.data; 
var hang = table.rows.length; 

var lie = table.rows(0).cells.length; 

// Add table headers going cell by cell. 
for (i=0;i<hang;i++) 
{ 
for (j=0;j<lie;j++) 
{ 
oSheet.Cells(i+1,j+1).value = table.rows(i).cells(j).innerText; 
} 

} 
oXL.Visible = true; 
oXL.UserControl = true; 
} 
//--> 
</SCRIPT>
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