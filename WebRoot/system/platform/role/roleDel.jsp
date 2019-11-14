<%@ page contentType="text/html; charset=GBK"%>
<%@ page import="com.component.database.*"%>
<%@ page import="com.platform.role.*"%>

<%
	String tr_id;
	String url;
	long id;
%>
<%
	CDataCn dCn = null;
	CRoleInfo jdo = null;
	try {
		dCn = new CDataCn();
		jdo = new CRoleInfo(dCn);
		tr_id = request.getParameter("tr_id");
		if (tr_id != null) {
			if (!tr_id.equals("")) {
		id = java.lang.Long.parseLong(tr_id);
		jdo.delete(id);
			}
		}
		url = "roleList.jsp";
		response.sendRedirect(url);
	} catch (Exception ex) {
		System.out.println(new java.util.Date() + "--"
		+ request.getServletPath() + " : " + ex.getMessage());
	} finally {
		if (jdo != null)
			jdo.closeStmt();
		if (dCn != null)
			dCn.closeCn();
	}
%>
