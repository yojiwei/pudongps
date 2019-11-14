<%@page contentType="text/html; charset=GBK"%>
<%@include file="../skin/import.jsp"%>
<%
String fs_id = CTools.dealNumber(request.getParameter("fs_id")).trim();
String list_id = CTools.dealString(request.getParameter("list_id")).trim();

//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 

//dCn.beginTrans();

dImpl.delete("tb_frontsubject","fs_id",fs_id);
//if(dCn.getLastErrString().equals(""))
//  dCn.commitTrans();
//else
//  dCn.rollbackTrans();
} catch (Exception ex) {
	System.out.println(new java.util.Date() + "--"
			+ request.getServletPath() + " : " + ex.getMessage());
} finally {
	if(dImpl != null)
	dImpl.closeStmt();
	if(dCn != null)
	dCn.closeCn();
}
response.sendRedirect("frontSubjectList.jsp?list_id="+list_id);
%>