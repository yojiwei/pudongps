<%@ page contentType="text/html; charset=GBK" %>
<%@include file="../skin/head.jsp"%>
<%
//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 


String optype="";
String gv_id="";
String gv_name="";
String gv_sequence="";

optype=CTools.dealString(request.getParameter("OPType")).trim();
gv_id=CTools.dealString(request.getParameter("gv_id")).trim();
gv_name=CTools.dealString(request.getParameter("gv_name")).trim();
gv_sequence=CTools.dealString(request.getParameter("gv_sequence")).trim();
dCn.beginTrans();

if(optype.equals("Add"))
{
dImpl.addNew("tb_govinfo","gv_id");
dImpl.setValue("gv_name",gv_name,CDataImpl.STRING);
dImpl.setValue("gv_sequence",gv_sequence,CDataImpl.STRING);
dImpl.update();
}

if(optype.equals("Edit"))
{
dImpl.edit("tb_govinfo","gv_id",gv_id);
dImpl.setValue("gv_name",gv_name,CDataImpl.STRING);
dImpl.setValue("gv_sequence",gv_sequence,CDataImpl.STRING);
dImpl.update();
}

if(optype.equals("Del"))
{
dImpl.delete("tb_govinfo","gv_id",gv_id);
}

if(dCn.getLastErrString().equals(""))
	{
	 dCn.commitTrans();
	}
	else
	{
	  dCn.rollbackTrans();
	}


dImpl.closeStmt();
dCn.closeCn();
} catch (Exception ex) {
	System.out.println(new java.util.Date() + "--"
			+ request.getServletPath() + " : " + ex.getMessage());
} finally {
	if(dImpl != null)
	dImpl.closeStmt();
	if(dCn != null)
	dCn.closeCn();
}

response.sendRedirect("/system/app/evaluate/GovManage.jsp");
%>
<%@include file="../skin/bottom.jsp"%>