<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="../head.jsp"%>
<%
	String tr_id;
	String action;
	String moduleIds;
	String url;

	long id;

	tr_id = request.getParameter("tr_id");
	moduleIds = request.getParameter("moduleIds");
	action = request.getParameter("action");
%>
<%
		if (tr_id != null) {
		if (!tr_id.equals("")) {
			CDataCn dCn = null;
			CRoleAccess jdo = null;
			try {
		dCn = new CDataCn();
		jdo = new CRoleAccess(dCn);
		id = java.lang.Long.parseLong(tr_id);
		jdo.setAccess(tr_id, moduleIds, jdo.ModuleAccess);

		jdo.closeStmt();
		dCn.closeCn();
			} catch (Exception ex) {
		System.out.println(new java.util.Date() + "--"
				+ request.getServletPath() + " : "
				+ ex.getMessage());
			} finally {
		if (jdo != null)
			jdo.closeStmt();
		if (dCn != null)
			dCn.closeCn();
			}

		}
	}

	url = "roleFunctionsInfo.jsp?tr_id=" + tr_id;
	response.sendRedirect(url);
%>
