<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%
//by ph 2007-3-3  信息公开一体化
String dt_id = "";
String [] id = request.getParameterValues("checkdel");
String goto_url = "";
if (id.length == 1) {
	goto_url = "taskInfo.jsp?iid="+id[0];
}
else {
	goto_url = "taskList.jsp";
}

CDataCn dCn = null;
CDataImpl dImpl = null;

try{
	dCn = new CDataCn();
	dImpl = new CDataImpl(dCn);

	SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	CMySelf mySelf = (CMySelf)session.getAttribute("mySelf");
	if (mySelf!=null){
		dt_id = Long.toString(mySelf.getDtId());
	}

	dCn.beginTrans();

	
	for (int i=0;i<id.length;i++){
		dImpl.setTableName("taskcenter");
		dImpl.setPrimaryFieldName("id");
		dImpl.addNew();
		dImpl.setValue("iid",id[i],CDataImpl.INT);
		dImpl.setValue("did",dt_id,CDataImpl.INT);
		dImpl.setValue("starttime",df.format(new java.util.Date()),CDataImpl.DATE);
		dImpl.setValue("status","0",CDataImpl.INT);
		dImpl.setValue("isovertime","0",CDataImpl.INT);
		dImpl.setValue("genre","认领",CDataImpl.STRING);
		dImpl.update();
		
		dImpl.edit("infoopen","id",Integer.parseInt(id[i]));
		dImpl.setValue("status","1",CDataImpl.INT);
		dImpl.update();
	}

	if (dCn.getLastErrString().equals("")){
		dCn.commitTrans();
%>
		<script language="javascript">
			alert("操作已成功！");		
			window.location="<%=goto_url%>";
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