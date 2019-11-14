<%@ page contentType="text/html; charset=GBK" %>
<%@ page import="com.component.database.*" %>
<%@ page import="java.io.*" %>
<%@ page import="com.platform.module.CModuleInfo" %>

<%
String list_id;
boolean t ;
%>
<%
    list_id = request.getParameter("list_id");
    CDataCn  dCn = null;
    CModuleInfo ado = null;
    try{
    	dCn = new CDataCn();
    	 ado = new CModuleInfo(dCn);
    t = ado.setSequence(request);
//    out.print(t);
// out.print(list_id);
    dCn.closeCn();
    response.sendRedirect("moduleList.jsp?list_id="+list_id);
    } catch (Exception ex) {
	System.out.println(new java.util.Date() + "--"
			+ request.getServletPath() + " : " + ex.getMessage());
} finally {
	if(ado != null)
	ado.closeStmt();
	if(dCn != null)
	dCn.closeCn();
}
%>
