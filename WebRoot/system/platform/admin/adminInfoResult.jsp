<%@ page contentType="text/html; charset=GBK"%>
<%@ page import="com.util.CTools"%>
<%@ page import="java.util.Hashtable"%>
<%@ page import="com.component.database.CDataCn"%>
<%@ page import="com.platform.admin.CAdminInfo"%>
<%
		String at_loginname = ""; //注册名
		String at_password = ""; //密码
		String at_realname = ""; //姓名
		String at_nickname = ""; //昵称
		String at_purviewLevel = "1"; //权限等级
		String at_ic = ""; //IC卡号
		String at_isactive = ""; //是否启用
		String at_remark = ""; //描述
		String operate = ""; //操作类型
		String at_orgid = ""; //用户
		String at_module = ""; //模块
		String at_subject = ""; //栏目
		String at_managelvl = ""; //后台权限
		String at_id = "0";
		String url = request.getContextPath() + "adminList.jsp";
		String sql = "";
		CTools tools = null;
		String msg = "";
		long id;

		tools = new CTools();
		CDataCn dCn = null;
		CAdminInfo jdo = null;
		try{
			dCn = new CDataCn();
			jdo = new CAdminInfo();

		at_loginname = tools.dealString(request.getParameter("AT_loginname"));
		at_password = tools.dealString(request.getParameter("AT_password"));
		at_realname = tools.dealString(request.getParameter("AT_realname"));
		at_nickname = tools.dealString(request.getParameter("AT_nickname"));
		at_ic = tools.dealString(request.getParameter("AT_ic"));
		at_isactive = tools.dealNumber(request.getParameter("AT_isactive"));
		at_remark = tools.dealString(request.getParameter("AT_remark"));
		operate = tools.dealString(request.getParameter("type"));
		at_orgid = tools.dealString(request.getParameter("AT_orgname")).replaceAll(",","");
		at_module = tools.dealString(request.getParameter("AT_module")).replaceAll(",","");
		at_subject = tools.dealString(request.getParameter("AT_subject")).replaceAll(",","");
		at_managelvl = tools.dealString(request.getParameter("at_managelvlH"));
		if ("ADD".equals(operate)) {
			msg = "新增管理员";
			sql = " SELECT * FROM TB_ADMINISTRATOR WHERE AT_LOGINNAME = '"
					+ at_loginname + "' ";
			Hashtable rs = jdo.getDataInfo(sql);
			if (rs != null && rs.get("at_loginname") != null) {

			%>
<script type="text/javascript">
<!--
	alert("注册名已被占用，请更改！");
	history.back();
//-->
</script>
<%} else {
				sql = " SELECT MAX(AT_ID) AS AT_ID FROM TB_ADMINISTRATOR ";
				at_id = jdo.getDataInfo(sql).get("at_id").toString();
				at_id = String.valueOf(Integer
						.parseInt(tools.dealNumber(at_id)) + 1);
				sql = " INSERT INTO TB_ADMINISTRATOR (AT_ID,AT_LOGINNAME,AT_PASSWORD,AT_REALNAME,AT_NICKNAME,AT_ISACTIVE,"
						+ " PURVIEWLEVEL,AT_REMARK,AT_IC,AT_ORGNAME,AT_MODULE,AT_SUBJECT,AT_MANAGELVL) VALUES ( '"
						+ at_id
						+ "','"
						+ at_loginname
						+ "','"
						+ at_password
						+ "',"
						+ " '"
						+ at_realname
						+ "','"
						+ at_nickname
						+ "','"
						+ at_isactive
						+ "','"
						+ at_purviewLevel
						+ "',"
						+ " '"
						+ at_remark
						+ "','"
						+ at_ic
						+ "','"
						+ at_orgid
						+ "','"
						+ at_module
						+ "','"
						+ at_subject
						+ "','"
						+ at_managelvl
						+ "') ";
			}
		} else if ("UPD".equals(operate)) {
			msg = "修改管理员";
			sql = " SELECT * FROM TB_ADMINISTRATOR WHERE AT_LOGINNAME = '"
					+ at_loginname + "' ";
			Hashtable rs = jdo.getDataInfo(sql);
			if (rs == null || rs.get("at_loginname") == null) {

			%>
			<script type="text/javascript">
			<!--
				alert("没有该用户，请确认用户名！");
				history.back();
			//-->
			</script>
			<%} else {
				sql = " UPDATE TB_ADMINISTRATOR SET AT_PASSWORD = '"
						+ at_password + "',AT_REALNAME = '" + at_realname
						+ "'," + " AT_NICKNAME = '" + at_nickname
						+ "',AT_ISACTIVE = '" + at_isactive
						+ "',PURVIEWLEVEL = '" + at_purviewLevel + "',"
						+ " AT_REMARK = '" + at_remark + "',AT_IC = '" + at_ic
						+ "',AT_ORGNAME = '" + at_orgid + "', AT_LOGINDATE = SYSDATE,"
						+ " AT_MODULE = '" + at_module + "', AT_SUBJECT = '"+ at_subject +"' "
						+ " ,AT_MANAGELVL = '"+ at_managelvl +"' "
						+ " WHERE AT_LOGINNAME = '" + at_loginname + "' ";
			}
		}

		id = jdo.executeUpdate(sql);
		if (id != -1) {
			msg += "成功！";

		} else {
			msg += "失败！";
		}

		%>
<script type="text/javascript">
	<!--
		alert('<%= msg %>');
	//-->
	</script>
<%jdo.closeStmt();
		dCn.closeCn();
	%>
<script LANGUAGE="javascript">
<!--
    top.left.location.reload();
    window.location='adminList.jsp';
//-->
</script>
<%


} catch (Exception ex) {
	System.out.println(new java.util.Date() + "--"
			+ request.getServletPath() + " : " + ex.getMessage());
} finally {
	if(jdo != null)
	jdo.closeStmt();
	if(dCn != null)
	dCn.closeCn();
}

%>
