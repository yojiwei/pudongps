<%@page contentType="text/html; charset=GBK"%>
<%
	String e_mail = request.getParameter("eMail").toString();
%>
<script language="javascript">
	location.href = "mailto:<%=e_mail%>";
	window.close();
</script>