<%@ page import="com.component.database.*"%>
<%@ page import="com.component.treeview.*"%>
<%@ page import="com.platform.meta.*"%>
<%@ page import="com.platform.module.*"%>
<%@ page import="com.platform.subject.*"%>
<%@ page import="com.platform.user.*"%>
<%@ page import="com.platform.role.*"%>
<%@ page import="com.platform.log.*"%>
<%@ page import="java.util.*"%>
<%@ page import="com.util.CTools"%>
<%@ page import="com.util.*"%>
<%@ page import="java.net.*"%>
<%@ page import="java.io.*"%>
<%
	String[] sqlStr = null;
	String[] sel = request.getParameterValues("sel");
	String strSelectIds = "";
	if (sel != null) {
		for (int i = 0; i < sel.length; i++) {
			strSelectIds += sel[i] + ",";
		}
		if (strSelectIds.length() > 0) {
			strSelectIds = "," + strSelectIds;
		}
		CDataCn dCn = new CDataCn();
		CDataControl dCtrl = new CDataControl(dCn);
		try {
			dCn = new CDataCn();
			dCtrl = new CDataControl(dCn);
			dCn.beginTrans();

			if (strSelectIds.indexOf(",1,") >= 0)//清空前台用户表
			{
		sqlStr = new String[1];
		sqlStr[0] = "delete from tb_user";
		dCtrl.executeQuery(sqlStr[0]);
			}
			if (strSelectIds.indexOf(",2,") >= 0)//清空部门（包括用户）
			{
		sqlStr = new String[2];
		sqlStr[0] = "delete from tb_userinfo";
		sqlStr[1] = "delete from tb_deptinfo where dt_id<>1";
		for (int i = 0; i < sqlStr.length; i++) {
			dCtrl.executeQuery(sqlStr[i]);
		}
			}
			if (strSelectIds.indexOf(",3,") >= 0)//清空网上办事及相关表单（如崔办、督办、协调等）
			{
		sqlStr = new String[8];
		sqlStr[0] = "delete from TB_CORRESPONDFROZEN"; //清空协调单冻结表
		sqlStr[1] = "delete from TB_CORRESPOND"; //清空协调单表
		sqlStr[2] = "delete from tb_urgent"; //清空催办表
		sqlStr[3] = "delete from tb_supervise"; //清空督办表
		sqlStr[4] = "delete from TB_DOCUMENTEXCHANGE"; //清空文件交换箱表
		sqlStr[5] = "delete from tb_workattach"; //清空办事附件表
		sqlStr[6] = "delete from tb_workfrozen"; //清空项目冻结表
		sqlStr[7] = "delete from tb_work"; //清空网上办事表
		for (int i = 0; i < sqlStr.length; i++) {
			dCtrl.executeQuery(sqlStr[i]);
		}
			}
			if (strSelectIds.indexOf(",4,") >= 0)//清空监督投诉表  （等待张志强完成）
			{
		sqlStr = new String[1];
		sqlStr[0] = "delete from tb_connwork";
		dCtrl.executeQuery(sqlStr[0]);
			}

			if (dCn.getLastErrString().equals(""))//如果没有异常出现，那么提交sql语句；否则回滚事务
		dCn.commitTrans();
			else
		dCn.rollbackTrans();
			dCtrl.closeStmt();
			dCn.closeCn();
		} catch (Exception ex) {
			System.out.println(new java.util.Date() + "--"
			+ request.getServletPath() + " : "
			+ ex.getMessage());
		} finally {
			if (dCtrl != null)
		dCtrl.closeStmt();
			if (dCn != null)
		dCn.closeCn();
		}
	}
%>
<script language="javascript">
window.history.go(-1);
</script>
