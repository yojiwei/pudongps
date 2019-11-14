<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%
//String begin_time = CTools.dealString(request.getParameter("begin_time")).trim();
//String end_time = CTools.dealString(request.getParameter("end_time")).trim();
String sqlStr = "select c.*,d.dt_name from jk_govopen c,tb_deptinfo d where c.dt_id=d.dt_id and d.dt_parent_id in (192,193,194,195) order by d.dt_sequence";
//out.println(sqlStr);//out.close();
String go_id = "";
String go_date = "";
String dt_name = "";
String go_dynamicnum = "";
String go_law = "";
String go_modphotodate = "";
String go_modworkdate = "";
String go_modperformdate = "";
String go_moddiagramdate = "";

String strTitle = "政务公开维护监控列表";
//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 
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
    <td align="center" width="10%">部门名称</td>
    <td align="center" width="10%">部门动态数</td>
	<td align="center" width="10%">法律法规数</td>
	<td align="center" width="17.5%">部门相片修改日期</td>
    <td align="center" width="17.5%">领导分工修改日期</td>
    <td align="center" width="17.5%">部门职能修改日期</td>
	<td align="center" width="17.5%">部门动态修改日期</td>
  </tr>
<%
Vector vPage = dImpl.splitPage(sqlStr,1000,1);
if (vPage != null)
{
  for(int j=0;j<vPage.size();j++)
  {
   Hashtable content = (Hashtable)vPage.get(j);
   go_id = content.get("go_id").toString();
   go_date = content.get("go_date").toString();
   dt_name = content.get("dt_name").toString();
   go_dynamicnum = content.get("go_dynamicnum").toString();
   go_law = content.get("go_law").toString();
   go_modphotodate = content.get("go_modphotodate").toString();
   go_modworkdate = content.get("go_modworkdate").toString();
   go_modperformdate = content.get("go_modperformdate").toString();
   go_moddiagramdate = content.get("go_moddiagramdate").toString();
   if(j % 2 == 0)  out.print("<tr class=\"line-even\">");
   else out.print("<tr class=\"line-odd\">");
 %>
  <td align="center"><%=dt_name%></td>
  <td align="center"><%=go_dynamicnum%></td>
  <td align="center"><%=go_law%></td>
  <td align="center"><%=go_modphotodate%></td>
  <td align="center"><%=go_modworkdate%></td>
  <td align="center"><%=go_modperformdate%></td>
  <td align="center"><%=go_moddiagramdate%></td>
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