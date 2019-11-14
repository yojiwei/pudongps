<%response.setHeader("Content-disposition","inline; filename=print_tmp.xls");%>
<%@ page contentType="application/vnd.ms-excel; charset=gb2312"%>
<%@ page import="java.net.URL"%>
<meta http-equiv="Content-Language" content="zh-cn">
<meta name="GENERATOR" content="Microsoft FrontPage 5.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<%
String url_target = new String(request.getParameter("url"));
String filename = new String();
URL url = new URL(url_target);
filename = url.getFile();
%>
<jsp:include page="<%=filename%>" />