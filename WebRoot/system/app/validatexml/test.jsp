<%@page contentType="text/html; charset=GBK"%>
<%String strTitle="定时生成XML" ;%>
<%@include file="../skin/head.jsp"%>

<%
 CMySelf mySedlfTop = (CMySelf)session.getAttribute("mySelf");
 out.println(mySedlfTop.getDtId());
%>
<%@include file="../skin/bottom.jsp"%>
