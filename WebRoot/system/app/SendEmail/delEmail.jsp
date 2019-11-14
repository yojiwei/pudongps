<%@page contentType="text/html; charset=GBK"%>
<%@include file="../skin/import.jsp"%>
<%
//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象
try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 
	String em_id= CTools.dealString(request.getParameter("em_id"));
	if(!"".equals(em_id))
	{
		dImpl.executeUpdate("update tb_emailsave set em_needsend='0' where em_id='"+em_id+"'");
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
out.print("<script>alert('删除成功!');window.location.href='EmailList.jsp';</script>");
%>