<%@page contentType="text/html; charset=GBK"%>
<%@page import="com.util.CTools" %>
<%@page import="com.component.database.*" %>
<%@page import="com.util.CDate" %>
<%@include file="/system/app/islogin.jsp"%>
<%
	String ct_id = CTools.dealString(request.getParameter("ct_id"));
	String ct_title = CTools.dealString(request.getParameter("ct_title")); 
	String bc_Meno = CTools.dealString(request.getParameter("bcMeno"));
  	CMySelf mySelf = (CMySelf)session.getAttribute("mySelf");
  	String userName = mySelf.getMyName();
  	String userId = String.valueOf(mySelf.getMyUid());
  	//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 
  	
	if (!"".equals(bc_Meno)) {

		dImpl.setTableName("tb_newslog");
	  	dImpl.setPrimaryFieldName("ns_id");
	  	dImpl.addNew();
  	  	dImpl.setValue("ct_id",ct_id,CDataImpl.INT);
  	  	dImpl.setValue("ct_title",ct_title,CDataImpl.STRING);
  	  	dImpl.setValue("ns_meno",bc_Meno,CDataImpl.STRING);
  	  	dImpl.setValue("username",userName,CDataImpl.STRING);
  	  	dImpl.setValue("userid",userId,CDataImpl.STRING);
	  	//dImpl.setValue("ns_date",CDate.getNowTime(),CDataImpl.DATE);
  	  	dImpl.update();
		dImpl.closeStmt();
		dCn.closeCn();
		out.print("<script language='javascript'>alert('编辑成功！');returnValue='ok';window.close();</script>");
	}
	} catch (Exception ex) {
	System.out.println(new java.util.Date() + "--"
			+ request.getServletPath() + " : " + ex.getMessage());
} finally {
	if(dImpl != null)
	dImpl.closeStmt();
	if(dCn != null)
	dCn.closeCn();
}
%>