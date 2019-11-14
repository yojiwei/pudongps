<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%
String strTitle = "政务公开统计结果";
String sqlStr = "";
String dt_id = "";
String dt_name = "";
String lawNum = ""; //法律法规数
String dynNum = ""; //部门动态数
String modFengongDate = ""; //领导分工修改时间
String modZhiNengDate = ""; //基层单位职能修改时间
String modDiagramDate = ""; //组织机构图修改时间
String modPhotoDate = "";   //部门照片修改时间

//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 
String beginDate = CTools.dealString(request.getParameter("beginDate")).trim();
String endDate = CTools.dealString(request.getParameter("endDate")).trim();
%>
<table class="main-table" width="100%">
<form name="formData">
	<tr class="title1">
		<td colspan="9" align="left">&nbsp;&nbsp;<%=strTitle%>(<%=beginDate%>至<%=endDate%>)</td>
	</tr>
	<%
	if (!endDate.equals(""))
	{
		endDate += " 23:59:59";
	}
	else
	{
		endDate = new CDate().getThisday() + " 23:59:59";
	}
	if (!beginDate.equals(""))
	{
		beginDate += " 00:00:00";
	}
	%>
	<tr class="bttn">
		<td class="outset-table" align="center">部门名称</td>
		<td class="outset-table" align="center">部门动态数</td>
		<td class="outset-table" align="center">法律法规数</td>
		<td class="outset-table" align="center">部门相片修改</td>
		<td class="outset-table" align="center">领导分工修改</td>
		<td class="outset-table" align="center">部门职能修改</td>
		<td class="outset-table" align="center">部门动态修改</td>
	</tr>
<%
sqlStr = "select dt_id, dt_name from tb_deptinfo where dt_id in (select dt_id from jk_govopen) order by dt_sequence";
Vector deptVec = dImpl.splitPage(sqlStr,200,1);
//out.print(deptVec.size());
if (deptVec!=null)
{
	for (int i=0;i<deptVec.size();i++)
	{
		Hashtable dContent = (Hashtable)deptVec.get(i);
		dt_name = dContent.get("dt_name").toString();
		dt_id = dContent.get("dt_id").toString();
		//获得法律法规数
		sqlStr = "select count(ct_id) num from tb_content where sj_id in (select sj_id from tb_subject where sj_parentid in (select sj_id from tb_subject where sj_dir in ('countryLaw','shanghaiLaw','xuhuiLaw'))) and  ct_create_time<'"+endDate+"' and dt_id="+dt_id;
		if (!beginDate.equals(""))
		{
			sqlStr  += " and ct_create_time>'"+beginDate+"'" ;
		}
		Hashtable lawContent = dImpl.getDataInfo(sqlStr);
		lawNum = lawContent.get("num").toString();
		//获得部门动态数
		sqlStr = "select count(ct_id) num from tb_content where sj_id in (select sj_id from tb_subject where sj_devide='dongtai' and sj_parentid in (select sj_id from tb_subjectlinkdept where dt_id="+dt_id+")) and  to_date(ct_create_time || ' 00:00:00','yyyy-mm-dd hh24:mi:ss')<=to_date('"+endDate+"','yyyy-mm-dd hh24:mi:ss')";
		//if (dt_id.equals("135")) out.print(sqlStr);
		if (!beginDate.equals(""))
		{
			sqlStr  += " and to_date(ct_create_time || ' 00:00:00','yyyy-mm-dd hh24:mi:ss')>=to_date('"+beginDate+"','yyyy-mm-dd hh24:mi:ss')" ;
		}
		Hashtable dynContent = dImpl.getDataInfo(sqlStr);
		dynNum = dynContent.get("num").toString();
		//获得更新时间（部门组织结构图，部门照片，领导分工，基层单位职能）
		sqlStr = "select go_modphotodate,go_modworkdate,go_moddiagramdate,go_modperformdate from jk_govopen where dt_id=" + dt_id;
		if(dt_id.equals("135")) out.print(sqlStr);
		Hashtable jkContent = dImpl.getDataInfo(sqlStr);
		if (jkContent!=null)
		{
			modPhotoDate = jkContent.get("go_modphotodate").toString();
			modFengongDate = jkContent.get("go_modworkdate").toString();
			modDiagramDate = jkContent.get("go_moddiagramdate").toString();
			modZhiNengDate = jkContent.get("go_modperformdate").toString();
		}
		%>
		<tr class="<%if (i%2==0) out.print("line-even");else out.print("line-odd");%>">
			<td><%=dt_name%></td>
			<td><%=dynNum%></td>
			<td><%=lawNum%></td>
			<td>
				<%
				if (modPhotoDate.compareTo(beginDate)>=0&&modPhotoDate.compareTo(endDate)<=0)
				{
					out.print(modPhotoDate);
				}	
				else
				{
					out.print("没有修改");
				}
				%>
			</td>
			<td>
				<%
				if (modFengongDate.compareTo(beginDate)>=0&&modFengongDate.compareTo(endDate)<=0)
				{
					out.print(modFengongDate);
				}	
				else
				{
					out.print("没有修改");
				}
				%>
			</td>
			<td>
				<%
				if (modZhiNengDate.compareTo(beginDate)>=0&&modZhiNengDate.compareTo(endDate)<=0)
				{
					out.print(modZhiNengDate);
				}	
				else
				{
					out.print("没有修改");
				}
				%>
			</td>
			<td>
				<%
				if (modDiagramDate.compareTo(beginDate)>=0&&modDiagramDate.compareTo(endDate)<=0)
				{
					out.print(modDiagramDate);
				}	
				else
				{
					out.print("没有修改");
				}
				%>
			</td>
		</tr>
		<%
	}
}
%>
</form>
</table>
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