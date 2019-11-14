<%@page contentType="text/html; charset=GBK"%>
<%@include file="../skin/import.jsp"%>
<%
//update20090824
CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象
try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 

  String cw_id = CTools.dealString(request.getParameter("cw_id"));
  
	dImpl.edit("tb_connwork","cw_id",cw_id);
  dImpl.setValue("cw_zhuanjiao","0",CDataImpl.STRING);//未转交状态
  dImpl.update();

  } catch (Exception ex) {
	System.out.println(new java.util.Date() + "--"
			+ request.getServletPath() + " : " + ex.getMessage());
} finally {
	if(dImpl != null)
		dImpl.closeStmt();
	if(dCn != null)
		dCn.closeCn();
}
  response.sendRedirect("AppealNzj.jsp?cw_zhuanjiao=2");
%>
