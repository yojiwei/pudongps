<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%
CMySelf self = (CMySelf)session.getAttribute("mySelf");
String selfdtid = String.valueOf(self.getDtId());
String sender_id = String.valueOf(self.getMyID());

String begin_time = CTools.dealString(request.getParameter("begin_time")).trim();
String end_time = CTools.dealString(request.getParameter("end_time")).trim();
String sqlStr = "select * from jk_complaint where to_date(cp_time || ' 00:00:00','yyyy-mm-dd hh24:mi:ss') >= to_date('"+begin_time+" 00:00:00','yyyy-mm-dd hh24:mi:ss') and to_date(cp_time || ' 00:00:00','yyyy-mm-dd hh24:mi:ss') <= to_date('"+end_time+" 23:59:59','yyyy-mm-dd hh24:mi:ss') order by to_date(cp_time || ' 00:00:00','yyyy-mm-dd hh24:mi:ss')";
//out.println(sqlStr);//out.close();
String cp_id = "";
String cp_time = "";
int cp_wardenturn = 0;
int cp_websitenum = 0;
int cp_deptnum = 0;
int cp_unsettlednum = 0;
int cp_turnednum = 0;
int cp_feedbacknum = 0;


String strTitle = "信访办来信情况监控列表("+begin_time+"至"+end_time+")";
//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 
Vector vPage = dImpl.splitPage(sqlStr,request,10000);
if (vPage != null)
{
  for(int j=0;j<vPage.size();j++)
  {
   Hashtable content = (Hashtable)vPage.get(j);
   cp_id = content.get("cp_id").toString();
   cp_time = content.get("cp_time").toString();
   cp_wardenturn += Integer.parseInt(content.get("cp_wardenturn").toString());
   cp_websitenum += Integer.parseInt(content.get("cp_websitenum").toString());
   cp_deptnum += Integer.parseInt(content.get("cp_deptnum").toString());
   cp_unsettlednum = Integer.parseInt(content.get("cp_unsettlednum").toString());
   cp_turnednum += Integer.parseInt(content.get("cp_turnednum").toString());
   cp_feedbacknum += Integer.parseInt(content.get("cp_feedbacknum").toString());
  }
}
%>
<table class="content-table" width="100%">
                <tr class="title1">
                       <td valign="center"><span align="left"><%=strTitle%></span>&nbsp;&nbsp;&nbsp;&nbsp;
					   <span align="right"><a href="javascript:AutomateExcel()">导出Excel</a></span>
                       </td>
                </tr>
</table>
<table class="main-table" width="100%"  id="data">
 <tr class="bttn" width="100%">
    <td align="center" width="15%">区长信箱转办信访件数</td>
    <td align="center" width="15%">网上收到信访件数</td>
	<td align="center" width="15%">各委办局收到信访件数</td>
	<td align="center" width="15%">未处理信访件数</td>
    <td align="center" width="15%">已转办信访件数</td>
    <td align="center" width="15%">已回复信访件数</td>
  </tr>
  <tr  class="line-odd">
  <td align="center"><a href="AppealList.jsp?type=2&beginTime=<%=begin_time%>&endTime=<%=end_time%>"><%=cp_wardenturn%></a></td>
  <td align="center"><a href="AppealList.jsp?type=3&beginTime=<%=begin_time%>&endTime=<%=end_time%>"><%=cp_websitenum%></a></td>
  <td align="center"><%=cp_deptnum%></td>
  <td align="center"><%=cp_unsettlednum%></td>
  <td align="center"><%=cp_turnednum%></td>
  <td align="center"><%=cp_feedbacknum%></td>
  </tr>
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