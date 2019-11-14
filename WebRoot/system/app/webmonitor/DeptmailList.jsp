<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%
//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 

String begin_time = CTools.dealString(request.getParameter("begin_time")).trim();
String end_time = CTools.dealString(request.getParameter("end_time")).trim();
String dt_id = CTools.dealString(request.getParameter("conntype").trim());

String sqlStr = "";
String dm_id = "";
String dm_time = "";
String dt_idarray[] = null;
String dt_namearray[] = null;
String sql_name = "";
int dt_num = 0;
if(!dt_id.equals("oo"))
{
	sql_name = "select c.dt_id,c.dt_name from tb_deptinfo c,tb_subjectlinkdept d where c.dt_id=d.dt_id and c.dt_id='"+dt_id+"'";
}
else
{
	sql_name = "select dt_id,dt_name from tb_deptinfo where dt_parent_id in(192,193,194,195) order by dt_sequence";
}
	Vector vectorPage = dImpl.splitPage(sql_name,request,1000000);
	if (vectorPage != null)
	{
	dt_num = vectorPage.size();
	dt_namearray = new String[dt_num+1];
	dt_idarray = new String[dt_num+1];
	for(int k=0;k<vectorPage.size();k++)
	{
		Hashtable content_name = (Hashtable)vectorPage.get(k);
		dt_idarray[k] = content_name.get("dt_id").toString();
		dt_namearray[k] = content_name.get("dt_name").toString();
	}
	}

int dm_recleadmail[] = new int[dt_num+1];
int dm_unsettledleadmail[] = new int[dt_num+1];
int dm_feedbackleadmail[] = new int[dt_num+1];
int dm_recconsultation[] = new int[dt_num+1];
int dm_unsettledconsultation[] = new int[dt_num+1];
int dm_feedbackconsultation[] = new int[dt_num+1];
int dm_recsupervise[] = new int[dt_num+1];
int dm_unsettledsupervise[] = new int[dt_num+1];
int dm_feedbacksupervise[] = new int[dt_num+1];
int dm_reccomplaint[] = new int[dt_num+1];
int dm_unsettledcomplaint[] = new int[dt_num+1];
int dm_feedbackcomplaint[] = new int[dt_num+1];

dm_recleadmail[dt_num] = 0;
dm_unsettledleadmail[dt_num] = 0;
dm_feedbackleadmail[dt_num] = 0;
dm_recconsultation[dt_num] = 0;
dm_unsettledconsultation[dt_num] = 0;
dm_feedbackconsultation[dt_num] = 0;
dm_recsupervise[dt_num] = 0;
dm_unsettledsupervise[dt_num] = 0;
dm_feedbacksupervise[dt_num] = 0;
dm_reccomplaint[dt_num] = 0;
dm_unsettledcomplaint[dt_num] = 0;
dm_feedbackcomplaint[dt_num] = 0;

Vector vPage = null;
for(int i=0;i<dt_num;i++)
{
	sqlStr = "select c.*,d.dt_name from jk_deptmail c,tb_deptinfo d where to_date(c.dm_time || ' 00:00:00','yyyy-mm-dd hh24:mi:ss') >= to_date('"+begin_time+" 00:00:00','yyyy-mm-dd hh24:mi:ss') and to_date(c.dm_time || ' 00:00:00','yyyy-mm-dd hh24:mi:ss') <= to_date('"+end_time+" 23:59:59','yyyy-mm-dd hh24:mi:ss') and c.dt_id=d.dt_id and d.dt_id='"+dt_idarray[i]+"' order by to_date(c.dm_time || ' 00:00:00','yyyy-mm-dd hh24:mi:ss')";
	vPage = dImpl.splitPage(sqlStr,request,1000);
	  if (vPage != null)
	  {
	  for(int j=0;j<vPage.size();j++)
	  {
	   Hashtable content = (Hashtable)vPage.get(j);
	   dm_recleadmail[i] += Integer.parseInt(content.get("dm_recleadmail").toString());
	   
	   dm_unsettledleadmail[i] = Integer.parseInt(content.get("dm_unsettledleadmail").toString());
	   
	   dm_feedbackleadmail[i] += Integer.parseInt(content.get("dm_feedbackleadmail").toString());
	   
  
	   dm_recconsultation[i] += Integer.parseInt(content.get("dm_recconsultation").toString());
	   
	   dm_unsettledconsultation[i] = Integer.parseInt(content.get("dm_unsettledconsultation").toString());
	   
	   dm_feedbackconsultation[i] += Integer.parseInt(content.get("dm_feedbackconsultation").toString());
	   
	   
	   dm_recsupervise[i] += Integer.parseInt(content.get("dm_recsupervise").toString());
	   
	   dm_unsettledsupervise[i] = Integer.parseInt(content.get("dm_unsettledsupervise").toString());
	   
	   dm_feedbacksupervise[i] += Integer.parseInt(content.get("dm_feedbacksupervise").toString());
	   
	   
	   dm_reccomplaint[i] += Integer.parseInt(content.get("dm_reccomplaint").toString());
	   
	   dm_unsettledcomplaint[i] = Integer.parseInt(content.get("dm_unsettledcomplaint").toString());
	   
	   dm_feedbackcomplaint[i] += Integer.parseInt(content.get("dm_feedbackcomplaint").toString());	   
	   
	  }
	  }
}
String strTitle = "委办局来信情况监控列表("+begin_time+"至"+end_time+")";
%>
<table class="content-table" width="100%">
                <tr class="title1">
                       <td valign="center"><span align="left"><%=strTitle%></span>&nbsp;&nbsp;&nbsp;&nbsp;
					   <span align="right"><a href="javascript:AutomateExcel()">导出Excel</a></span>
                       </td>
                </tr>
