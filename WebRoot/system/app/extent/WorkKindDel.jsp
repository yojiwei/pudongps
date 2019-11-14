<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/import.jsp"%>
<%
String wk_id = CTools.dealNumber(request.getParameter("wk_id")).trim();

//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 


dCn.beginTrans();

dImpl.delete("tb_workkind","wk_id",wk_id);
if(dCn.getLastErrString().equals(""))
  dCn.commitTrans();
else
  dCn.rollbackTrans();

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
response.sendRedirect("WorkKindList.jsp");
%>