<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%@page import="com.util.*"%>
<%@page import="Evaluate.*"%>
<%@page import="vote.*"%>
<table border="1">
<%
String id = "";
id = CTools.dealString(request.getParameter("id")).trim();
Vote vote = new Vote();
vote.getVoteTitle(id);
out.print(vote.ShowAllResult(id));
%>
</table>

