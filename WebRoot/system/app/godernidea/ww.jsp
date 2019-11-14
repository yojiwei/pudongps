


<%@ page contentType="application/vnd.ms-word; charset=gbk"%>
<%response.setHeader("Content-disposition", "attachment; filename=print_tmp.doc");%>
<%@ page import="java.net.URL"%>

<%
	request.setCharacterEncoding("gbk");
	//response.setCharacterEncoding("gbk");
	String url_target = request.getParameter("cw_id");
	out.println(1);
%>
 