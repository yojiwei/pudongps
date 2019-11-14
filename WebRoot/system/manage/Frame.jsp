<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>

<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">

<%
    String dir="",leftUrl="",mainUrl="",UserName="";
    dir = request.getParameter("dir")	;

	if (dir == null)
        {
        response.sendRedirect("/system/app/skin/skin3/login.jsp");
        }
        else
        {
		leftUrl = dir + "/left.jsp";
		mainUrl = dir + "/" + "main.jsp"	;
        }

%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
</head>
<table border=0 width=100%>
<tr>
<td height=500 width=60 valign=top><iframe width=200 height=500 name="left" noresize src="<%=leftUrl%>"></iframe></td>
<td height=500 width=100% valign=top><iframe style="width:100%;" height=500 name="main" noresize src="<%=mainUrl%>"></iframe></td>
</tr>
</table>

  <!--frameset cols="200,*"  frameborder="NO" border="0" framespacing="0">
    <frame name="left" noresize src="<%=leftUrl%>">
    <frame name="main" marginwidth="0" src="<%=mainUrl%>">
  </frameset-->
<noframes><body bgcolor="#FFFFFF"></noframes>
</body>
</html>
<%@include file="/system/app/skin/bottom.jsp"%>
