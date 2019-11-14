<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%
CDataCn dCn = null;
CDataImpl dImpl = null;
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn);
String begin_time = CTools.dealString(request.getParameter("begin_time")).trim();
String end_time = CTools.dealString(request.getParameter("end_time")).trim();
String wd_id = CTools.dealString(request.getParameter("conntype").trim());
String is_wd = "";
String sqlStr = "";
String wm_id = "";
String wm_time = "";
String wd_idarray[] = null;
String wd_namearray[] = null;
String sql_name = "";
int wd_num = 0;
if(!wd_id.equals("oo"))
{
	sql_name = "select wd_id,wd_name from tb_warden where wd_id='"+wd_id+"'";
}
else
{
	sql_name = "select wd_id,wd_name from tb_warden order by wd_sequence,wd_id";
}

	
	Vector vectorPage = dImpl.splitPage(sql_name,request,20);
	if (vectorPage != null)
	{
	wd_num = vectorPage.size();
	wd_namearray = new String[wd_num+1];
	wd_idarray = new String[wd_num+1];
	for(int k=0;k<vectorPage.size();k++)
	{
		Hashtable content_name = (Hashtable)vectorPage.get(k);
		wd_idarray[k] = content_name.get("wd_id").toString();
		wd_namearray[k] = content_name.get("wd_name").toString();
	}
	}
int wm_receivenum[] = new int[wd_num];
int wm_dropnum[] = new int[wd_num];
int wm_unsettlednum[] = new int[wd_num];
int wm_postilnum[] = new int[wd_num];
int wm_turndeptnum[] = new int[wd_num];
int wm_feedbacknum[] = new int[wd_num];
int wm_turncompnum[] = new int[wd_num];
int wm_ispublish[] = new int[wd_num];
int wm_notpublish[] = new int[wd_num];
int wm_overpublish[] = new int[wd_num];
int wm_notoverpublish[] = new int[wd_num];
Vector vPage = null;
	
for(int i=0;i<wd_num;i++)
{
//收到信件1
sqlStr = "select count(cw_id) as count,wd_name,1 as type from tb_connwork c,tb_warden d where c.cw_applytime >= to_date('"+begin_time+" 00:00:00','yyyy-mm-dd hh24:mi:ss') and c.cw_applytime <= to_date('"+end_time+" 23:59:59','yyyy-mm-dd hh24:mi:ss') and c.wd_id=d.wd_id and d.wd_id='"+wd_idarray[i]+"' group by wd_name";
//已处理
sqlStr += " union select count(cw_id) as count,wd_name,6 as type from tb_connwork c,tb_warden d where c.cw_applytime >= to_date('"+begin_time+" 00:00:00','yyyy-mm-dd hh24:mi:ss') and c.cw_applytime <= to_date('"+end_time+" 23:59:59','yyyy-mm-dd hh24:mi:ss') and c.wd_id=d.wd_id and d.wd_id='"+wd_idarray[i]+"' and c.cw_status=3 group by wd_name";
//未处理
sqlStr += " union select count(cw_id) as count,wd_name,7 as type from tb_connwork c,tb_warden d where c.cw_applytime >= to_date('"+begin_time+" 00:00:00','yyyy-mm-dd hh24:mi:ss') and c.cw_applytime <= to_date('"+end_time+" 23:59:59','yyyy-mm-dd hh24:mi:ss') and c.wd_id=d.wd_id and d.wd_id='"+wd_idarray[i]+"' and c.cw_status not in(2,3,9,12) group by wd_name";


//待处理超时2
sqlStr += " union select count(cw_id) as count,wd_name,2 as type from tb_connwork c,tb_warden d where c.cw_applytime >= to_date('"+begin_time+" 00:00:00','yyyy-mm-dd hh24:mi:ss') and c.cw_applytime <= to_date('"+end_time+" 23:59:59','yyyy-mm-dd hh24:mi:ss') and c.wd_id=d.wd_id  and c.cw_status <> 9 and c.cw_isovertime='1' and d.wd_id='"+wd_idarray[i]+"' group by wd_name";
//处理中超时3
sqlStr += " union select count(cw_id) as count,wd_name,3 as type from tb_connwork c,tb_warden d where c.cw_applytime >= to_date('"+begin_time+" 00:00:00','yyyy-mm-dd hh24:mi:ss') and c.cw_applytime <= to_date('"+end_time+" 23:59:59','yyyy-mm-dd hh24:mi:ss') and c.wd_id=d.wd_id and c.cw_status <> 9 and c.cw_isovertimem='1' and d.wd_id='"+wd_idarray[i]+"' group by wd_name";
//处理公开
sqlStr += " union select count(cw_id) as count,wd_name,4 as type from tb_connwork c,tb_warden d where c.cw_applytime >= to_date('"+begin_time+" 00:00:00','yyyy-mm-dd hh24:mi:ss') and c.cw_applytime <= to_date('"+end_time+" 23:59:59','yyyy-mm-dd hh24:mi:ss') and c.wd_id=d.wd_id and c.cw_status <> 9 and c.cw_ispublish='0' and d.wd_id='"+wd_idarray[i]+"' group by wd_name";
//处理不公开
sqlStr += " union select count(cw_id) as count,wd_name,5 as type from tb_connwork c,tb_warden d where c.cw_applytime >= to_date('"+begin_time+" 00:00:00','yyyy-mm-dd hh24:mi:ss') and c.cw_applytime <= to_date('"+end_time+" 23:59:59','yyyy-mm-dd hh24:mi:ss') and c.wd_id=d.wd_id and c.cw_status <> 9 and c.cw_ispublish ='2' and d.wd_id='"+wd_idarray[i]+"' group by wd_name";
   
out.println(sqlStr);
	vPage = dImpl.splitPage(sqlStr,request,100000);
	  if (vPage != null)
	  {
		  for(int j=0;j<vPage.size();j++)
		  {
			  
			   Hashtable content = (Hashtable)vPage.get(j);
			   switch(Integer.parseInt(content.get("type").toString())) {
				    case 1:wm_receivenum[i] = Integer.parseInt(content.get("count").toString());
						   break;
					case 2:wm_unsettlednum[i] = Integer.parseInt(content.get("count").toString()); 
					       break;
					case 3:wm_postilnum[i] = Integer.parseInt(content.get("count").toString());
						   break;
				    case 4:wm_ispublish[i] = Integer.parseInt(content.get("count").toString());
						   break;
				    case 5:wm_notpublish[i] = Integer.parseInt(content.get("count").toString());
						   break;
				 	case 6:wm_overpublish[i] = Integer.parseInt(content.get("count").toString());
						   break;
					case 7:wm_notoverpublish[i] = Integer.parseInt(content.get("count").toString());
						   break;
					default:break;
			    }
		  }
	  }
	  
}
String strTitle = "区长信箱来信情况监控列表("+begin_time+"至"+end_time+")";

