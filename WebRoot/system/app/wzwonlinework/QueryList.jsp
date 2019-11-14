<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/import.jsp"%>
<%@include file="/system/app/skin/head.jsp"%>
<%
String OPType = "";
String strTitle = "查询列表";
String dtId = "";
String recivieid = "";
String sqlStr = "";
String cp_name = "";                          //项目名称
String person = "";                   //经办人
String depat = "";
String cp_applyTime = "";                     //项目申请时间
String cp_timeLimit = "";		      //项目时限
String cp_tasks = "项目办理";
String beginTime = "";
String endTime = "";
String [] statuSet ;
String cw_applyPeople = "";
String status = "";
Vector vPage = null;
Hashtable content = null;

cw_applyPeople = CTools.dealString(request.getParameter("person")).trim();
beginTime = CTools.dealString(request.getParameter("beginTime")).trim();
endTime = CTools.dealString(request.getParameter("endTime")).trim();
cp_name = CTools.dealString(request.getParameter("cp_name")).trim();
recivieid = CTools.dealString(request.getParameter("reciveid")).trim();
depat = CTools.dealString(request.getParameter("depat")).trim();
String statuSet1 ="'"+ CTools.dealString(request.getParameter("status1")).trim()+"','"+CTools.dealString(request.getParameter("status2")).trim()+"','"+CTools.dealString(request.getParameter("status3")).trim()+"'";
//out.print("statuSet1"+statuSet1);
statuSet = request.getParameterValues("status");

if (statuSet!=null)
{
	status = "";
	for(int i=0;i<statuSet.length;i++)
	{
		status += statuSet[i]+"'";
		status += ",";
	}
	status = status.substring(0,status.length()-1);
}
CDataCn dCn = null;
CDataImpl dImpl = null;
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn);

sqlStr = "select a.wz_id,a.wz_reciveid,to_char(to_date(a.wz_applydate,'YYYY-MM-DD'),'YYYY-MM-DD')wz_applydate,a.wz_subjecttname,a.wz_dealdepat,a.wz_dealperson,a.wz_dealstatus,a.wz_feedback from tb_wzwolinework a where a.wz_dealstatus in(" +statuSet1+ ")";
//out.print(sqlStr);
//if(true) return;
if(!recivieid.equals(""))
{
	sqlStr += " and  a.wz_reciveid like '%"+recivieid+"%'";
}
//if(!depat.equals(""))
//{
//	sqlStr += " and a.wz_dealdepat like '%"+depat+"%'";
//}
if(!cp_name.equals(""))
{
	sqlStr += "  and a.wz_subjecttname like '%"+cp_name+"%'";
}
if(!cw_applyPeople.equals(""))
{
	sqlStr += " and a.wz_dealperson like '%"+cw_applyPeople+"%'";
}
 
if (!beginTime.equals(""))
{
 	sqlStr += " and a.wz_applydate > to_date('" + beginTime + " 00:00:00','yyyy-mm-dd hh24:mi:ss') ";
}
if (!endTime.equals(""))
{
	sqlStr += " and a.wz_applydate < to_date('" + endTime + " 23:59:59','yyyy-mm-dd hh24:mi:ss')";
}


sqlStr += " order by to_date(a.wz_applydate,'YYYY-MM-DD') desc,a.wz_applydate desc";
vPage = dImpl.splitPage(sqlStr,request,20);
%>
<%@include file="/system/app/skin/skin4/template/list_top.jsp"%>
<!--    模块名称开始    -->
<%=strTitle%>
<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/list_function.jsp"%>                                                            
<!--    功能按钮开始    -->
<%int n = 0;%>
<img src="../../images/goback.gif" border="0" onclick="javascript:history.back();" title="返回" style="cursor:hand" align="absmiddle">返回
<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/list_listtop.jsp"%>                                                                                        
<!--    列表开始    -->
 <table class="FindAreaTable1" cellspacing="1" rules="cols" border="0" id="ctl00_DataGrid_DataGrid1" style="border-width:0px;">

<%
out.print("<tr class='bttn'>");
out.print("<td width='8%'>收文号</td>");
out.print("<td width='10%'>申报日期</td>");
 out.print("<td width='15%'>项目名称</td>");
// out.print("<td width='8%'>经办处室</td>");
 out.print("<td width='7%'>经办人</td>");
out.print("<td width='8%'>办理状态</td>");
out.print("<td width='20%'>问题留言</td>");
out.print("<td width='7%'>编辑</td>");
out.print("</tr>");
int linenum = 0;
if(vPage != null)
{
	for(int i=0;i<vPage.size();i++)
	{
	 content = (Hashtable)vPage.get(i);
		String wz_id = content.get("wz_id").toString();
		String wz_reciveid = content.get("wz_reciveid").toString();
		String wz_applydate = content.get("wz_applydate").toString();
		String wz_subjecttname = content.get("wz_subjecttname").toString();
		String wz_dealdepat = content.get("wz_dealdepat").toString();
		String wz_dealperson = content.get("wz_dealperson").toString();
		String wz_dealstatus = content.get("wz_dealstatus").toString();
		String wz_feedback = content.get("wz_feedback").toString();

		if(linenum%2==0)
			out.print("<tr class='line-odd' align='center'>");

		else
			out.print("<tr class='line-even' align='center'>");
		linenum ++;
        out.print("<td align='center'>"+content.get("wz_reciveid").toString()+"</td>");
		out.print("<td align='center'>"+wz_applydate+"</a></td>");
		out.print("<td align='center' title='"+wz_subjecttname+"'>"+CWebTools.sperateFontColor("0",wz_subjecttname,8)+"</td>");
		//out.print("<td align='center'>"+wz_dealdepat+"</td>");
		out.print("<td align='center'>"+wz_dealperson+"</td>");
		out.print("<td align='center'>"+wz_dealstatus+"</td>");
		out.print("<td align='center'title='"+wz_feedback+"'>"+CWebTools.sperateFontColor("0",wz_feedback,10)+"</td>");
		out.print("<td align='center'><a href='addinfo.jsp?wz_id="+content.get("wz_id").toString()+"&OType=Edit'><img src='../../images/modi.gif' border='0' title='修改'></a>   <img class='hand' border='0' src='../../images/delete.gif' title='删除' onclick=\"delinfo('"+content.get("wz_id").toString()+"')\"></td></tr>");
		}
	
}
if(linenum==0)
{
	out.print("<tr><td colspan='9'><font color='#aaaaaa'>此项目下无内容</font></td></tr>");
}
%>
</table>


<SCRIPT LANGUAGE=javascript>
<!--
function setSequence()
{
	PageForm.action = "";
	PageForm.submit();
}
function back()
{
	window.location="list.jsp";
}
//-->
function delinfo(wz_id){
if(confirm("确实要删除吗？"))
	  {
			window.location.href = "del.jsp?wz_id="+wz_id;
	  }
}
</script>
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