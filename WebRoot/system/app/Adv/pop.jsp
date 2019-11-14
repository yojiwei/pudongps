<%@page contentType="text/html;charset=GBK"%>
<%@include file="../skin/head.jsp"%>
<!--开始-->
<!-- 程序开始 -->
</html>
<head>
<title>广告</title>
</head>
<body>
<%
CDataCn dCn = new CDataCn(); //新建数据库连接对象
CDataImpl dImpl = new CDataImpl(dCn); //新建数据接口对象

String OutStr = "";
//Calendar cal = Calendar.getInstance();
//int month=cal.get(cal.MONTH)+1;
//ai_date=(cal.get(cal.YEAR) + "-" + month +"-"+ cal.get(cal.DAY_OF_MONTH)).toString();//发布时间;

/*得到上一个页面传过来的参数  开始*/
OutStr = CTools.dealString(request.getParameter("OutStr")).trim();
%>
<table>
	<tr>
		<td><%=OutStr%></td>
	</tr>
</table>
<%
//关闭连接
dImpl.closeStmt();
dCn.closeCn();
%>
</body>
</html>
