<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/system/app/skin/import.jsp"%>
<%
String pa_id = CTools.dealString(request.getParameter("pa_id")).trim();
String pr_id = CTools.dealString(request.getParameter("pr_id")).trim();
//update20081007

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 


dImpl.delete("tb_proceeding_ask","pa_id",pa_id);

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
response.sendRedirect("/system/app/proceeding_new/AnswerList.jsp?pr_id="+pr_id);
%>