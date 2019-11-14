<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%
String begin_time = CTools.dealString(request.getParameter("begin_time")).trim();
String end_time = CTools.dealString(request.getParameter("end_time")).trim();




String sWhere = "";
if (!begin_time.equals(""))
	{
		sWhere=sWhere + " and TO_DATE(ct_create_time,'YYYY-MM-DD') >= TO_DATE('"+ begin_time +"','YYYY-MM-DD')";
	}
if (!end_time.equals(""))
	{
		sWhere=sWhere + " and TO_DATE(ct_create_time,'YYYY-MM-DD') <= TO_DATE('"+ end_time +"','YYYY-MM-DD')";
	}

//String sqlStr = "select c.go_id,c.GO_DATE,c.GO_DYNAMICNUM,c.GO_LAW,c.GO_MODDIAGRAMDATE,c.GO_MODPERFORMDATE,c.GO_MODPHOTODATE,c.GO_MODWORKDATE,d.dt_name,count(n.ct_id) as count from jk_govopen c,tb_deptinfo d,tb_content n where n.dt_id = c.dt_id " + sWhere + " and c.dt_id=d.dt_id and d.dt_parent_id in (192,193,194,195) and n.sj_id in (select sj_id from tb_subject where sj_devide = 'dongtai') and n.ct_publish_flag='1' group by c.go_id,c.GO_DATE,c.GO_DYNAMICNUM,c.GO_LAW,c.GO_MODDIAGRAMDATE,c.GO_MODPERFORMDATE,c.GO_MODPHOTODATE,c.GO_MODWORKDATE,d.dt_name,d.dt_sequence order by d.dt_sequence";

String sql = "select * from (select count(c.ct_id) as count,d.dt_name,d.dt_sequence from tb_content c ,tb_subject s1,tb_subject s2,tb_deptinfo d where c.sj_id=s1.sj_id and s1.sj_devide = 'dongtai' and s1.sj_parentid=s2.sj_id " + sWhere + " and s2.sj_name=d.dt_name and d.dt_parent_id in (192,193,194,195) group by d.dt_name,d.dt_sequence union select 0 as count,dt_name,dt_sequence from tb_deptinfo where dt_id not in(select d.dt_id from tb_content c ,tb_subject s1,tb_subject s2,tb_deptinfo d where c.sj_id=s1.sj_id and s1.sj_devide = 'dongtai' and s1.sj_parentid=s2.sj_id " + sWhere + " and s2.sj_name=d.dt_name and d.dt_parent_id in (192,193,194,195)) and dt_parent_id in (192,193,194,195)) order by dt_sequence "; 
//out.print(sql);
String dt_name = "";
String dt_id = "";
String strTitle = "政务公开维护监控列表(" + begin_time + "至" + end_time + ")";
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
  </tr>
<%
Vector vPage = dImpl.splitPage(sql,1000,1);
if (vPage != null)
{
  for(int j=0;j<vPage.size();j++)
  {
   Hashtable content = (Hashtable)vPage.get(j);   
   dt_name = content.get("dt_name").toString();
   //dt_id = content.get("dt_id").toString();
   String count = ""; 
   if(content!=null)
	{
		count = content.get("count").toString();
   }
   else
   {
		count = "0";
   }

   if(j % 2 == 0)  out.print("<tr class=\"line-even\">");
   else out.print("<tr class=\"line-odd\">");
 %>
  <td align="center"><%=dt_name%></td>
  <td align="center"><%=count%></td>
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