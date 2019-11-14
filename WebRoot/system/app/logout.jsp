<%@ page contentType="text/html;charset=GBK"%>
<%@include file="/system/app/skin/import.jsp"%>
<%
	CMySelf mySelf = (CMySelf)session.getAttribute("mySelf");
	if(mySelf!=null)
	{
		mySelf.logout();
	}
	session.removeAttribute("mySelf");
	response.sendRedirect("/system/app/index.jsp");
%>