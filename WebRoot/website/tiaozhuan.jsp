<%@page contentType="text/html; charset=GBK"%>
<%
//update by yo 20090110
String ticket = String.valueOf(session.getAttribute("casTicket"));
if(ticket!=null&&!ticket.equals("no")&&!"".equals(ticket))
{
	response.sendRedirect("/website/usermanage/Modify.jsp");
}
%>