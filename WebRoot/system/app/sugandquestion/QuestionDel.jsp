<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/import.jsp"%>
<%
	String Qu_ids = "";
	String[] qu_idSet;
	Qu_ids = CTools.dealString(request.getParameter("qu_id")).trim();
	qu_idSet = CTools.splite(Qu_ids, ",");
	//update20080122

	CDataCn dCn = null; //新建数据库连接对象
	CDataImpl dImpl = null; //新建数据接口对象

	try {
		dCn = new CDataCn();
		dImpl = new CDataImpl(dCn);

		dCn.beginTrans();
		for (int i = 0; i < qu_idSet.length; i++) {
			dImpl.delete("tb_question", "qu_id", qu_idSet[i]);
		}
		dCn.commitTrans();

		dImpl.closeStmt();
		dCn.closeCn();
	} catch (Exception ex) {
		System.out.println(new java.util.Date() + "--"
		+ request.getServletPath() + " : " + ex.getMessage());
	} finally {
		if (dImpl != null)
			dImpl.closeStmt();
		if (dCn != null)
			dCn.closeCn();
	}
	response.sendRedirect("QuestionList.jsp");
%>
