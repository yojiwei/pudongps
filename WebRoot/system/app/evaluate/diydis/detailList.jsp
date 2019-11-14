<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%@page import="com.util.*"%>
<%@page import="Evaluate.*"%>
<%@page import="vote.*"%>
<%
CDataCn dCn_voteitemid = null;
CDataImpl dImpl_voteitemid = null;
try {
dCn_voteitemid = new CDataCn();
dImpl_voteitemid = new CDataImpl(dCn_voteitemid);
Vote vote = new Vote();

String vote_num = "";
String id = "";
String vt_name = "";
id = CTools.dealString(request.getParameter("id")).trim();
vote_num = CTools.dealString(request.getParameter("vote_num")).trim();
String vt_sort = CTools.dealString(request.getParameter("vt_sort")).trim();
String cSort = CTools.dealString(request.getParameter("cSort")).trim();

if (vote_num.equals("")) vote_num = "1";

vt_name = vote.getVtName(id);
String optName = vote.getDeptOpt(id,vt_sort,cSort);
if (vote.getSort() != null) cSort = vote.getSort();
%>
<%@include file="/system/app/skin/skin4/template/list_top.jsp"%>
<!--    模块名称开始    -->
<%=vt_name%>
<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/list_function.jsp"%>                                                            
<!--    功能按钮开始    -->
  
<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/list_listtop.jsp"%>                                                                                        
<!--    列表开始    -->
<TABLE cellSpacing="0" cellPadding="0" width="100%" border="0" align="center">
<tr width="100%" align="center" class="title1">
<td align="center" colspan="15">
	<table cellspacing="0" cellpadding="0" width="100%" border="0">
	  <tr>
	    <td><b><%=vt_name%></b></td>
	    <td align="right"><%=optName%>&nbsp;</td>
	  </tr>
	</table>
</td>
</tr>
<tr>
<td background="/website/images/mid10.gif" width="1" colspan="15"><img src="/website/images/mid10.gif" width="1" height="3"></td>
</tr>
<tr>
<td background="/website/images/mid10.gif" width="1" colspan="15"><img src="/website/images/mid10.gif" width="1" height="3"></td>
</tr>
<tr>
  <td colspan="2">
<table class="main-table" width="100%" align="center">
<%
vote.getVoteTitle(id);
out.print(vote.detailManTitle(id,14));
out.print(vote.reDetailMainSe(id,10,vt_sort,cSort));
%>
</table>
  </td>
</tr>
<tr>
 <td background="/website/images/mid10.gif" width="1" colspan="13"><img src="/website/images/mid10.gif" width="1" height="3"></td>
</tr>
</table>
<table cellspacing="0" cellpadding="0" width="100%" border="0" align="center">
  <tr>
    <td class="title1">
		<input type="button" name="btnReturn" value="返回" onclick="javascript:window.history.go(-1);" class="bttn">
    </td>
  </tr>
</table>
<%
} catch (Exception ex) {
	System.out.println(new java.util.Date() + "--"
			+ request.getServletPath() + " : " + ex.getMessage());
} finally {
dImpl_voteitemid.closeStmt();
dCn_voteitemid.closeCn();
}
%>
<%@include file="/system/app/skin/bottom.jsp"%>