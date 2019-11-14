<%@page contentType="text/html; charset=GBK"%>
<%@include file="../skin/import.jsp"%>
<%
//update by yo 20091230
CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象
try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 

  String info_id = CTools.dealString(request.getParameter("info_id"));
  
	dImpl.edit("infoopen","id",info_id);
  dImpl.setValue("status","0",CDataImpl.STRING);//待处理状态
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
  response.sendRedirect("infoopenList.jsp");
%>
