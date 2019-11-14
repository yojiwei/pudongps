<%@ page contentType="text/html; charset=GBK" %>
<%@include file="../skin/head.jsp"%>
<%
CDataCn dCn=new CDataCn();
CDataImpl dImpl=new CDataImpl(dCn);

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

response.sendRedirect("/system/app/evaluate/GovManage.jsp");
%>
<%@include file="../skin/bottom.jsp"%>