%>
<%@include file="/system/app/skin/skin4/template/list_top.jsp"%>
<!--    模块名称开始    -->
<%=strTitle%>
<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/list_function.jsp"%>                                                            
<!--    功能按钮开始    -->
<span align="center"><a href="javascript:AutomateExcel()">导出Excel</a></span>
<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/list_listtop.jsp"%>                                                                                        
<!--    列表开始    -->
<table class="FindAreaTable1" cellspacing="1" rules="cols" border="0" id="ctl00_DataGrid_DataGrid1" style="border-width:0px;">
  <tr class="bttn"> 
    <td width="16%" class="outset-table" nowrap rowspan="2">区长姓名</td>            
    <td colspan="2" nowrap class="outset-table">收到信件</td>		
    <td class="outset-table" nowrap colspan="2">超时信件</td>
    <td class="outset-table" nowrap colspan="2">是否公开</td> 
  </tr>
  <tr class="bttn">
    <td width="13%" class="outset-table" nowrap align="center">未办理</td> 
    <td width="15%" class="outset-table" nowrap align="center">已办理</td>
    <td width="18%" nowrap class="outset-table">受理超时 </td>
    <td width="16%" nowrap class="outset-table">办理超时</td>
    <td width="7%" nowrap class="outset-table">是 </td>
    <td width="15%" nowrap class="outset-table">否</td>
  </tr>
   <%
  if(vectorPage!=null)
  {
   for(int n=0;n<wd_num;n++)
   {	
	   if(n % 2 == 0)  out.print("<tr class=\"line-even\">");
	   else out.print("<tr class=\"line-odd\">");
%>
  <td><%=wd_namearray[n]%></td>
  <td><a href="AppealList.jsp?type=1&beginTime=<%=begin_time%>&endTime=<%=end_time%>&wd_id=<%=wd_idarray[n]%>&processing=1"><%=wm_notoverpublish[n]%></a></td>  
  <td><a href="AppealList.jsp?type=1&beginTime=<%=begin_time%>&endTime=<%=end_time%>&wd_id=<%=wd_idarray[n]%>&processing=0"><%=wm_overpublish[n]%></a></td>
  <td><a href="AppealList.jsp?type=1&beginTime=<%=begin_time%>&endTime=<%=end_time%>&wd_id=<%=wd_idarray[n]%>&isovertime=1"><%=wm_unsettlednum[n]%></a></td>
  <td><a href="AppealList.jsp?type=1&beginTime=<%=begin_time%>&endTime=<%=end_time%>&wd_id=<%=wd_idarray[n]%>&isovertimem=1"><%=wm_postilnum[n]%></a></td>
   <td><a href="AppealList.jsp?type=1&beginTime=<%=begin_time%>&endTime=<%=end_time%>&wd_id=<%=wd_idarray[n]%>&ispublish=1"><%=wm_ispublish[n]%></a></td>
  <td><a href="AppealList.jsp?type=1&beginTime=<%=begin_time%>&endTime=<%=end_time%>&wd_id=<%=wd_idarray[n]%>&notpublish=0"><%=wm_notpublish[n]%></a></td>
  </tr>
<%
  }
/*分页的页脚模块*/
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