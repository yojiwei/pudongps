<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/import.jsp"%>
<%
String sg_id = "";
String suggest = "";
String sg_sequence = "";
String us_kind = "";
String sg_url = "";

sg_id = CTools.dealString(request.getParameter("sg_id")).trim();
suggest = CTools.dealString(request.getParameter("suggest")).trim();
sg_sequence = CTools.dealNumber(request.getParameter("sort")).trim();
us_kind = CTools.dealString(request.getParameter("userKind")).trim();
sg_url = CTools.dealString(request.getParameter("sg_url")).trim();

//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 

dCn.beginTrans();
if (!sg_id.equals(""))
{
	dImpl.edit("tb_suggest","sg_id",sg_id);
}
else
{
	dImpl.addNew("tb_suggest","sg_id",CDataImpl.PRIMARY_KEY_IS_VARCHAR);
}
dImpl.setValue("sg_name",suggest,CDataImpl.STRING);
dImpl.setValue("sg_sequence",sg_sequence,CDataImpl.INT);
dImpl.setValue("us_kind",us_kind,CDataImpl.STRING);
dImpl.setValue("sg_url",sg_url,CDataImpl.STRING);
dImpl.update();
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
if(sg_id.equals(""))
{
%>
window.location.href="SuggestionInfo.jsp";
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