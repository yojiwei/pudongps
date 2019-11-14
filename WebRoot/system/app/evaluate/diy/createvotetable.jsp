<%@page contentType="text/html; charset=GBK"%>
<%@include file="/web/include/import.jsp"%>
<%@include file="/web/include/parameter.jsp"%>
<%@page import="vote.*"%>
<%
String id = "";
String upperid = "";
id = CTools.dealString(request.getParameter("id")).trim();
upperid = CTools.dealString(request.getParameter("upperid")).trim();

Vote vote = new Vote();
//out.print(vote.CreateVoteDB(id));
vote.CreateVoteDB(id);
%>
	<script language="javascript">
		//alert("É¾³ýÒÑ³É¹¦");
		window.location.href="index.jsp?upperid=<%=upperid%>";
	</script>