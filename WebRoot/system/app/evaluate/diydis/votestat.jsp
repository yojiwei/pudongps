<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%@page import="com.util.*"%>
<%@page import="Evaluate.*"%>
<%@page import="vote.*"%>
<%
CDataCn dCn_voteitemid = null;
CDataImpl dImpl_voteitemid = null;
try{
	dCn_voteitemid = new CDataCn();
	dImpl_voteitemid = new CDataImpl(dCn_voteitemid);
Vote vote = new Vote();

String vote_num = "";
String id = "";
String vt_name = "";
id = CTools.dealString(request.getParameter("id")).trim();
vote_num = CTools.dealString(request.getParameter("vote_num")).trim();
if(vote_num.equals("")) vote_num = "1";

vt_name = vt_name = vote.getVtName(id);

%>
<TABLE cellSpacing="0" cellPadding="0" width="100%" border="0" align="center">
<tr width="100%" align="center" class="title1">
<td align="center" colspan="15"><b><%=vt_name%></b></td>
</tr>
<tr>
<td background="/website/images/mid10.gif" width="1" colspan="15"><img src="/website/images/mid10.gif" width="1" height="3"></td>
</tr>
<tr>
<td background="/website/images/mid10.gif" width="1" colspan="15"><img src="/website/images/mid10.gif" width="1" height="3"></td>
</tr>
<tr>
  <td colspan="2">
	<TABLE cellSpacing="0" cellPadding="3" width="100%" border="0" >
<%
String tr_name = "";
String tr_ip = "";
String sql = "select tr_ip from tb_remip where vs_id = " + vote_num + " and vt_id = " + id;
ResultSet rs = dImpl_voteitemid.executeQuery(sql);
if (rs.next()) {
	//tr_name = CTools.dealNull(rs.getString("tr_code"));
	tr_ip = CTools.dealNull(rs.getString("tr_ip"));
}
rs.close();
if (!"".equals(tr_ip)) 
	out.print("<tr><td align='left'>IP地址：" + tr_ip + "</td></tr>");
	//out.print("<tr><td align='left'>部门：" + tr_name + "&nbsp;&nbsp;&nbsp;&nbsp;IP地址：" + tr_ip + "</td></tr>");

vote.getVoteTitle(id);
out.print(vote.showManSay(id,vote_num));
//out.print(vote.ShowVoteResultFrontPage(id,Integer.parseInt(vote_num)));
%>
	</TABLE>
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
