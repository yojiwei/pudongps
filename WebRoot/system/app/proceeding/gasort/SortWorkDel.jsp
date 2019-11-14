<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/import.jsp"%>
<%
	String GW_ID = CTools.dealString(request.getParameter("GW_ID"));
	CDataCn dCn_swDel = null; //新建数据库连接对象
	CDataImpl dImpl_swDel = null; //新建数据接口对象
	try {
		dCn_swDel = new CDataCn();
		dImpl_swDel = new CDataImpl(dCn_swDel);
		dImpl_swDel.delete("tb_gasortwork", "gw_id", GW_ID);
		dImpl_swDel.closeStmt();
		dCn_swDel.closeCn();
	} catch (Exception ex) {
		System.out.println(new java.util.Date() + "--"
		+ request.getServletPath() + " : " + ex.getMessage());
	} finally {
		if (dImpl_swDel != null)
			dImpl_swDel.closeStmt();
		if (dCn_swDel != null)
			dCn_swDel.closeCn();
	}
	response.sendRedirect("SortWorkList.jsp");
%>
