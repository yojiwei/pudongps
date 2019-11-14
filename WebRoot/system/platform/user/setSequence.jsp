<%@ page contentType="text/html; charset=GBK" %>
<%@ page import="com.component.database.*" %>
<%@ page import="java.io.*" %>
<%@ page import="com.platform.user.*" %>

<%
String list_id;
boolean t ;
%>
<%
    list_id = request.getParameter("list_id");
    CDataCn  dCn = null;
    CDeptInfo md = null;
    try{
    	dCn = new CDataCn();
    	md = new CDeptInfo(dCn);
    t = md.setSequence(request);

    CUserInfo mf = new CUserInfo(dCn);
    t = mf.setSequence(request);

//    out.print(t);
// out.print(list_id);
    dCn.closeCn();
    response.sendRedirect("userList.jsp?list_id="+list_id);
    } catch (Exception ex) {
	System.out.println(new java.util.Date() + "--"
			+ request.getServletPath() + " : " + ex.getMessage());
} finally {
	if(md != null)
	md.closeStmt();
	if(dCn != null)
	dCn.closeCn();
}
%>
