<%@ page contentType="text/html; charset=GBK" %>
<%@include file="../skin/head.jsp"%>
<%

//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 
String ty_name = "";
String ty_code = "";
String ty_id = "" ;
String OType = "" ;
ty_name = CTools.dealString(request.getParameter("ty_name")).trim();
ty_code =  CTools.dealString(request.getParameter("ty_code")).trim();
ty_id = CTools.dealString(request.getParameter("ty_id")).trim();
OType = CTools.dealString(request.getParameter("OType")).trim();
if("add".equals(OType))
ty_id = dImpl.addNew("tb_votetype","ty_id",CDataImpl.PRIMARY_KEY_IS_VARCHAR);
if("edit".equals(OType))
dImpl.edit("tb_votetype","ty_id",ty_id);
dImpl.setValue("ty_name",ty_name,CDataImpl.STRING);
dImpl.setValue("ty_code",ty_code,CDataImpl.STRING);
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
