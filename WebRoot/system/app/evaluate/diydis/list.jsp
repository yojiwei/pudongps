<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%@page import="com.util.*"%>
<%@page import="Evaluate.*"%>
<%
CDataCn dCn = null;
CDataImpl dImpl = null;
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn);
//
String upperid = "";
String strTitle = "";//抬头标题

//0 暂停 1发布se
String vde_status = "";
String strSQL_info="";
vde_status = "33";

upperid = CTools.dealString(request.getParameter("upperid")).trim();
if(upperid.equals(""))
	upperid = "0";

strTitle = "[选项列表]";
String tempupperid = upperid;

while(!tempupperid.equals("0"))
{
	String sqlStr = "select * from tb_votediy where vt_id= " + tempupperid+"";
	Hashtable content=dImpl.getDataInfo(sqlStr);
	if(!content.get("vt_name").toString().equals(""))
		strTitle = "<a href='"+request.getRequestURL()+"?vde_status="+vde_status+"&upperid="+content.get("vt_id").toString()+"&uppername="+content.get("vt_name").toString()+"&Typepp=1'>" + content.get("vt_name").toString() + "</a> - " + strTitle;
	if(content.get("vt_name").toString().equals(""))
		strTitle = "[<a href='"+request.getRequestURL()+"?vde_status="+vde_status+"&upperid="+content.get("vt_id").toString()+"&uppername="+content.get("vt_name").toString()+"&&Typepp=1'>空</a>] - " + strTitle;
	tempupperid = content.get("vt_upperid").toString();
}
strTitle = "<a href="+request.getRequestURL()+"?upperid=0&vde_status="+vde_status+">投票列表</a> - " + strTitle;

 String Typepp=" ";
 String sqlStr ="";
Typepp = CTools.dealString(request.getParameter("Typepp")).trim();

if(Typepp.equals("1")){//删除后显示
sqlStr = "select * from tb_votediy where vt_upperid = "+upperid+" order by vt_sequence,vt_id desc";
}else{
sqlStr = "SELECT a.vt_id,a.vt_name,a.vt_upperid,a.vt_type,a.vt_frontpagename,a.vt_sort,a.vt_sequence,a.vt_dbname,b.vde_id,b.vde_createtime FROM tb_votediy a,tb_votediyext b WHERE a.vt_id=b.vt_id AND b.vde_status="+vde_status+" AND a.vt_upperid = "+upperid+" order by a.vt_sequence,a.vt_id desc";
}


Vector vPage = dImpl.splitPage(sqlStr,request,200);

%>
<%@include file="/system/app/skin/skin4/template/list_top.jsp"%>
<!--    模块名称开始    -->
<%=strTitle%>
<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/list_function.jsp"%>                                                            
<!--    功能按钮开始    -->

<%
String upupperid = "0";
String tempupperid_showvote = upperid;
String tempid_showvote = "";
int n = 0;
while(!tempupperid_showvote.equals("0"))
{
	String sqlStr_showvote = "select * from tb_votediy where vt_id= " + tempupperid_showvote +"";

	Hashtable content_showvote=dImpl.getDataInfo(sqlStr_showvote);
	tempid_showvote = content_showvote.get("vt_id").toString();
	tempupperid_showvote = content_showvote.get("vt_upperid").toString();
	if(n == 1)
		upupperid = content_showvote.get("vt_id").toString();
		n++;
}
if(!tempid_showvote.equals(""))
{
String upurl = "list.jsp?upperid="+upupperid+"&&Typepp="+Typepp+"&vde_status="+vde_status;
if ("0".equals(upupperid)) {
	upurl = "list.jsp?Menu=政风行风测评&Module=浏览";
}
%>
<a href="<%=upurl%>">
<img src="../../../images/up.gif" border="0" title="上一级" align="absmiddle">
</a>
上一级
<%}%>
<a href="info.jsp?OType=Add&upperid=<%=upperid%>&vde_status=<%=vde_status%>">
<img src="../../../images/new.gif" border="0" title="新建" align="absmiddle"></a>
新建
<img src="../../../images/dialog/sort.gif" border="0" onclick="setSequence()" title="修改排序" style="cursor:hand" align="absmiddle" WIDTH="15" HEIGHT="15">
修改排序
<img src="../../../images/goback.gif" border="0" onclick="javascript:history.back();" title="返回" style="cursor:hand" align="absmiddle">
返回    
<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/list_listtop.jsp"%>                                                                                        
<!--    列表开始    -->
<form action="" method="post" name="formData">
<table class="FindAreaTable1" cellspacing="1" rules="cols" border="0" id="ctl00_DataGrid_DataGrid1" style="border-width:0px;">
<%
out.print("<tr class='bttn'>");
out.print("<td width='5%'>ID</td>");
out.print("<td width='53%'>名称</td>");
if(!upperid.equals("0")) out.print("<td width='16%'>类型</td>");
if(!upperid.equals("0")) out.print("<td width='8%'>表单名称</td>");
if(upperid.equals("0")) out.print("<td width='8%'>详细记录</td>");
if(upperid.equals("0")) out.print("<td width='8%'>统计分析</td>");
out.print("<td width='5%'>修改</td>");
out.print("<td width='5%'>排序</td>");
out.print("<td width='5%'>删除</td>");
out.print("</tr>");
int linenum = 0;

