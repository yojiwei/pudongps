<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%@page import="com.util.*"%>
<%@page import="Evaluate.*"%>
<%
CDataCn dCn = new CDataCn();
CDataImpl dImpl = new CDataImpl(dCn);
String upperid = "";
String strTitle = "";//抬头标题

//0 暂停 1发布
String vde_status = "";
vde_status = CTools.dealString(request.getParameter("vde_status")).trim();
if(vde_status.equals("")) {vde_status = "1";}



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






 String Typepp="";
 String sqlStr ="";
Typepp = CTools.dealString(request.getParameter("Typepp")).trim();
if(Typepp.equals("1")){
sqlStr = "select * from tb_votediy where vt_upperid = "+upperid+" order by vt_sequence";
}else{
sqlStr = "SELECT * FROM tb_votediy a,tb_votediyext b WHERE a.vt_id=b.vt_id AND b.vde_status="+vde_status+" AND vt_upperid = "+upperid+" order by vt_sequence";
}
Vector vPage = dImpl.splitPage(sqlStr,request,10000);
%>
<form action="" method="post" name="PageForm">
 <table class="main-table" width="100%">
 <tr>
  <td width="100%">
       <table class="content-table" width="100%">
                <tr class="title1">
                        <td colspan="8" align="center">
                                <table WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="1">
                                        <tr>
                                                <td valign="center"><%=strTitle%></td>
                                                <td valign="center" align="right" nowrap>
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
													n ++;
												}
												if(!tempid_showvote.equals(""))
												{												
												%>
														<img src="../../../images/split.gif" align="middle" border="0" WIDTH="5" HEIGHT="8">
														<a href="list.jsp?upperid=<%=upupperid%>&&Typepp=1&vde_status=<%=vde_status%>"><img src="../../../images/up.gif" border="0" title="上一级" align="absmiddle"></a>
														<img src="../../../images/split.gif" align="middle" border="0" WIDTH="5" HEIGHT="8">
														<a href="listtree.jsp?treeid=<%=tempid_showvote%>">树状视图</a>
													<%}%>
														<img src="../../../images/split.gif" align="middle" border="0" WIDTH="5" HEIGHT="8">
														<a href="info.jsp?OType=Add&upperid=<%=upperid%>&vde_status=<%=vde_status%>"><img src="../../../images/new.gif" border="0" title="新建" align="absmiddle"></a>
														<img src="../../../images/split.gif" align="middle" border="0" WIDTH="5" HEIGHT="8">
														<img src="../../images/split.gif" align="middle" border="0" WIDTH="5" HEIGHT="8"><img src="../../../images/dialog/sort.gif" border="0" onclick="setSequence()" title="修改排序" style="cursor:hand" align="absmiddle" WIDTH="15" HEIGHT="15">
														<img src="../../../images/split.gif" align="middle" border="0" WIDTH="5" HEIGHT="8">
														<img src="../../../images/goback.gif" border="0" onclick="javascript:history.back();" title="返回" style="cursor:hand" align="absmiddle">
														<img src="../../../images/split.gif" align="middle" border="0" WIDTH="5" HEIGHT="8">
                                                </td>
                                        </tr>
                                </table>
                        </td>
                </tr>
<%
out.print("<tr class='bttn'>");
out.print("<td width='5%'>ID</td>");
out.print("<td width='53%'>名称</td>");
if(upperid.equals("0")) out.print("<td width='8%'>树状视图</td>");
if(!upperid.equals("0")) out.print("<td width='16%'>类型</td>");		  
if(!upperid.equals("0")) out.print("<td width='16%'>表单名称</td>");
if(upperid.equals("0")) out.print("<td width='8%'>投票页面</td>");
if(upperid.equals("0")) out.print("<td width='8%'>统计页面</td>");
if(upperid.equals("0")) out.print("<td width='8%'>数据表</td>");
out.print("<td width='5%'>修改</td>");
out.print("<td width='5%'>排序</td>");
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
		if(!content.get("vt_name").toString().equals(""))
			out.print("<td align='left'><a href='"+request.getRequestURL()+"?vde_status="+vde_status+"&upperid="+content.get("vt_id").toString()+"&Typepp=1'>"+content.get("vt_name").toString()+"</a></td>");
		else
			out.print("<td align='left'>[<a href='"+request.getRequestURL()+"?upperid="+content.get("vt_id").toString()+"'>空</a>]</td>");
		if(upperid.equals("0")) 
			out.print("<td align='center'><a href='listtree.jsp?treeid="+content.get("vt_id").toString()+"'>树状视图</a></td>");
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
		if(upperid.equals("0"))
			out.print("<td><a href='/website/evaluate/diy/vote.jsp?id="+content.get("vt_id").toString()+"' target='_black'>投票页面</a></td>");
		if(upperid.equals("0"))
			out.print("<td><a href='votestat.jsp?id="+content.get("vt_id").toString()+"'>统计页面</a></td>");
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
		out.print("</tr>");
	}
}
if(linenum==0)
{
	out.print("<tr><td colspan='9'><font color='#aaaaaa'>此项目下无内容</font></td></tr>");
}
%>
</table>
  </td>
</tr>
</table>
<%
if(!tempid_showvote.equals(""))
{
	%>
	<table><tr><td>
	<%
	out.print("<a href='/website/evaluate/diy/vote.jsp?id="+tempid_showvote+"' target='_black'>投票页面</a> ");
	out.print("<a href='votestat.jsp?id="+tempid_showvote+"'>统计页面</a>");
	%>
	</td></tr></table>
	<%
}
%>
</form>
<%
dImpl.closeStmt();
dCn.closeCn();
%>
<SCRIPT LANGUAGE=javascript>
<!--
function setSequence()
{
	PageForm.action = "setSequence.jsp?upperid=<%=upperid%>&vde_status=<%=vde_status%>&Typepp=1";
	PageForm.submit();
}
//-->
</SCRIPT>
<%@include file="/system/app/skin/bottom.jsp"%>