</table>
<table class="main-table" width="100%" id="data">
  <tr class="bttn" width="100%">
    <td align="center" width="4%">部门名称</td>
    <td align="center" width="8%">收到领导信件数</td>
	<td align="center" width="8%">未处理领导信件数</td>
	<td align="center" width="8%">已回复领导信件数</td>
    <td align="center" width="8%">收到网上咨询数</td>
    <td align="center" width="8%">未处理网上咨询数</td>
	<td align="center" width="8%">已回复网上咨询数</td>
	<td align="center" width="8%">收到网上投诉数</td>
	<td align="center" width="8%">未处理网上投诉数</td>
	<td align="center" width="8%">已回复网上投诉数</td>
	<td align="center" width="8%">收到网上信访数</td>
	<td align="center" width="8%">未处理网上信访数</td>
	<td align="center" width="8%">已回复网上信访数</td>
  </tr>
  <%
  if(vPage!=null)
  {
   for(int n=0;n<dt_num;n++)
	{	
   if(n % 2 == 0)  out.print("<tr class=\"line-even\">");
   else out.print("<tr class=\"line-odd\">");
   dm_recleadmail[dt_num] += dm_recleadmail[n];
   dm_unsettledleadmail[dt_num] += dm_unsettledleadmail[n];
   dm_feedbackleadmail[dt_num] += dm_feedbackleadmail[n];
   dm_recconsultation[dt_num] += dm_recconsultation[n];
   dm_unsettledconsultation[dt_num] += dm_unsettledconsultation[n];
   dm_feedbackconsultation[dt_num] += dm_feedbackconsultation[n];
   dm_recsupervise[dt_num] += dm_recsupervise[n];
   dm_unsettledsupervise[dt_num] += dm_unsettledsupervise[n];
   dm_feedbacksupervise[dt_num] += dm_feedbacksupervise[n];
   dm_reccomplaint[dt_num] += dm_reccomplaint[n];
   dm_unsettledcomplaint[dt_num] += dm_unsettledcomplaint[n];
   dm_feedbackcomplaint[dt_num] += dm_feedbackcomplaint[n];
  %>
  <td align="center"><%=dt_namearray[n]%></td>
  <td align="center"><a href="AppealList.jsp?type=5&beginTime=<%=begin_time%>&endTime=<%=end_time%>&dt_id=<%=dt_idarray[n]%>"><%=dm_recleadmail[n]%></a></td>
  <td align="center"><%=dm_unsettledleadmail[n]%></td>
  <td align="center"><%=dm_feedbackleadmail[n]%></td>

  <td align="center"><a href="AppealList.jsp?type=6&beginTime=<%=begin_time%>&endTime=<%=end_time%>&dt_id=<%=dt_idarray[n]%>"><%=dm_recconsultation[n]%></a></td>
  <td align="center"><%=dm_unsettledconsultation[n]%></td>
  <td align="center"><%=dm_feedbackconsultation[n]%></td>
  
  <td align="center"><a href="AppealList.jsp?type=7&beginTime=<%=begin_time%>&endTime=<%=end_time%>&dt_id=<%=dt_idarray[n]%>"><%=dm_recsupervise[n]%></a></td>
  <td align="center"><%=dm_unsettledsupervise[n]%></td>
  <td align="center"><%=dm_feedbacksupervise[n]%></td>

  <td align="center"><a href="AppealList.jsp?type=8&beginTime=<%=begin_time%>&endTime=<%=end_time%>&dt_id=<%=dt_idarray[n]%>"><%=dm_reccomplaint[n]%></a></td>
  <td align="center"><%=dm_unsettledcomplaint[n]%></td>
  <td align="center"><%=dm_feedbackcomplaint[n]%></td>
  </tr>
<%
  }
	if(dt_num>1)
	{
	%>
	<tr>
	<td align="center">合计</td>
	<td align="center"><%=dm_recleadmail[dt_num]%></td>
	<td align="center"><%=dm_unsettledleadmail[dt_num]%></td>
	<td align="center"><%=dm_feedbackleadmail[dt_num]%></td>

	<td align="center"><%=dm_recconsultation[dt_num]%></td>
	<td align="center"><%=dm_unsettledconsultation[dt_num]%></td>
	<td align="center"><%=dm_feedbackconsultation[dt_num]%></td>

	<td align="center"><%=dm_recsupervise[dt_num]%></td>
	<td align="center"><%=dm_unsettledsupervise[dt_num]%></td>
	<td align="center"><%=dm_feedbacksupervise[dt_num]%></td>

	<td align="center"><%=dm_reccomplaint[dt_num]%></td>
	<td align="center"><%=dm_unsettledcomplaint[dt_num]%></td>
	<td align="center"><%=dm_feedbackcomplaint[dt_num]%></td>
  </tr>
	<%
	}
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
<%
dImpl.closeStmt();
dCn.closeCn();
} catch (Exception ex) {
	System.out.println(new java.util.Date() + "--"
			+ request.getServletPath() + " : " + ex.getMessage());
} finally {
	if(dImpl != null)
	dImpl.closeStmt();
	if(dCn != null)
	dCn.closeCn();
}
%>
<%@include file="/system/app/skin/bottom.jsp"%>