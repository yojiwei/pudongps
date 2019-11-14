<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%
String OPType = "";
String strTitle = "查询列表";
String sqlStr = "";
String cp_id = "";                          //项目名称
String cw_applyPeople = "";                   //申请人
String cp_applyTime = "";                     //项目申请时间
String cp_timeLimit = "";		      //项目时限
String cw_id = "";
String color = "",overTitle="";               //项目超时的时候，设置标志的颜色和title
String applyTime = "";
String finishTime = "";
String status = "";
String statusStr = "";
String beginTime = "";
String endTime = "";
String wd_id = "";
String dt_id = "";
String cw_isovertime = "";
String cw_isovertimem ="";
String cw_ispublish = "";
String cw_notpublish = "" ;
String cw_processing = "";
int do_type = Integer.parseInt(CTools.dealString(request.getParameter("type")).trim());

switch(do_type)
{
	case 1:
		cp_id = "o1";
		break;
	case 2:
		cp_id = "o1";
		break;
	case 3:
		cp_id = "o2";
		break;
	case 4:
		cp_id = "o4";
		break;
	case 5:
		cp_id = "o6";
		break;
	case 6:
		cp_id = "o7";
		break;
	case 7:
		cp_id = "o5";
		break;
	case 8:
		cp_id = "o3";
		break;
	default:
		cp_id = "";
		break;
}

cw_isovertime = CTools.dealString(request.getParameter("isovertime")).trim();
cw_isovertimem = CTools.dealString(request.getParameter("isovertimem")).trim();
cw_ispublish = CTools.dealString(request.getParameter("cw_ispublish")).trim();
cw_notpublish = CTools.dealString(request.getParameter("cw_notpublish")).trim();
cw_processing = CTools.dealString(request.getParameter("processing")).trim();
wd_id = CTools.dealString(request.getParameter("wd_id")).trim();
beginTime = CTools.dealString(request.getParameter("beginTime")).trim();
endTime = CTools.dealString(request.getParameter("endTime")).trim();
dt_id = CTools.dealString(request.getParameter("dt_id")).trim();
//update20080122
CDataCn dCn = null;
CDataImpl dImpl = null;
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn);
%>
<%@include file="/system/app/skin/skin4/template/list_top.jsp"%>
<!--    模块名称开始    -->
<%=strTitle%>
<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/list_function.jsp"%>                                                            
<!--    功能按钮开始    -->
  
<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/list_listtop.jsp"%>                                                                                        
<!--    列表开始    -->
<table class="FindAreaTable1" cellspacing="1" rules="cols" border="0" id="ctl00_DataGrid_DataGrid1" style="border-width:0px;">
<form name="formData" method="post">
<tr width="100%" class="bttn">										
		<td align="center" class="outset-table" width="10%">发送人</td>
		<td align="center" class="outset-table" width="32%">主题</td>
		<td align="center" class="outset-table" width="16%">发送时间</td>
		<td align="center" class="outset-table" width="16%">办理完成时间</td>
		<td align="center" class="outset-table" width="8%">受理超时</td><!-- 提交人 -->
		<td align="center" class="outset-table" width="8%">办理超时</td>	
		<td align="center" class="outset-table" width="10%">操作</td>
	</tr>
<%

