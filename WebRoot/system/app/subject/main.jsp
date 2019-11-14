<%@page contentType="text/html; charset=GBK"%>
<body   style="overflow-x:hidden;overflow-y:auto">
<%@include file="/system/app/skin/head.jsp"%>
<%
String url=CTools.dealNull(request.getParameter("url"),"subjectList.jsp");
%>
<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
</head>
<table border=0 width=100%>
<tr>
<td height=500 width=60 valign=200><iframe id=frmDiv style="display:" width=200 height=500 name="left" noresize src="left.jsp"></iframe></td>
<td width=5 nowrap align=center valign=middle>

<a href=# onclick="javascript:document.all.left.style.display='none';"><<</a>
<br><br>
<a href=# onclick="javascript:document.all.left.style.display='';">>></a>

<td>
<td height=500 width=100% valign=top><iframe style="width:100%;" height=500 name="main" noresize src="<%=url%>"></iframe></td>
</tr>
</table>
</body>
</html>
<%@include file="../skin/bottom.jsp"%>
