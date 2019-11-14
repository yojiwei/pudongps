<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%
//by ph 2007-3-3  信息公开一体化
String id = "";
String did = "";
String dname = "";
String dfunction = "";
String OPType = "";

CDataCn dCn = null;
CDataImpl dImpl = null;

try{
	dCn = new CDataCn();
	dImpl = new CDataImpl(dCn);

	/*SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	CMySelf mySelf = (CMySelf)session.getAttribute("mySelf");
	if (mySelf!=null){
		dt_id = Long.toString(mySelf.getDtId());
	}*/

	OPType = CTools.dealString(request.getParameter("OPType")).trim();
	id = CTools.dealString(request.getParameter("id")).trim();
	did = CTools.dealString(request.getParameter("ModuleDirIds")).trim();
	dname = CTools.dealString(request.getParameter("Module")).trim();
	dfunction = CTools.dealString(request.getParameter("dfunction")).trim();

	dCn.beginTrans();
	
	if(OPType.equals("add")){
		dImpl.setTableName("deptfunction");
		dImpl.setPrimaryFieldName("id");
		dImpl.addNew();
	}else{
		dImpl.edit("deptfunction","id",Integer.parseInt(id));
	}
	dImpl.setValue("did",did,CDataImpl.INT);
	dImpl.setValue("dname",dname,CDataImpl.STRING);
	dImpl.setValue("dfunction",dfunction,CDataImpl.STRING);

	dImpl.update();

	if (dCn.getLastErrString().equals("")){
		dCn.commitTrans();
%>
		<script language="javascript">
			//alert("操作已成功！");		
			window.location="deptfunction.jsp";
		</script>
<%
	}else{
		dCn.rollbackTrans();
%>
		<script language="javascript">
			alert("发生错误，操作失败！");
			window.history.go(-1);
		</script>
<%
	}

}catch(Exception e){
	out.print(e.toString());
}finally{
	dImpl.closeStmt();
	dCn.closeCn(); 
}
%>
<%@include file="/system/app/skin/bottom.jsp"%>