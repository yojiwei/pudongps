<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%
//update by 20090429
CDataCn dCn = null;   //新建数据库连接对象
CDataImpl dImpl = null;  //新建数据接口对象
String OPType = "";
String path = "";
String us_id = "";
String us_sso = "";
String ui_id = "";
String ui_uid = "";
try {
	dCn = new CDataCn(); 
	dImpl = new CDataImpl(dCn); 

	us_id = CTools.dealString(request.getParameter("us_id")).trim();
	OPType = CTools.dealString(request.getParameter("OPType")).trim();
	us_sso = CTools.dealString(request.getParameter("us_sso")).trim();
	ui_uid = CTools.dealString(request.getParameter("ui_uid")).trim();
	
	String uiSql = "select ui_id from tb_userinfo where ui_uid = '"+ui_uid+"'";
	Hashtable content=dImpl.getDataInfo(uiSql);
	if(content!=null){
		ui_id = CTools.dealNull(content.get("ui_id"));
	}
	
	dImpl.setTableName("tb_usersso");
	dImpl.setPrimaryFieldName("us_id");
	if (OPType.equals("Addnew")){
		dImpl.addNew();
	}else if(OPType.equals("Edit")){
		dImpl.edit("tb_usersso","us_id",Integer.parseInt(us_id));
	}
	dImpl.setValue("us_sso",us_sso,CDataImpl.STRING);
	dImpl.setValue("ui_id",ui_id,CDataImpl.STRING);
	dImpl.update() ;

	if (dCn.getLastErrString().equals("")){
		dCn.commitTrans();
		%>
		<script language="javascript">
			window.location.href="SSOUserList.jsp";
		</script>
		<%
	}else{
		dCn.rollbackTrans();
		%>
		<script language="javascript">
			alert("发生错误，录入失败！");
			window.history.go(-1);
		</script>
		<%
	}
} catch (Exception ex) {
	System.out.println(new java.util.Date() + "--"
			+ request.getServletPath() + " : " + ex.getMessage());
} finally {
	if(dImpl != null)
		dImpl.closeStmt();
	if(dCn != null)
		dCn.closeCn();
}

%>