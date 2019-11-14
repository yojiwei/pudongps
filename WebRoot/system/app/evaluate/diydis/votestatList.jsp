<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%@page import="com.util.*"%>
<%@page import="Evaluate.*"%>
<%@page import="vote.*"%>
<%
CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象
CDataCn dCn_voteitemid = null;
CDataImpl dImpl_voteitemid = null;
try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 
dCn_voteitemid = new CDataCn();
dImpl_voteitemid = new CDataImpl(dCn_voteitemid);

String vote_num = "";
String id = "";
String vt_name = "";
id = CTools.dealString(request.getParameter("id")).trim();
vote_num = CTools.dealString(request.getParameter("vote_num")).trim();
if(vote_num.equals("")) vote_num = "1";

String sqlStr_thisitem = "select * from tb_votediy where vt_id= " + id +"";
Hashtable content_thisitem=dImpl_voteitemid.getDataInfo(sqlStr_thisitem);
vt_name = content_thisitem.get("vt_name").toString();

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
	<TABLE cellSpacing="0" cellPadding="0" width="100%" border="0" >
<%
Vote vote = new Vote();
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
dImpl.closeStmt();
dCn.closeCn();
}
%>
<%@include file="/system/app/skin/bottom.jsp"%>
