<%@page contentType="text/html; charset=GBK"%>
<%@page import="com.util.*"%>
<%@page import="Evaluate.*"%>
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
vote.getVoteTitle(id);
//out.print(vote.ShowVoteFrontPage(id));
out.print(vote.ShowVoteFrontPage());
%>
</td></tr>
</table>
<input type="hidden" name="id" value="<%=id%>">
<!--
<input type="submit" value="�ύ" >
-->
</form>