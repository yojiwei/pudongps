<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%
String iid = (String)request.getParameter("iid");
CDataCn dCn = null;
CDataImpl dImpl = null;
try{
	dCn = new CDataCn();
	dImpl = new CDataImpl(dCn);
	SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	
	dImpl.edit("infoopen", "id", iid);
	dImpl.setValue("status", "1", CDataImpl.STRING);
	dImpl.setValue("applytime",df.format(new java.util.Date()),CDataImpl.DATE);
	dImpl.update();

%>
		<script language="javascript">
			alert("操作已成功！");		
			window.location.reload("taskList.jsp");
		</script>
<%

}catch(Exception e){
	out.print(e.toString());
}finally{
	dImpl.closeStmt();
	dCn.closeCn(); 
}
%>
<%@include file="/system/app/skin/bottom.jsp"%>