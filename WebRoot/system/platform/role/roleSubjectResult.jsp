<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="../head.jsp"%>
<%
	String tr_id;
	String action;
	String subjectIds;
	String url;

	long id;

	tr_id = request.getParameter("tr_id");
	subjectIds = CTools.dealString(request.getParameter("subjectIds"));
	action = request.getParameter("action");

	//out.println(subjectIds);
	//out.close();
%>
<%
		if (tr_id != null) {
		if (!tr_id.equals("")) {

			CDataCn dCn = null;
			CRoleInfo jdo = null;
			try {
		dCn = new CDataCn();
		jdo = new CRoleInfo(dCn);
		id = java.lang.Long.parseLong(tr_id);
		jdo.setSubjects(id, subjectIds);

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

	url = "roleSubjectInfo.jsp?tr_id=" + tr_id;
	response.sendRedirect(url);
%>
