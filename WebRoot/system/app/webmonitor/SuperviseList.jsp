<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%
CMySelf self = (CMySelf)session.getAttribute("mySelf");
String selfdtid = String.valueOf(self.getDtId());
String sender_id = String.valueOf(self.getMyID());

String begin_time = CTools.dealString(request.getParameter("begin_time")).trim();
String end_time = CTools.dealString(request.getParameter("end_time")).trim();
String sqlStr = "select * from jk_supervise where to_date(sv_time || ' 00:00:00','yyyy-mm-dd hh24:mi:ss') >= to_date('"+begin_time+" 00:00:00','yyyy-mm-dd hh24:mi:ss') and to_date(sv_time || ' 00:00:00','yyyy-mm-dd hh24:mi:ss') <= to_date('"+end_time+" 23:59:59','yyyy-mm-dd hh24:mi:ss') order by to_date(sv_time || ' 00:00:00','yyyy-mm-dd hh24:mi:ss')";
//out.println(sqlStr);//out.close();
String sv_id = "";
String sv_time = "";
int sv_receivenum = 0;
int sv_unsettlednum = 0;
int sv_turndeptnum = 0;
int sv_feedbacknum = 0;


String strTitle = "监察委受理投诉情况监控列表("+begin_time+"至"+end_time+")";
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
   sv_id = content.get("sv_id").toString();
   sv_time = content.get("sv_time").toString();
   sv_receivenum += Integer.parseInt(content.get("sv_receivenum").toString());
   sv_unsettlednum = Integer.parseInt(content.get("sv_unsettlednum").toString());
   sv_turndeptnum += Integer.parseInt(content.get("sv_turndeptnum").toString());
   sv_feedbacknum += Integer.parseInt(content.get("sv_feedbacknum").toString());
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
<table class="main-table" width="100%" id="data">
  <tr class="bttn" width="100%">
    <td align="center" width="25%">收到投诉信件数</td>
    <td align="center" width="25%">未处理投诉信件数</td>
	<td align="center" width="25%">已转办投诉信件数</td>
    <td align="center" width="25%">已回复投诉信件数</td>
  </tr>
  <tr  class="line-odd">
  <td align="center"><a href="AppealList.jsp?type=4&beginTime=<%=begin_time%>&endTime=<%=end_time%>"><%=sv_receivenum%></a></td>
  <td align="center"><%=sv_unsettlednum%></td>
  <td align="center"><%=sv_turndeptnum%></td>
  <td align="center"><%=sv_feedbacknum%></td>
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
%>
<%@include file="/system/app/skin/bottom.jsp"%>
<%


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
