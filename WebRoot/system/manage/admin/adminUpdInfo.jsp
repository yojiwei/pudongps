<%@ page contentType="text/html; charset=GBK"%>
<%@ page import="com.util.CTools"%>
<%@ page import="java.util.Hashtable"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="com.component.database.CDataCn"%>
<%@ page import="com.platform.admin.CAdminInfo"%>
<%
		String at_loginname = ""; //注册名
		String at_passwordOld = ""; //原密码
		String at_password = ""; //密码
		String at_realname = ""; //姓名
		String at_nickname = ""; //昵称
		int cnt = 0; //统计记录条数

		String sql = "";
		CTools tools = null;
		ResultSet rs = null;
		String msg = "修改注册信息";
		long id;

		tools = new CTools();
		CDataCn dCn = new CDataCn();
		CAdminInfo jdo = new CAdminInfo();
		try{
			dCn = new CDataCn();
            jdo = new CAdminInfo();
		at_loginname = tools.dealString(request.getParameter("AT_loginname"));
		at_passwordOld = tools.dealString(request
				.getParameter("AT_passwordOld"));
		at_password = tools.dealString(request.getParameter("AT_password"));
		at_realname = tools.dealString(request.getParameter("AT_realname"));
		at_nickname = tools.dealString(request.getParameter("AT_nickname"));

		sql = "select count(*) as cnt from tb_administrator where AT_LOGINNAME = '"
				+ at_loginname + "' and AT_PASSWORD = '" + at_passwordOld + "'";
		rs = jdo.executeQuery(sql);
		if (rs.next()) {
			cnt = rs.getInt("cnt");
			if (cnt == 0) {

			%>
				<script type="text/javascript">
				<!--
					alert('原密码错误！');
					history.back();
				//-->
				</script>
<%} else {
				sql = " UPDATE TB_ADMINISTRATOR SET AT_PASSWORD = '"
						+ at_password + "',AT_REALNAME = '" + at_realname
						+ "'," + " AT_NICKNAME = '" + at_nickname
						+ "' WHERE AT_LOGINNAME = '" + at_loginname + "' ";
				id = jdo.executeUpdate(sql);
				jdo.closeStmt();
				dCn.closeCn();
				if (id != -1) {
					msg += "成功！";
%>
			<script type="text/javascript">
			<!--
				alert('<%= msg %>');
				window.location="/system/platform/main.jsp";
			//-->
			</script>
<%
				} else {
					msg += "失败！";
%>
<script type="text/javascript">
			<!--
				alert('<%= msg %>');
				history.back();
			//-->
			</script>
<%
				}
			}
		}
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

