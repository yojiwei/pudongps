<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%
//
String cs_id="";
String cw_id = "";
String cs_satis="";
String cs_message="";
String cs_date = "";
String us_name = "";
String ac_type = "";
String caf_type = "";
String cw_subject = "";
String ac_typename = "";
String cw_status = "";
String cp_name = "";
String begintime = "";
String endtime = "";
String mailtype = "";

CDataCn dCn = null;
CDataImpl dImpl = null;
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn);
//
ac_type = CTools.dealString(request.getParameter("ac_type"));
caf_type = CTools.dealString(request.getParameter("caf_type"));
begintime = CTools.dealString(request.getParameter("beginTime"));
endtime = CTools.dealString(request.getParameter("endTime"));
mailtype = CTools.dealString(request.getParameter("mailtype")).trim();

//update by dongliang 20090106
String curpage= CTools.dealString(request.getParameter("curpage"));
//
String sql_list = " select c.cs_id,c."+caf_type+" as ac_type,c.cs_message,c.cs_date,u.us_name,k.cw_subject,k.cw_status,c.cw_id,p.cp_name　from tb_connsatisfied c,tb_user u,tb_connwork k ,tb_connproc p where c.us_id = u.us_id(+) and c.cw_id = k.cw_id and k.cp_id = p.cp_id(+) ";
if(!"".equals(ac_type)&&"cs_satis".equals(caf_type)){
	sql_list+=" and c.cs_satis='"+ac_type+"'";
}
if(!"".equals(ac_type)&&"cs_timesatis".equals(caf_type)){
	sql_list+=" and c.cs_timesatis='"+ac_type+"'";
}
if(!"".equals(ac_type)&&"cs_resultsatis".equals(caf_type)){
	sql_list+=" and c.cs_resultsatis='"+ac_type+"'";
}
if(!"".equals(begintime)){
	sql_list += " and c.cs_date > to_date('"+begintime+"','yyyy-MM-dd')";
}
if(!"".equals(endtime)){
	sql_list += " and c.cs_date < to_date('"+endtime+"','yyyy-MM-dd')";
}

if(!"".equals(mailtype)){
	if("mailWSZX".equals(mailtype)){
		sql_list += " and k.cp_id in(select c.cp_id from tb_connproc c,tb_deptinfo d where c.cp_id <> 'o11893' and c.cp_id <> 'o11890' and c.cp_id <> 'o11835' and c.dt_id=d.dt_id and (c.cp_upid='o7' or c.cp_upid = 'o10000'))";
	}else{
		sql_list += " and k.cp_id = '"+mailtype+"'";
	}
}
sql_list += " order by c.cs_id desc";


//out.println(sql_list);

%>
<%@include file="/system/app/skin/skin4/template/list_top.jsp"%>
<!--    模块名称开始    -->
用户满意度调查列表
<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/list_function.jsp"%>                                                            
<!--    功能按钮开始    -->
<a href="voteSee.jsp"><font color='white'>满意度统计</font></a>

<img src="../images/dialog/goback.gif" border="0" onclick="javascript:history.back();" title="返回" style="cursor:hand" align="absmiddle">
返回 
<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/list_listtop.jsp"%>                                                                                        
<!--    列表开始    -->
<table class="FindAreaTable1" cellspacing="1" rules="cols" border="0" id="ctl00_DataGrid_DataGrid1" style="border-width:0px;">
	<form name="formData">
	</tr>
	<tr class="bttn">
	<td width="15%" class="outset-table" align="center">姓名</td>
	<td width="35%" class="outset-table" align="center">咨询</td>
	<td width="15%" class="outset-table" align="center">办理单位</td>
	<td width="15%" class="outset-table" align="center">满意度</td>
	<td width="20%" class="outset-table" align="center">日期</td>
	<td width="5%" class="outset-table" align="center">操作</td>
	</tr>
	<%
	Vector vectorList = dImpl.splitPage(sql_list,request,20);
	Hashtable content = null;
	if(vectorList!=null)
	{
		for(int i=0;i<vectorList.size();i++)
		{
			content = (Hashtable)vectorList.get(i);
			cs_id = CTools.dealNull(content.get("cs_id"));
			ac_type = CTools.dealNull(content.get("ac_type"));
			cs_message = CTools.dealNull(content.get("cs_message"));
			us_name = CTools.dealNull(content.get("us_name"));
			cw_subject = CTools.dealNull(content.get("cw_subject"));
			cw_id = CTools.dealNull(content.get("cw_id"));
			cw_status = CTools.dealNull(content.get("cw_status"));
			cs_date = CTools.dealNull(content.get("cs_date"));
				cp_name = CTools.dealNull(content.get("cp_name"));
			
			if(ac_type.equals("1")){
				ac_typename = "满意";
			}else if(ac_type.equals("2")){
				ac_typename = "基本满意";
			}else if(ac_type.equals("3")){
				ac_typename = "不满意";
			}else{
				ac_typename = "无";	
			}
			if(i % 2 == 0)  out.print("<tr class=\"line-even\">");
			else out.print("<tr class=\"line-odd\">");
	%>
	<td align="center"><%="".equals(us_name)?"匿名":us_name%></td>
	<td align="left"><%=cw_subject%></td>
	<td align="center"><%=cp_name%></td>
	<td align="center"><%=ac_typename%></td>
	<td align="left"><%=cs_date%></td>
<td align="center">
<a href="SatisfiedInfo.jsp?OPType=Edit&cw_id=<%=cw_id%>&cw_status=<%=cw_status%>"><img class="hand" border="0" src="../images/dialog/modi.gif" title="查看详细" WIDTH="16" HEIGHT="16"></a>&nbsp;
<a href="SatisfiedDel.jsp?OPType=Del&cs_id=<%=cs_id%>"><img class="hand" border="0" src="../images/dialog/delete.gif" title="删除" WIDTH="16" HEIGHT="16" onClick="return window.confirm('确认要删除该记录么?');"></a>
</td>
</tr>
</form>
<%
    }
  }
  else
  {
    out.println("<tr><td colspan=20>没有记录！</td></tr>");
  }
%>
</table>
<!--    列表结束    -->
<%@include file="/system/app/skin/skin4/template/list_bottom.jsp"%> 
<%
}
catch(Exception e){
	System.out.println(new java.util.Date() + "--"
			+ request.getServletPath() + " : " + e.getMessage());
}
finally{
	dImpl.closeStmt();
	dCn.closeCn(); 
}
%>
<%@include file="/system/app/skin/bottom.jsp"%>