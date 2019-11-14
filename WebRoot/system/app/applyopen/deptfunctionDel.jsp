<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%
//by ph 2007-3-3  信息公开一体化
String id = "";

CDataCn dCn = null;
CDataImpl dImpl = null;

try{
	dCn = new CDataCn();
	dImpl = new CDataImpl(dCn);

	id = CTools.dealString(request.getParameter("id")).trim();

	dCn.beginTrans();
	
	if(!id.equals("")){
		dImpl.executeUpdate("delete from deptfunction where id = " + id);
	}

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