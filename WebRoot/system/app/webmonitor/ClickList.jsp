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

String cc_num = "0";
String cc_numsum = "0";
String cc_date = "";
String cc_webkind = "";
String cc_num1 = "0";
String cc_numsum1 = "0";
String cc_date1 = "";
String cc_webkind1 = "";
String home_sql = "select distinct cc_date from jk_countclick where to_date(cc_date || ' 00:00:00','yyyy-mm-dd hh24:mi:ss') >= to_date('"+begin_time+" 00:00:00','yyyy-mm-dd hh24:mi:ss') and to_date(cc_date || ' 00:00:00','yyyy-mm-dd hh24:mi:ss') <= to_date('"+end_time+" 23:59:59','yyyy-mm-dd hh24:mi:ss')  order by to_date(cc_date || ' 00:00:00','yyyy-mm-dd hh24:mi:ss') desc";
//out.print(home_sql);
Vector home_vPage = dImpl.splitPage(home_sql,request,10000);
String strTitle = "网站日访问量监控列表("+begin_time+"至"+end_time+")";
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
	<td align="center" width="20%">统计时间</td>
	<td align="center" width="20%">门户首页日点击数</td>
    <td align="center" width="20%">平台首页日点击数</td>
	<td align="center" width="20%">门户首页总点击数</td>
    <td align="center" width="20%">平台首页总点击数</td>
  </tr>
  <%
	if(home_vPage!=null)
	{
		for(int j=0;j<home_vPage.size();j++)
		{
		Hashtable home_content = (Hashtable)home_vPage.get(j);
		
		if(home_content!=null)
		{
			cc_date = home_content.get("cc_date").toString();
			String sql_cc = "select cc_num,cc_numsum,cc_webkind from jk_countclick where cc_date='"+ cc_date +"'";
			//out.print(sql_cc);
			Vector vPage_cc = dImpl.splitPage(sql_cc,10,1);
			if(vPage_cc!=null)
			{
				for(int k=0;k<vPage_cc.size();k++)
				{
					Hashtable cc_content = (Hashtable)vPage_cc.get(k);
					cc_webkind = cc_content.get("cc_webkind").toString();
					if(cc_webkind.equals("1"))
					{
						cc_num = cc_content.get("cc_num").toString();
						cc_numsum = cc_content.get("cc_numsum").toString();
					}
					else if(cc_webkind.equals("2"))
					{
						cc_num1 = cc_content.get("cc_num").toString();
						cc_numsum1 = cc_content.get("cc_numsum").toString();
					}
				}
			}
		}

		if(j % 2 == 0)  out.print("<tr class=\"line-even\">");
		else out.print("<tr class=\"line-odd\">");
  %>
  <td align="center"><%=cc_date%></td>
  <td align="center"><%=cc_num%></td>
  <td align="center"><%=cc_num1%></td>
  <td align="center"><%=cc_numsum%></td>
  <td align="center"><%=cc_numsum1%></td>
  <%
	}
  %>
  </tr>
	<%
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