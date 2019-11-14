<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/import.jsp"%>
<%
String qu_id = "";
String question = "";
String qu_sequence = "";
String us_kind = "";
String qu_content = "";
String qu_error = "";

qu_id = CTools.dealString(request.getParameter("qu_id")).trim();
question = CTools.dealString(request.getParameter("question")).trim();
qu_sequence = CTools.dealNumber(request.getParameter("sort")).trim();
us_kind = CTools.dealString(request.getParameter("userKind")).trim();
qu_content = CTools.dealString(request.getParameter("answer")).trim();
qu_error = CTools.dealString(request.getParameter("qu_error")).trim();

//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 

dCn.beginTrans();
if (!qu_id.equals(""))
{
	dImpl.edit("tb_question","qu_id",qu_id);
}
else
{
	dImpl.addNew("tb_question","qu_id",CDataImpl.PRIMARY_KEY_IS_VARCHAR);
}
dImpl.setValue("qu_title",question,CDataImpl.STRING);
dImpl.setValue("qu_sequence",qu_sequence,CDataImpl.INT);
dImpl.setValue("us_kind",us_kind,CDataImpl.STRING);
dImpl.setValue("qu_time",new CDate().getNowTime(),CDataImpl.DATE);
dImpl.setValue("qu_error",qu_error,CDataImpl.STRING);
dImpl.update();
dImpl.setClobValue("qu_content",qu_content);
if(dCn.getLastErrString().equals(""))
{
	dCn.commitTrans();
}
else
{
	dCn.rollbackTrans();
	out.print("<script>alert('插入数据失败！');</script>");
}

dImpl.closeStmt();
dCn.closeCn();
%>
<script language="javascript">
<%
if(qu_id.equals(""))
{
%>
window.location.href="QuestionInfo.jsp";
<%
}
else
{
%>
window.history.go(-2);
<%
}
%>
</script>

<%


} catch (Exception ex) {
	System.out.println(new java.util.Date() + "--"
			+ request.getServletPath() + " : " + ex.getMessage());
} finally {
	if(dImpl != null)
	dImpl.closeStmt();
	if(dCn != null)
	dCn.closeCn();
}

%>