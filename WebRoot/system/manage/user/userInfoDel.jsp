<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="../head.jsp"%>
<%
	String list_id;
	String node_title;
	String ft_id;
	String url, msg = "";
	long id;
	CTools tools = null;
%>
<%
	tools = new CTools();
	list_id = request.getParameter("list_id");
	ft_id = request.getParameter("ui_id");
	node_title = tools.iso2gb(request.getParameter("node_title"));

	if (ft_id != null) {

		if (!ft_id.equals("0")) {
			CDataCn dCn = new CDataCn();
			CUserInfo jdo = new CUserInfo(dCn);
			try {
		dCn = new CDataCn();
		jdo = new CUserInfo(dCn);
		id = java.lang.Long.parseLong(ft_id);
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
	if (!msg.equals("")) {
		url = "/system/common/goback/goback.jsp?msg=" + msg;
	} else {
		url = "userList.jsp?list_id=" + list_id + "&node_title="
		+ node_title;
	}
	response.sendRedirect(url);
%>
