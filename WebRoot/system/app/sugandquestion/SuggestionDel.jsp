<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/import.jsp"%>
<%
String sg_ids = "";
String [] sg_idSet;
sg_ids = CTools.dealString(request.getParameter("sg_id")).trim();

sg_idSet = CTools.splite(sg_ids,",");
//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 


dCn.beginTrans();
for (int i=0;i<sg_idSet.length;i++)
{
	dImpl.delete("tb_suggest","sg_id",sg_idSet[i]);
}
dCn.commitTrans();

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
out.print("<script>alert('删除成功！');location.href='SuggestionList.jsp';</script>");
//response.sendRedirect("SuggestionList.jsp");
%>
