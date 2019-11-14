<%@ page contentType="text/html; charset=GBK" %>
<%@include file="../inc/import.jsp"%>
<%
  String AT_id;
  String action;
  String moduleIds;
  String url;

  long id;

  AT_id      = request.getParameter("AT_id");
  moduleIds  = request.getParameter("moduleIds");
  action     = request.getParameter("action");

  if (AT_id != null)
  {
    if (!AT_id.equals(""))
    {
      CDataCn dCn=null;
      CAdminInfo jdo = null;
      try{
      	dCn=new CDataCn();
      	jdo = new CAdminInfo(dCn);
      id = java.lang.Long.parseLong(AT_id);
      jdo.setAccess(id,jdo.ORGANIZATION_ACCESS,moduleIds);
      jdo.closeStmt();
      dCn.closeCn();
      } catch (Exception ex) {
	System.out.println(new java.util.Date() + "--"
			+ request.getServletPath() + " : " + ex.getMessage());
} finally {
	if(jdo != null)
	jdo.closeStmt();
	if(dCn != null)
	dCn.closeCn();
}
    }
  }


  url = "adminInfo.jsp?AT_id="+AT_id;
  response.sendRedirect(url);
%>
