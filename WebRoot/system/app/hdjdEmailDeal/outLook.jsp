<%@page contentType="text/html; charset=GBK"%>
<%
	String e_mail = request.getParameter("eMail").toString();
	String e_subject ="¹ØÓÚ "+ request.getParameter("eSubject").toString()+"»Ø¸´";
	String feedBack = request.getParameter("feedBack").toString();
%>
<script language="javascript">

	location.href ="mailto:<%=e_mail%>?subject=<%=e_subject%>&body=<%=feedBack%>";
	window.close();
//alert(aa);
</script>
