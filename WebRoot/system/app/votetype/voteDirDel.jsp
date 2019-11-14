<%@page contentType="text/html; charset=GBK"%>
<%@include file="../skin/import.jsp"%>
<%
String ty_id = "";
//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 

ty_id=CTools.dealString(request.getParameter("ty_id"));
dImpl.executeUpdate("delete from tb_votetype where ty_id='"+ty_id+"'");
dImpl.executeUpdate("delete from tb_votetypedata where ty_id='"+ty_id+"'");
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
response.sendRedirect("voteList.jsp");
%>