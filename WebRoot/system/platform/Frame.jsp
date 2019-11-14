<%@page contentType="text/html; charset=GBK"%>
<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">

<%
    String dir="",leftUrl="",mainUrl="",UserName="";
    dir = request.getParameter("dir")	;
	if (dir==null)
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


  <frameset cols="200,*"  frameborder="NO" border="0" framespacing="0">
    <frame name="left" noresize src="<%=leftUrl%>">
    <frame name="main" marginwidth="0" src="<%=mainUrl%>">
  </frameset>
<noframes><body bgcolor="#FFFFFF"></noframes>
</body>
</html>