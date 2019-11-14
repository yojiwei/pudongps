<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="../head.jsp" %>
<%
String tr_id=""; //½ÇÉ«id
tr_id = request.getParameter("tr_id");
if (tr_id == null) tr_id = "1";
if (tr_id.equals("")) tr_id = "1";
response.sendRedirect("roleInfo.jsp?tr_id="+tr_id);
%>

