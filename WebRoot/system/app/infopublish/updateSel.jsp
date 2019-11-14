<%@page contentType="text/html; charset=GBK"%>
<%@ page import="com.beyondbit.web.publishinfo.PublishOperate" %>
<%@ page import="com.beyondbit.web.form.TaskInfoForm" %>
<%@ page import="com.beyondbit.web.publishinfo.Messages,com.component.database.CDataControl" %>
<%@ page import="com.website.*,com.smsCase.SmpService,java.util.*,java.util.Date,java.text.SimpleDateFormat,com.smsCase.*" %>
<%@include file="../skin/head.jsp"%>
<html>
<body>
<%
String sm_id=(String)request.getParameter("sm_id");//发布时间
String oPage = CTools.dealString(request.getParameter("oPage")).trim();

CDataCn dCn = new CDataCn(); //新建数据库连接对象
CDataImpl dImpl = new CDataImpl(dCn); //新建数据接口对象
try{
	dImpl.executeUpdate("update tb_sms set sm_flag =2 where sm_id = "+sm_id+"");
	out.println("<script language='javascript'>alert(\"操作成功！\");");
	out.println("window.location.href='"+oPage+"';");
	out.println("</script>");
	
}
catch(Exception ex)
{
 out.println(ex);
}
finally{
dImpl.closeStmt();
dCn.closeCn();
}
%>
</body>
</html>