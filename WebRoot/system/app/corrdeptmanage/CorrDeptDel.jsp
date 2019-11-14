<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/system/app/skin/import.jsp"%>
<%
String pc_id = CTools.dealString(request.getParameter("pc_id")).trim();
String pr_id = CTools.dealString(request.getParameter("pr_id")).trim();
//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 


dImpl.delete("tb_proceedingcorr","pc_id",pc_id);

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
response.sendRedirect("/system/app/corrdeptmanage/CorrDeptList.jsp?pr_id="+pr_id);
%>