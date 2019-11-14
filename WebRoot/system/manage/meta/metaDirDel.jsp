<%@ page contentType="text/html; charset=GBK"%>
<%@ page import="com.component.database.*"%>
<%@ page import="com.platform.meta.*"%>
<%@ page import="com.util.CTools"%>
<%
	String list_id;
	String node_title;
	String dd_id;
	String url, msg = "";
	long id;
	CTools tools = null;
%>
<%
	tools = new CTools();
	list_id = request.getParameter("list_id");
	dd_id = request.getParameter("dd_id");
	node_title = tools.iso2gb(request.getParameter("node_title"));

	if (dd_id != null) {

		if (!dd_id.equals("0")) {
			CDataCn dCn = null;
			CMetaDirInfo jdo = null;
			try {
		dCn = new CDataCn();
		jdo = new CMetaDirInfo(dCn);
		id = java.lang.Long.parseLong(dd_id);
		if (jdo.hasSubMeta(id)) {
			msg = "该字典目录有子目录，不能删除！";
		} else {
			jdo.delete(id);
		}
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
	if (!msg.equals("")) {
		url = "/system/common/goback/goback.jsp?msg=" + msg;
	} else {
		url = "metaList.jsp?list_id=" + list_id + "&node_title="
		+ node_title;
	}
	response.sendRedirect(url);
%>
