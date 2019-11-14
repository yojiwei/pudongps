<%@page contentType="text/html; charset=GBK"%>
<%@page import="com.util.*"%>
<meta http-equiv="Refresh" content="1" url="refresh.jsp">
<%
	String val = CTools.dealNull(request.getParameter("val"));
	if (!val.equals("")) {
		session.setAttribute("_gisVal",val);
	}
	val = CTools.dealNull(session.getAttribute("_gisVal"));
	if (!val.equals("")) {
%>
<script>
		try {
			parent.document.all.gsPosition.value="<%=val%>";
		}catch(e){}
</script>			
<%
	}
	//	session.removeAttribute("_gisVal");
%>