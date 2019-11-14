
<%
	session.removeValue("UserName");
	session.removeValue("UserClass");
	response.sendRedirect("/oa30/bbs/index.jsp");
%>