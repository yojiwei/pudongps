<%@ page contentType="text/html; charset=GBK" %>
<%@include file="/system/app/skin/import.jsp"%>
<%@include file="/system/app/islogin.jsp"%>
<html>
<head>
<title>管理系统</title>
</head>
<frameset rows="99,*" cols="*" frameborder="no" border="0" framespacing="0">
  <frame name="system_head" scrolling="NO" noresize src="head.jsp" marginwidth="0" marginheight="0">
  <frameset cols="170,0,*" frameborder="no" border="0" framespacing="1" rows="*">
    <frame name="system_left"  scrolling="yes" src="left.jsp" marginwidth="0" marginheight="0">
    <frame name="redirect" scrolling="NO" noresize src="navigator.jsp" marginwidth="0" marginheight="0">
    <frame name="system_main"  scrolling="auto" src="/system/app/navigator/todayaffair/AffairList.jsp" marginwidth="0" marginheight="0">
  </frameset>
</frameset><noframes></noframes>
</html>