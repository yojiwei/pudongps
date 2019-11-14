<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%
String begin_time = CTools.dealString(request.getParameter("begin_time")).trim();
String end_time = CTools.dealString(request.getParameter("end_time")).trim();

String strTitle = "政府公开维护统计列表(" + begin_time + "至" + end_time + ")";
//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 

String Sql_Reslet = "select dt_id,dt_name from tb_deptinfo where dt_parent_id in(192,193,194,195) order by dt_sequence ";
Vector vPage_Reslet = dImpl.splitPage(Sql_Reslet,1000,1);
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
	<td align="center" width="10%">未回复的网上市民来信数</td>   	
	<td align="center" width="10%">未回复的网上市民来信数（总数）</td>   
  </tr>
<%
int Content_Count_Size = 0;
int Content_CountSize_Size = 0;
if(vPage_Reslet!=null){
	for(int i =0; i<vPage_Reslet.size();i++){
		Hashtable  hasMap= new Hashtable();
		Hashtable Has_Reslet = (Hashtable)vPage_Reslet.get(i);
		String dt_id = Has_Reslet.get("dt_id").toString();
		String dt_name = Has_Reslet.get("dt_name").toString();
		String Sql_content = "select count(*)as count from tb_connwork where  cp_id in(select cp_id from tb_connproc  where dt_id ="+dt_id+" and cp_upid!='o7') and cw_status in (0,1) and to_date('"+begin_time+" 00:00:00','yyyy-mm-dd hh24:mi:ss')<cw_applytime and to_date('"+end_time+" 23:59:59','yyyy-mm-dd hh24:mi:ss')>cw_applytime";


		String Sql_contentSize = "select count(*) as countsize from tb_connwork where  cp_id in(select cp_id from tb_connproc  where dt_id ="+dt_id+" and cp_upid!='o7') and cw_status in (0,1)";
		Hashtable Has_content = dImpl.getDataInfo(Sql_content);
		Hashtable Has_contentSize = dImpl.getDataInfo(Sql_contentSize);
		String Content_Count = Has_content.get("count").toString();
		String Content_CountSize= Has_contentSize.get("countsize").toString();
		Content_Count_Size += Integer.parseInt(Content_Count);
		Content_CountSize_Size += Integer.parseInt(Content_CountSize);
	if(i % 2 == 0)  out.print("<tr class=\"line-even\">");
   else out.print("<tr class=\"line-odd\">");
 %>
  <td align="center"><%=dt_name%></td>
  <td align="center"><%=Content_Count%></td>
  <td align="center"><%=Content_CountSize%></td>
  </tr>
<%
	}
}
%>
<tr>
  <td align="center">总计</td>
  <td align="center"><%=Content_Count_Size%></td>
  <td align="center"><%=Content_CountSize_Size%></td>
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