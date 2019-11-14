<%@ page contentType="text/html;charset=GBK"%>
<%@include file="/system/app/skin/import.jsp"%>
<%
	CManager manager = (CManager)session.getAttribute("manager");
	if(manager!=null)
	{
		manager.logout();
	}
	session.removeAttribute("manager");
	response.sendRedirect("/system/platform/index.jsp");
%>