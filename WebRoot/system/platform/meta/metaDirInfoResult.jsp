<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="../head.jsp"%>
<%
	String list_id;
	String node_title;
	String dd_id;
	String dd_name;
	String dd_code;
	String msg = "";

	CTools tools = null;
	String url = "";
	long id = 0;
	String strstatus = ""; //交换的方式
%>
<%
	tools = new CTools();
	//update20080122

	CDataCn dCn = null; //新建数据库连接对象
	CDataImpl dImpl = null; //新建数据接口对象

	try {
		dCn = new CDataCn();
		dImpl = new CDataImpl(dCn);

		CMetaDirInfo jdo = new CMetaDirInfo(dCn);

		list_id = request.getParameter("list_id");//dd_parentid
		node_title = tools.iso2gb(request.getParameter("node_title"));

		dd_id = request.getParameter("dd_id");//
		dd_name = tools.iso2gb(request.getParameter("dd_name"));
		dd_code = tools.iso2gb(request.getParameter("dd_code"));

		if (dd_id.equals("0")) { //新增
			//检查是否有相同的代码
			if (jdo.hasSameCode(dd_code, -1)) {
		msg = "未能成功新增！\\n注：代码[" + dd_code + "]已经存在！";
			} else {
		strstatus = "1";
		id = jdo.addNew();

			}
		} else {
			//检查是否有相同的代码
			id = java.lang.Long.parseLong(dd_id);
			if (jdo.hasSameCode(dd_code, id)) {
		msg = "未能修改新增！\\n注：代码[" + dd_code + "]已经存在！";
			} else {
		strstatus = "2";
		jdo.edit(id);

			}
		}
		if (msg.equals("")) {
			jdo.setValue("dd_name", dd_name, jdo.STRING);
			jdo.setValue("dd_code", dd_code, jdo.STRING);
			jdo.setValue("dd_parentid", list_id, jdo.LONG);
			jdo.update();

			///////////////////////
			dImpl.addNew("tb_exchange", "ec_id");
			dImpl.setValue("ec_kind", "10", CDataImpl.INT);//关系类型
			dImpl
			.setValue("pm_id", Long.toString(id),
			CDataImpl.STRING);
			dImpl.setValue("ec_method", strstatus, CDataImpl.INT);//交换的方式
			dImpl.setValue("ec_status", "0", CDataImpl.INT);//未交换
			dImpl.update();
			///////////////////////

			jdo.closeStmt();

			url = "metaList.jsp?list_id=" + list_id + "&node_title="
			+ java.net.URLEncoder.encode(node_title);
		} else {
			url = "/system/common/goback/goback.jsp?msg="
			+ java.net.URLEncoder.encode(msg);
		}
		dImpl.closeStmt();

		dCn.closeCn();
		response.sendRedirect(url);

	} catch (Exception ex) {
		System.out.println(new java.util.Date() + "--"
		+ request.getServletPath() + " : " + ex.getMessage());
	} finally {
		if (dImpl != null)
			dImpl.closeStmt();
		if (dCn != null)
			dCn.closeCn();
	}
%>
