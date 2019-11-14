<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%
String strTitle = "部门办事事项统计结果";
String guideNum = "" ;				//办事指南数
String quNum ="" ;					//常见问题数	
String tabNum ="" ;					//下载表格数
String proNum ="" ;					//办事数目
String commNum = "" ;				//常办事项数
String greenNum = "" ;				//绿色通道数
String accNum = "";					//在线办事数

int guideNum1 = 0;
int quNum1 = 0;
int tabNum1 = 0;
int proNum1 = 0;
int commNum1 = 0;
int greenNum1 = 0;
int accNum1 = 0;

String dt_id = CTools.dealString(request.getParameter("dt_id")).trim();
String dt_name = "";
String sqlStr = "";
Vector dtVec = new Vector();
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
					   <span align="right"><a href="javascript:AutomateExcel()">导出Excel</a></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					   <span valign="right">
						<select class="select-a" onChange="fnOnChange()">
							<option value="">所有部门</option>
							<%
							sqlStr = "select dt_id,dt_name from tb_deptinfo where dt_id in (select distinct dt_id from tb_proceeding) order by dt_sequence";
							Vector vPage = dImpl.splitPage(sqlStr,100,1);
							if (vPage!=null)
							{
								for (int i=0;i<vPage.size();i++)
								{
									Hashtable content = (Hashtable)vPage.get(i);
									String id = content.get("dt_id").toString();
									String name = content.get("dt_name").toString();
									%>
									<option value="<%=id%>" <%if (id.equals(dt_id)) out.print("selected");%>><%=name%></option>
									<%
								}
							}
							%>
						</select>&nbsp;
					   </span>
					   </td>
                </tr>
</table>
<table width="100%" class="main-table" id="data">
	<tr class="bttn" width="100%">
		<td class="outset-table" align="center">部门名称</td>
		<td class="outset-table" align="center">办事事项数</td>
		<td class="outset-table" align="center">下载表格数</td>
		<td class="outset-table" align="center">办事指南数</td>
		<td class="outset-table" align="center">常见问题数</td>
		<td class="outset-table" align="center">常办事项数</td>
		<td class="outset-table" align="center">绿色通道数</td>
		<td class="outset-table" align="center">在线办事数</td>
	</tr>
<%
if (dt_id.equals(""))
{
	for (int i=0;i<vPage.size();i++)
	{
		Hashtable content = (Hashtable)vPage.get(i);
		dtVec.addElement(content.get("dt_id").toString());
	}
}
else
{
	dtVec.addElement(dt_id);
}
int i = 0;
for (i=0;i<dtVec.size();i++)
{
	dt_id = (String)dtVec.get(i);
	sqlStr = "select dt_name from tb_deptinfo where dt_id=" + dt_id + "";
	Hashtable content = dImpl.getDataInfo(sqlStr);
	if (content!=null)
	{
		dt_name = content.get("dt_name").toString();
	}

	//获得办事事项数
	sqlStr = "select count(pr_id) num from tb_proceeding where dt_id=" + dt_id + "";
	Hashtable contentPro = dImpl.getDataInfo(sqlStr);
	if (contentPro!=null)
	{
		proNum = contentPro.get("num").toString();
		proNum1 += Integer.parseInt(proNum);
	}

	//获得办事指南数
	sqlStr = "select count(pr_id) num from tb_proceeding where dt_content is not null and to_char(dt_content)<>'<DIV></DIV>' and dt_id=" + dt_id + "";
	Hashtable contentGui = dImpl.getDataInfo(sqlStr);
	if (contentGui!=null)
	{
		guideNum = contentGui.get("num").toString();
	}

	//获得常见问题数
	sqlStr = "select count(pr_id) num from tb_proceeding where PR_SUMMARIZE is not null and to_char(PR_SUMMARIZE)<>'<DIV></DIV>' and dt_id=" + dt_id + "";
	Hashtable contentQu = dImpl.getDataInfo(sqlStr);
	if (contentQu!=null)
	{
		quNum = contentQu.get("num").toString();
		quNum1 += Integer.parseInt(quNum);
	}

	//获得下载表格数
	sqlStr = "select count(pa_id) num from tb_proceedingattach where pr_id in(select pr_id from tb_proceeding where dt_id=" + dt_id + ")";
	Hashtable contentTab = dImpl.getDataInfo(sqlStr);
	if (contentTab!=null)
	{
		tabNum = contentTab.get("num").toString();
		tabNum1 += Integer.parseInt(tabNum);
	}

	//获得常办事项数
	sqlStr = "select count(pr_id) num from tb_proceeding where dt_id=" + dt_id + " and pr_id in (select pr_id from tb_proceedingex where pe_iscommon=1)";
	Hashtable contentComm = dImpl.getDataInfo(sqlStr);
	if (contentComm!=null)
	{
		commNum = contentComm.get("num").toString();
		commNum1 += Integer.parseInt(commNum);
	}

	//获得绿色通道数
	sqlStr = "select count(pr_id) num from tb_proceeding where dt_id=" + dt_id + " and pr_isschedule=1";
	Hashtable contentGre = dImpl.getDataInfo(sqlStr);
	if (contentGre!=null)
	{
		greenNum = contentGre.get("num").toString();
		greenNum1 += Integer.parseInt(greenNum);
	}

	//获得在线办事数
	sqlStr = "select count(pr_id) num from tb_proceeding where dt_id=" + dt_id + " and pr_isaccept=1";
	Hashtable contentAcc = dImpl.getDataInfo(sqlStr);
	if (contentAcc!=null)
	{
		accNum = contentAcc.get("num").toString();
		accNum1 += Integer.parseInt(accNum);
	}
	%>
	<tr class="<%if (i%2==0) out.print("line-odd");else out.print("line-even");%>" width="100%">
		<td align="center"><%=dt_name%></td>
		<td align="center"><%=proNum%></td>
		<td align="center"><%=tabNum%></td>
		<td align="center"><%=guideNum%></td>
		<td align="center"><%=quNum%></td>
		<td align="center"><%=commNum%></td>
		<td align="center"><%=greenNum%></td>
		<td align="center"><%=accNum%></td>
	</tr>
	<%
}
if(i!=1)
{
%>
<tr width="100%">
		<td align="center">合计</td>
		<td align="center"><%=proNum1%></td>
		<td align="center"><%=tabNum1%></td>
		<td align="center"><%=guideNum1%></td>
		<td align="center"><%=quNum1%></td>
		<td align="center"><%=commNum1%></td>
		<td align="center"><%=greenNum1%></td>
		<td align="center"><%=accNum1%></td>
<%
}	
%>
</tr>
</table>
<%
dImpl.closeStmt();
dCn.closeCn();
%>
<script language="JavaScript">
function fnOnChange()
{
	var obj = event.srcElement;
	var index = obj.selectedIndex;
	var val = obj.options[index].value;
	window.location.href="/system/app/webmonitor/ProceedSum.jsp?dt_id=" + val;
}
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
</script>
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
