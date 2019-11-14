<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%@page import="com.util.*"%>
<%@page import="Evaluate.*"%>
<%@page import="vote.*"%>
<%
//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 
String treeid = "";
String strTitle = "";//抬头标题
treeid = CTools.dealString(request.getParameter("treeid")).trim();

String sqlStr_thisitem = "select * from tb_votediy where vt_id= " + treeid +"";
Hashtable content_thisitem=dImpl.getDataInfo(sqlStr_thisitem);
strTitle = content_thisitem.get("vt_name").toString();
String vde_status = CTools.dealString(request.getParameter("vde_status")).trim();

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
												<img src="../../../images/split.gif" align="middle" border="0" WIDTH="5" HEIGHT="8">
														<a href="list.jsp?upperid=<%=treeid%>&vde_status=<%=vde_status%>&Typepp=1">普通视图</a>
														<img src="../../../images/split.gif" align="middle" border="0" WIDTH="5" HEIGHT="8">
														<a href="info.jsp?OType=Add&upperid=<%=treeid%>&treeid=<%=treeid%>"><img src="../../../images/new.gif" border="0" title="新建" align="absmiddle"></a>
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
Vote vote = new Vote();
vote.getVoteTitle(treeid);
out.print(vote.ShowVoteResultFrontPageTree(treeid));
%>
</table>
  </td>
</tr>
</table>
<%
if(!treeid.equals(""))
{
	%>
	<table><tr><td>
	<%
	out.print("<a href='/website/evaluate/diy/vote.jsp?id="+treeid+"' target='_black'>投票页面</a> ");
	String strSQLs="select * from tb_votediyext where vt_id="+treeid+"";
	Hashtable content_1=dImpl.getDataInfo(strSQLs);
			if(content_1.get("vde_type").toString().equals("0")){	
			out.print("<td><a href='votestat.jsp?id="+content_1.get("vt_id").toString()+"'>统计页面</a></td>");
			}
			if(content_1.get("vde_type").toString().equals("1")){	
			out.print("<td><a href='votestit.jsp?id="+content_1.get("vt_id").toString()+"'>统计页面</a></td>");
			}
	%>
	</td></tr></table>
	<%
}
%>
</form>
<SCRIPT LANGUAGE=javascript>
<!--
function setSequence()
{
	PageForm.action = "setSequence.jsp?treeid=<%=treeid%>";
	PageForm.submit();
}
//-->
</SCRIPT>
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
