<%@ page contentType="text/html; charset=GBK"%>
<%@ page import="com.component.database.*"%>
<%@ page import="com.platform.meta.*"%>
<%@ page import="com.util.CTools"%>
<%
	String list_id;
	String node_title;
	String dv_id;
	String url, msg = "";
	long id;
	CTools tools = null;
%>
<%
	tools = new CTools();
	list_id = request.getParameter("list_id");
	dv_id = request.getParameter("dv_id");
	node_title = tools.iso2gb(request.getParameter("node_title"));

	if (dv_id != null) {

		if (!dv_id.equals("0")) {
			CDataCn dCn = null;
			CMetaFileInfo jdo = null;
			try {
		dCn = new CDataCn();
		jdo = new CMetaFileInfo(dCn);
		id = java.lang.Long.parseLong(dv_id);
		jdo.delete(id);
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

	url = "metaList.jsp?list_id=" + list_id + "&node_title="
			+ node_title;
	response.sendRedirect(url);
%>