if(vPage != null)
{
	for(int i=0;i<vPage.size();i++)
	{
		Hashtable content = (Hashtable)vPage.get(i);

		if(linenum%2==0)
			out.print("<tr class='line-odd' align='center'>");
		else
			out.print("<tr class='line-even' align='center'>");
		linenum ++;
		
		out.print("<td>"+content.get("vt_id").toString()+"</td>");
		if(!content.get("vt_name").toString().equals("")) {
				out.print("<td align='left'><a href='"+request.getRequestURL()+"?vde_status="+vde_status+"&upperid="+content.get("vt_id").toString()+"&Typepp=1'>"+content.get("vt_name").toString()+"</a></td>");
		}else{
				out.print("<td align='left'>[<a href='"+request.getRequestURL()+"?upperid="+content.get("vt_id").toString()+"'>空</a>]</td>");
		}
		if(!upperid.equals("0"))
		{
			if(content.get("vt_type").toString().equals("title"))
				out.print("<td>标题</td>");
			if(content.get("vt_type").toString().equals("radio"))
				out.print("<td>单选框</td>");
			if(content.get("vt_type").toString().equals("checkbox"))
				out.print("<td>复选框</td>");
			if(content.get("vt_type").toString().equals("text"))
				out.print("<td>输入框</td>");
			if(content.get("vt_type").toString().equals("textarea"))
				out.print("<td>多行文本输入框</td>");
		}
		if(!upperid.equals("0"))
			out.print("<td>"+content.get("vt_frontpagename").toString()+"</td>");
		if(upperid.equals("0")){
			out.print("<td><a href='detailList.jsp?id=" + content.get("vt_id").toString() + "&vt_sort=" + content.get("vt_sort") + "'>详细记录</a></td>");
			out.print("<td><a href='totalList.jsp?id=" + content.get("vt_id").toString() + "&vt_sort=" + content.get("vt_sort") + "'>统计分析</a></td>");
		}
		if(upperid.equals("0"))
		{
			String sqlStr_votetable = "select * from sys.all_all_tables where owner = 'PUDONG' and table_name='TB_VOTEDIY"+content.get("vt_id").toString()+"'";
			Vector vPage_votetable = dImpl.splitPage(sqlStr_votetable,request,10000);
			if(vPage_votetable!=null)
			{
				out.print("<td>tb_votediy"+content.get("vt_id").toString()+"</td>");
			}
		}
		if(!upperid.equals("0")){
		out.print("<td align='center'><a href='info.jsp?upperid="+upperid+"&editid="+content.get("vt_id").toString()+"&OType=Edit&vde_status="+vde_status+"&Typepp=2'><img src='../../../images/modi.gif' border='0' title='修改'></a></td>");
		}else{
		out.print("<td align='center'><a href='info.jsp?upperid="+upperid+"&editid="+content.get("vt_id").toString()+"&OType=Edit&vde_status="+vde_status+"&Typepp=3'><img src='../../../images/modi.gif' border='0' title='修改'></a></td>");
		}
		out.print("<td align='center'><input type=text class=text-line name="+"module"+content.get("vt_id").toString()+" value='"+content.get("vt_sequence").toString()+"' size=4></td>");
		out.print("<td align='center'><a href='dell.jsp?upperid="+upperid+"&editid="+content.get("vt_id").toString()+"&OType=Edit&vde_status="+vde_status+"&Typepp="+Typepp+"'><img src='../../../images/delete.gif' border='0' title='删除'></a></td>");
		out.print("</tr>");
	}
}
if(linenum==0)
{
	out.print("<tr><td colspan='19'><font color='#aaaaaa'>此项目下无内容</font></td></tr>");
}
%>
</table>
</form>
<SCRIPT LANGUAGE=javascript>
<!--
function setSequence()
{
	formData.action ="setSequence.jsp?upperid=<%=upperid%>&vde_status=<%=vde_status%>&Typepp=1";
	formData.submit();
}
//-->
</SCRIPT>
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