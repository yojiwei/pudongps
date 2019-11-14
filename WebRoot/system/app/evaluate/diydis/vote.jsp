<%@page contentType="text/html; charset=GBK"%>
<%@page import="com.util.*"%>
<%@page import="Evaluate.*"%>
<%@page import="vote.*"%>
<%@ page import="com.component.database.CDataCn" %>
<%@ page import="com.component.database.CDataImpl" %>
<LINK href="main.css" type="text/css" rel="stylesheet">
<title>ͶƱ</title>
<form action="voteresult.jsp">
<table border="1" cellspacing="0" cellpadding="3" width="100%">
<%
String id = "";
String vt_name = "";
id = CTools.dealString(request.getParameter("id")).trim();
vt_name = vote.getVtName(id);
out.print("<tr><td align='center'><b>" + vt_name + "</b></tr><td>");
Vote vote = new Vote();
vote.getVoteTitle(id);
//out.print(vote.ShowVoteFrontPage(id));
out.print(vote.showStyleAcross());
%>
</table>
<input type="hidden" name="id" value="<%=id%>">
<input type="submit" value="�ύ" >
</form>