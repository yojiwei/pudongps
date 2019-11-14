<%@ page contentType="text/html; charset=GBK" %>
<%@include file="../skin/head.jsp"%>
<%
//update20080122
String optype="";
String pc_id="";
String dt_id="";
String pc_timelimit="";
String pr_id="";
boolean flag=true;
CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 




optype = CTools.dealString(request.getParameter("OPType")).trim();
pc_id = CTools.dealString(request.getParameter("pc_id")).trim();
pr_id = CTools.dealString(request.getParameter("pr_id")).trim();
pc_timelimit = CTools.dealNumber(request.getParameter("pc_timelimit")).trim();
dt_id = CTools.dealNumber(request.getParameter("dt_id")).trim();
//out.println(pr_id);

if(optype.equals("Edit"))
{
	dCn.beginTrans();
	dImpl.edit("tb_proceedingcorr","pc_id",pc_id);
	dImpl.setValue("pc_timelimit",pc_timelimit,CDataImpl.INT);
	dImpl.setValue("dt_id",dt_id,CDataImpl.INT);
	dImpl.update();
	if(dCn.getLastErrString().equals(""))
	{
	 dCn.commitTrans();
	}
	else
	{
	  dCn.rollbackTrans();
	}
}
else
{
	dCn.beginTrans();
	dImpl.addNew("tb_proceedingcorr","pc_id",CDataImpl.PRIMARY_KEY_IS_VARCHAR);
	dImpl.setValue("pr_id",pr_id,CDataImpl.STRING);
	dImpl.setValue("dt_id",dt_id,CDataImpl.INT);
	dImpl.setValue("pc_timelimit",pc_timelimit,CDataImpl.INT);
	dImpl.update();
	if(dCn.getLastErrString().equals(""))
	{
	 dCn.commitTrans();
	}
	else
	{
	  dCn.rollbackTrans();
	}
}

%>
<%
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
response.sendRedirect("CorrDeptList.jsp?pr_id="+pr_id);
%>
<%@include file="../skin/bottom.jsp"%>