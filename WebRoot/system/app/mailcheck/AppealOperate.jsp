<%@page contentType="text/html; charset=GBK"%>
<%@include file="../skin/import.jsp"%>
<%
  String cwids = CTools.dealString(request.getParameter("cwids")).trim();
  String cw_ispublish = CTools.dealString(request.getParameter("cw_ispublish")).trim();
  String [] cw_id = cwids.split(",");

//处理重复信件
CDataCn dCn=null;   //
CDataImpl dImpl=null;  //

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 


for(int j=0;j<cw_id.length;j++)
{
	  dImpl.edit("tb_connwork","cw_id",cw_id[j]);
	  dImpl.setValue("cw_isopen",cw_ispublish,CDataImpl.STRING);
	  dImpl.setValue("cw_ischeck","1",CDataImpl.STRING);
	  dImpl.update();
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
  
  response.sendRedirect("AppealList.jsp?cw_status=3");
%>