if(do_type==1)
{
sqlStr = "select a.cw_status,a.cw_id,a.cp_id,a.cw_isovertime,a.cw_isovertimem,to_char(a.cw_finishtime,'yyyy-mm-dd hh24:mi:ss') cw_finishtime,a.cw_applyingname,a.cw_subject,to_char(a.cw_applytime,'yyyy-mm-dd hh24:mi:ss') cw_applytime,b.cp_name,b.cp_timelimit,c.dt_name ";
sqlStr += "from tb_connwork a,tb_connproc b,tb_deptinfo c,tb_warden d where a.wd_id=d.wd_id and a.wd_id='"+wd_id+"' and ";
}
else
if(do_type==2)
{
sqlStr = "select a.cw_status,a.cw_id,a.cp_id,a.cw_isovertime,a.cw_isovertimem,to_char(a.cw_finishtime,'yyyy-mm-dd hh24:mi:ss') cw_finishtime,a.cw_applyingname,a.cw_subject,to_char(a.cw_applytime,'yyyy-mm-dd hh24:mi:ss') cw_applytime,b.cp_name,b.cp_timelimit,c.dt_name ";
sqlStr += "from tb_connwork a,tb_connproc b,tb_deptinfo c,tb_warden d where a.wd_id=d.wd_id and a.cw_status=1 and ";
}
else
{
sqlStr = "select a.cw_status,a.cw_id,a.cp_id,a.cw_isovertime,a.cw_isovertimem,to_char(a.cw_finishtime,'yyyy-mm-dd hh24:mi:ss') cw_finishtime,a.cw_applyingname,a.cw_subject,to_char(a.cw_applytime,'yyyy-mm-dd hh24:mi:ss') cw_applytime,b.cp_name,b.cp_timelimit,c.dt_name ";
sqlStr += "from tb_connwork a,tb_connproc b,tb_deptinfo c where";
}
sqlStr += " (b.cp_id='"+cp_id+"' or b.cp_upid='"+cp_id+"') and a.cp_id=b.cp_id and b.dt_id=c.dt_id";
if(!dt_id.equals(""))
{
        sqlStr += " and c.dt_id="+dt_id ;
}
if (!beginTime.equals(""))
{
 	if(do_type==2)
	{
	sqlStr += " and a.cw_postiltime > to_date('" + beginTime + " 00:00:00','yyyy-mm-dd hh24:mi:ss') ";
	}
	else
	{
	sqlStr += " and a.cw_applytime > to_date('" + beginTime + " 00:00:00','yyyy-mm-dd hh24:mi:ss') ";
	}
}
if (!endTime.equals(""))
{
	if(do_type==2)
	{
	sqlStr += " and a.cw_postiltime < to_date('" + endTime + " 23:59:59','yyyy-mm-dd hh24:mi:ss')";
	}
	else
	{
	sqlStr += " and a.cw_applytime < to_date('" + endTime + " 23:59:59','yyyy-mm-dd hh24:mi:ss')";
	}
}
if (cw_isovertime.equals("1"))  sqlStr += " and a.cw_isovertime='1' and a.cw_status<>9";
if (cw_isovertimem.equals("1"))  sqlStr += " and a.cw_isovertimem='1' and a.cw_status<>9";
if (cw_ispublish.equals("1"))  sqlStr += " and a.cw_ispublish='1' and a.cw_status<>9";
if (cw_ispublish.equals("0"))  sqlStr += " and a.cw_ispublish<>'1' and a.cw_status<>9";
if (cw_processing.equals("0")) sqlStr += " and a.cw_status = 3"; //已处理信件
if (cw_processing.equals("1")) sqlStr += " and a.cw_status not in(3,9,12)"; //未处理信件

sqlStr += " order by a.cw_status,a.cw_applytime desc";
Vector vPage = dImpl.splitPage(sqlStr,request,20);

if (vPage!=null)
{
	for (int i=0;i<vPage.size();i++)
	{
		Hashtable content = (Hashtable)vPage.get(i);
		int cw_status = Integer.parseInt(content.get("cw_status").toString());
		cw_id = content.get("cw_id").toString();
		cw_isovertime = content.get("cw_isovertime").toString();
		cw_isovertimem = content.get("cw_isovertimem").toString();
	
%>
				<tr width="100%" <%if (i%2==0) out.print("class='line-even'");else out.print("class='line-odd'");%>>
					<td align="center"><%=content.get("cw_applyingname").toString()%>
					</td>
					<td align="center"><a href="FlowInfo.jsp?cw_id=<%=cw_id%>"><%=content.get("cw_subject").toString()%>
					</td>					
					<td align="center"><%
						applyTime = content.get("cw_applytime").toString();
						out.print(applyTime);
					   %></td>
					 <td align="center"><%
						finishTime = content.get("cw_finishtime").toString();
						out.print(finishTime);
					   %></td>
					   <td align="center"><%=cw_isovertime.equals("1")?"<font style='color:red'>是</font>":"否"%></td>
					   <td align="center"><%=cw_isovertimem.equals("1")?"<font style='color:red'>是</font>":"否"%></td>
						<td align="center">
						<span style="cursor:hand" onclick="javascript:window.location='AppealInfo.jsp?cw_id=<%=content.get("cw_id").toString()%>&cw_status=<%=content.get("cw_status").toString()%>'">查 看</span>
						</td>

				</tr>
		<%
	}
}
else
{
	out.print("<tr class='line-even'><td colspan='19'>没有匹配记录</td></tr>");
}
%>
</form>
</table>
<!--    列表结束    -->
<%@include file="/system/app/skin/skin4/template/list_bottom.jsp"%> 
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