<%@ page contentType="text/html; charset=GBK" %>
<%
	String bootid = request.getParameter("bootid");
%>
<html>
<head>
<title>Ñ¡ÔñÀ¸Ä¿</title>
</head>
<frameset rows="150,13" cols="*" frameborder="no" border="0" framespacing="0">
  <frame name="ContentFrame" scrolling="yes" noresize src="PublishSJ11.jsp?bootid=<%=bootid%>" marginwidth="0" marginheight="0">
	<frame name="ButtonFrame" scrolling="NO" noresize src="PublishSJSubmit11.jsp" marginwidth="0" marginheight="0">
  </frameset>
</frameset><noframes></noframes>
</html>