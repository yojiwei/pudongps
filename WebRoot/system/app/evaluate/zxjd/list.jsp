<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%@page import="com.util.*"%>
<%@page import="Evaluate.*"%>
<%
//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 
String jd_id = "";
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

jd_id = CTools.dealString(request.getParameter("jd_id")).trim();
if("".equals(jd_id)){

 String Typepp="";
 String sqlStr ="";

strTitle = "[选项列表]";
 sqlStr = "select * from tb_onlinesubject order by jd_id desc";
 vPage = dImpl.splitPage(sqlStr,request,10000);
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
											
										
												int n = 0;%>
								
														<img src="../../../images/split.gif" align="middle" border="0" WIDTH="5" HEIGHT="8">
														<a href="addinfo.jsp"><img src="../../../images/new.gif" border="0" title="新建" align="absmiddle"></a>
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
out.print("<td width='30%'>在线接待标题</td>");
 out.print("<td width='10%'>接待日期</td>");
 out.print("<td width='15%'>接待单位</td>");
 out.print("<td width='20%'>接待地点</td>");
out.print("<td width='10%'>接待人职务</td>");
out.print("<td width='5%'>修改</td>");
out.print("</tr>");
int linenum = 0;
if(vPage != null)
{
	for(int i=0;i<vPage.size();i++)
	{
	 content = (Hashtable)vPage.get(i);
		 jd_id = content.get("jd_id").toString();
		String jd_subject = content.get("jd_subject").toString();
		String jd_date = content.get("jd_date").toString();
		String jd_duty = content.get("jd_duty").toString();
		String jd_address = content.get("jd_address").toString();
		String jd_depart = content.get("jd_depart").toString();

		if(linenum%2==0)
			out.print("<tr class='line-odd' align='center'>");

		else
			out.print("<tr class='line-even' align='center'>");
		linenum ++;
        out.print("<td align='center'>"+content.get("jd_id").toString()+"</td>");
		out.print("<td align='center'><a href='list.jsp?jd_id="+jd_id+"&jd_subject="+jd_subject+"'>"+jd_subject+"</a></td>");
		out.print("<td align='center'>"+jd_date+"</td>");
		out.print("<td align='center'>"+jd_depart+"</td>");

		out.print("<td align='center'>"+jd_address+"</td>");
		out.print("<td align='center'>"+jd_duty+"</td>");
		out.print("<td align='center'><a href='addinfo.jsp?jd_id="+content.get("jd_id").toString()+"&OType=Edit'><img src='../../../images/modi.gif' border='0' title='修改'></a></td></tr>");
		}
	
}
   out.println("<tr><td colspan=9>" + dImpl.getTail(request) + "</td></tr>"); 
if(linenum==0)
{
	out.print("<tr><td colspan='9'><font color='#aaaaaa'>此项目下无内容</font></td></tr>");
}
%>
</table>
  </td>
</tr>
</table>
</form>
<%}else{%><%
 String Typepp="";
 String sqlStr ="";
 String  jd_subject = CTools.dealString(request.getParameter("jd_subject")).trim();
strTitle = jd_subject+"[用户问题列表]";
 sqlStr = "select to_char(wt_senddate,'yyyy-mm-dd hh24:mi:ss') wt_senddate,to_char(wt_solvedate,'yyyy-mm-dd hh24:mi:ss') wt_solvedate,wt_id,wt_question, cw_applyname ,jd_id from tb_onlinewt where jd_id='"+jd_id+"' order by jd_id";
 newvPage = dImpl.splitPage(sqlStr,request,10000);
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
									
												int n = 0;%>
								
														<img src="../../../images/split.gif" align="middle" border="0" WIDTH="5" HEIGHT="8">
														<img src="../../../images/goback.gif" border="0" onclick="javascript:back()" title="返回" style="cursor:hand" align="absmiddle">
														<img src="../../../images/split.gif" align="middle" border="0" WIDTH="5" HEIGHT="8">
                                                </td>
                                        </tr>
                                </table>
                        </td>
                </tr>
<%
out.print("<tr class='bttn'>");
out.print("<td width='5%'>用户名</td>");
out.print("<td width='45%'>问题</td>");
 out.print("<td width='15%'>发送日期</td>");
 out.print("<td width='10%'>回复时间</td>");
 //out.print("<td width='10%'>接待地点</td>");
//out.print("<td width='10%'>接待人职务</td>");
out.print("<td width='5%'>回复</td>");
out.print("</tr>");
int linenum = 0;
if(newvPage != null)
{
	//out.print(newvPage);
	//if(true)return;
	for(int i=0;i<newvPage.size();i++)
	{
		 newcontent = (Hashtable)newvPage.get(i);
		 String wt_id = newcontent.get("wt_id").toString();
		 jd_id = newcontent.get("jd_id").toString();
		//String wt_subject = newcontent.get("jd_subject").toString();
		String wt_question = newcontent.get("wt_question").toString();
		String wt_senddate = newcontent.get("wt_senddate").toString();
		String wt_solvedate = newcontent.get("wt_solvedate").toString();
		String cw_applyname = newcontent.get("cw_applyname").toString();
		//String jd_depart = newcontent.get("jd_depart").toString();

		if(linenum%2==0)
			out.print("<tr class='line-odd' align='center'>");

		else
			out.print("<tr class='line-even' align='center'>");
		linenum ++;
        out.print("<td align='center'>"+cw_applyname+"</td>");
		out.print("<td align='center'>"+wt_question+"</td>");
		out.print("<td align='center'>"+wt_senddate+"</td>");
		out.print("<td align='center'>"+wt_solvedate+"</td>");

		//out.print("<td align='center'>"+jd_address+"</td>");
		//out.print("<td align='center'>"+jd_duty+"</td>");
		out.print("<td align='center'><a href='questioninfo.jsp?wt_id="+newcontent.get("wt_id").toString()+"'><img src='../../../images/modi.gif' border='0' title='回复'></a></td></tr>");
		}
	
}
   out.println("<tr><td colspan=9>" + dImpl.getTail(request) + "</td></tr>"); 
if(linenum==0)
{
	out.print("<tr><td colspan='9'><font color='#aaaaaa'>此项目下无问题</font></td></tr>");
}
%>
</table>
  </td>
</tr>
</table>
</form>
<%}%>
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
</SCRIPT>
<%@include file="/system/app/skin/bottom.jsp"%>
