<%@page contentType="text/html; charset=GBK"%>
<%@include file="/web/include/import.jsp"%>
<%@include file="/web/include/parameter.jsp"%>
<%@page import="vote.*"%>
<LINK href="main.css" type="text/css" rel="stylesheet">
<title>ͶƱ</title>
<form action="voteresult.jsp">
<table border="1">
<tr><td>
<%
String id = "";
id = CTools.dealString(request.getParameter("id")).trim();

Vote vote = new Vote();
out.print(vote.ShowVoteFrontPage(id));
%>
</td></tr>
</table>
<input type="hidden" name="id" value="<%=id%>">
<input type="submit" name="�ύ">
</form>