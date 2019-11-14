<%@ page contentType="text/html; charset=GBK" %>
<%@include file="/system/app/skin/head.jsp"%>

<%


String type = CTools.dealString(request.getParameter("type")).trim();
String cs_id = CTools.dealNumber(request.getParameter("cs_id")).trim();
//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 

String sql="delete from tb_conncase where cs_id=" + cs_id;
dImpl.executeUpdate(sql);
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
  response.sendRedirect("caseList.jsp?type="+type);

/*程序主体  结束*/
%>
