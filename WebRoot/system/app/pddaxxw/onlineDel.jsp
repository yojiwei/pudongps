<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/system/app/skin/import.jsp"%>
<%
String dx_id = "";
String dx_type = "";
//update20091127

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 

 dx_id = CTools.dealString(request.getParameter("dx_id")).trim();
 dx_type = CTools.dealString(request.getParameter("dx_type")).trim();

 dImpl.delete("tb_daxx","dx_id",dx_id);
 dImpl.update();

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
if("apply".equals(dx_type)){
	response.sendRedirect("onlineList.jsp?clstatus=0");
}else{
	response.sendRedirect("onlineAskList.jsp?clstatus=0");
}
%>