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
			CDataImpl dImpl = null;
			try {
		dCn = new CDataCn();
		jdo = new CRoleAccess(dCn);
		dImpl = new CRoleAccess(dCn);

		id = java.lang.Long.parseLong(tr_id);

		jdo.setAccess(tr_id, moduleIds, jdo.ColumnSelAccess);

		Hashtable contentDtId = jdo
				.getDataInfo("select dt_id from tb_roleinfo where tr_id='"
				+ tr_id + "'");
		String dtId = contentDtId.get("dt_id").toString();
		//out.println(dtId);
		if (!dtId.equals("") && !dtId.equals("0")) {
			try {
				com.app.subject.SubSubjectBoImpl bo = new com.app.subject.SubSubjectBoImpl(
				dImpl, dtId);
				//out.println(moduleIds);
				bo.addChange(moduleIds);
			} catch (Exception ex) {
				out.println("error");
			}

		}

		dImpl.closeStmt();
		jdo.closeStmt();
		dCn.closeCn();

			} catch (Exception ex) {
		System.out.println(new java.util.Date() + "--"
				+ request.getServletPath() + " : "
				+ ex.getMessage());
			} finally {
		if (dImpl != null)
			dImpl.closeStmt();
			if (jdo != null)
			jdo.closeStmt();
		if (dCn != null)
			dCn.closeCn();
			}
		}
	}

	//out.println(moduleIds);
	url = "roleSubjectImportInfo.jsp?tr_id=" + tr_id;
	response.sendRedirect(url);
%>
