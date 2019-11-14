<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%
CMySelf self = (CMySelf)session.getAttribute("mySelf");
String selfdtid = String.valueOf(self.getDtId());
String sender_id = String.valueOf(self.getMyID());
//Calendar cal = Calendar.getInstance();
//int month=cal.get(cal.MONTH)+1;
String ne_date_begin = CTools.dealString(request.getParameter("ne_date_begin")).trim();//获得起始日期
String ne_date_end = CTools.dealString(request.getParameter("ne_date_end")).trim();//获得结束日期


String sqlStr = "select * from jk_news where to_date(ne_date || ' 00:00:00','yyyy-mm-dd hh24:mi:ss') >= to_date('"+ne_date_begin+" 00:00:00','yyyy-mm-dd hh24:mi:ss') and to_date(ne_date || ' 00:00:00','yyyy-mm-dd hh24:mi:ss') <= to_date('"+ne_date_end+" 23:59:59','yyyy-mm-dd hh24:mi:ss') order by to_date(ne_date || ' 00:00:00','yyyy-mm-dd hh24:mi:ss')";
//out.println(sqlStr);
//out.close();
String ne_id = "";
String ne_date = "";
String ne_photo = "";
String ne_latest = "";
String ne_important = "";
String ne_pickup = "";
String ne_viewair = "";
String ne_tabloid = "";
String ne_special = "";
int ne_photo1 = 0;
int ne_latest1 = 0;
int ne_important1 = 0;
int ne_pickup1 = 0;
int ne_viewair1 = 0;
int ne_tabloid1 = 0;
int ne_special1 = 0;

String strTitle = "新闻中心更新情况";
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
    <td align="center" width="5%">编号　</td>
    <td align="center" width="12%">日期　</td>
    <td align="center" width="12%">图片新闻更新数</td>
    <td align="center" width="12%">最新消息更新数</td>
    <td align="center" width="12%">重要报道更新数</td>
    <td align="center" width="12%">社区采撷更新数</td>
    <td align="center" width="12%">区域浏览更新数</td>
    <td align="center" width="12%">八面来风更新数</td>
    <td align="center" width="12%">专题报道更新数</td>
  </tr>
<%
int j = 0;
Vector vPage = dImpl.splitPage(sqlStr,request,10000);
if (vPage != null)
{
	

  for(j=0;j<vPage.size();j++)
  {
   Hashtable content = (Hashtable)vPage.get(j);
   ne_id = content.get("ne_id").toString();
   ne_date = content.get("ne_date").toString();
   ne_photo = content.get("ne_photo").toString();
   ne_latest = content.get("ne_latest").toString();
   ne_important = content.get("ne_important").toString();
   ne_pickup = content.get("ne_pickup").toString();   
   ne_viewair = content.get("ne_viewair").toString();
   ne_tabloid = content.get("ne_tabloid").toString();
   ne_special = content.get("ne_special").toString();
   
   ne_photo1 += Integer.parseInt(ne_photo);
   ne_latest1 += Integer.parseInt(ne_latest);
   ne_important1 += Integer.parseInt(ne_important);
   ne_pickup1 += Integer.parseInt(ne_pickup);
   ne_viewair1 += Integer.parseInt(ne_viewair);
   ne_tabloid1 += Integer.parseInt(ne_tabloid);
   ne_special1 += Integer.parseInt(ne_special);

   if(j % 2 == 0)  out.print("<tr class=\"line-even\">");
   else out.print("<tr class=\"line-odd\">");
 %>
  <td align="center"><%=ne_id%></td>
  <td align="center"><%=ne_date%></td>
  <td align="center"><%=ne_photo%></td>
  <td align="center"><%=ne_latest%></td>
  <td align="center"><%=ne_important%></td>
  <td align="center"><%=ne_pickup%></td>
  <td align="center"><%=ne_viewair%></td>
  <td align="center"><%=ne_tabloid%></td>
  <td align="center"><%=ne_special%></td>
  </tr>
<%
  }
if(j!=1)
{
%>
<tr>
  <td align="center">合计</td>
  <td align="center"></td>
  <td align="center"><%=ne_photo1%></td>
  <td align="center"><%=ne_latest1%></td>
  <td align="center"><%=ne_important1%></td>
  <td align="center"><%=ne_pickup1%></td>
  <td align="center"><%=ne_viewair1%></td>
  <td align="center"><%=ne_tabloid1%></td>
  <td align="center"><%=ne_special1%></td>
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