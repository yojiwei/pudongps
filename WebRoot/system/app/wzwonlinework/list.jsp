<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/import.jsp"%>
<%@page import="com.util.*"%>
<%@page import="Evaluate.*"%>
<%@include file="/system/app/skin/head.jsp"%>
<%
CDataCn dCn = null;
CDataImpl dImpl = null;
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn);

String wz_id = "";
String strTitle = "";//抬头标题


Vector vPage = null;
Hashtable content = null;
Vector newvPage = null;
Hashtable newcontent = null;

//0 暂停 1发布se
String vde_status = "";

String strSQL_info="";
//vde_status = CTools.dealString(request.getParameter("vde_status")).trim();
//if(vde_status.equals("")) {vde_status = "33";}
vde_status = "33";

 String Typepp="";
 String sqlStr ="";

strTitle = "[选项列表]";
 sqlStr = "select wz_id,wz_reciveid,to_char(to_date(wz_applydate,'YYYY-MM-DD'),'YYYY-MM-DD')wz_applydate,wz_subjecttname,wz_dealdepat,wz_dealperson,wz_dealstatus,wz_feedback from tb_wzwolinework order by to_date(wz_applydate,'YYYY-MM-DD') desc,wz_id desc";
 vPage = dImpl.splitPage(sqlStr,request,20);

%>
<%@include file="/system/app/skin/skin4/template/list_top.jsp"%>
<!--    模块名称开始    -->
<%=strTitle%>
<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/list_function.jsp"%>                                                            
<!--    功能按钮开始    -->
<%int n = 0;%>
<a href="addinfo.jsp"><img src="../../images/new.gif" border="0" title="新建" align="absmiddle"></a>新建
<a href="AppealQuery.jsp"><img src="../../images/menu_about.gif" border="0" title="查询" align="absmiddle"></a>查询
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
 out.print("<td width='8%'>经办人</td>");
out.print("<td width='8%'>办理状态</td>");
out.print("<td width='18%'>问题留言</td>");
out.print("<td width='8%'>编辑</td>");
out.print("</tr>");
int linenum = 0;
if(vPage != null)
{
	for(int i=0;i<vPage.size();i++)
	{
	 content = (Hashtable)vPage.get(i);
		 wz_id = content.get("wz_id").toString();
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
		out.print("<td align='center'title='"+wz_feedback+"'>"+CWebTools.sperateFontColor("0",wz_feedback,9)+"</td>");
		out.print("<td align='center'><a href='addinfo.jsp?wz_id="+content.get("wz_id").toString()+"&OType=Edit'><img src='../../images/modi.gif' border='0' title='修改'></a>   <img class='hand' border='0' src='../../images/delete.gif' title='删除' onclick=\"delinfo('"+content.get("wz_id").toString()+"')\"></td></tr>");
		}
	
}
   //out.println("<tr><td colspan=9>" + dImpl.getTail(request) + "</td></tr>"); 
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