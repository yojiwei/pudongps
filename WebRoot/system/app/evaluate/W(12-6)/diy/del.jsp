<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%@page import="com.util.*"%>
<%@page import="Evaluate.*"%>
<%@page import="vote.*"%>
<%
CDataCn dCn = new CDataCn();
CDataImpl dImpl = new CDataImpl(dCn);

String id = "";
String upperid = "";
String type = "";
String treeid = "";
id = CTools.dealString(request.getParameter("vt_id")).trim();
upperid = CTools.dealString(request.getParameter("vt_upperid")).trim();
type = CTools.dealString(request.getParameter("type")).trim();
treeid = CTools.dealString(request.getParameter("treeid")).trim();

Vote vote = new Vote();
vote.DelItem(id,upperid,type);
%>
	<script language="javascript">
		//alert("É¾³ýÒÑ³É¹¦");
	<%
	if(treeid.equals(""))
	{
	%>
		window.location.href="list.jsp?upperid=<%=upperid%>";
	<%
	}
	else
	{
	%>
	window.location.href="listtree.jsp?treeid=<%=treeid%>";
	<%
	}	
	%>
	</script>
<%
dImpl.closeStmt();
dCn.closeCn();
%>