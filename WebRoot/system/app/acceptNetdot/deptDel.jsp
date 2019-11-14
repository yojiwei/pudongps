<%@page contentType="text/html; charset=GBK"%>
<%@include file="../skin/head.jsp"%>

<%
CDataCn dCn = null;
CDataImpl dImpl = null;
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn);

String dt_id = CTools.dealString(request.getParameter("dt_id"));

dCn.beginTrans();
dImpl.executeUpdate("delete from tb_departinfo where dt_id="+dt_id);

if (dCn.getLastErrString().equals(""))
	{
		
		dCn.commitTrans();
%>
		<script language="javascript">
			alert("删除已成功！");
			window.location="deptList.jsp";
		</script>
<%
	}
else
	{
		dCn.rollbackTrans();
%>
		<script language="javascript">
			alert("发生错误，删除失败！");
			window.history.go(-1);
		</script>
<%
	}
}
catch(Exception e){
//e.printStackTrace();
out.print(e.toString());
}
finally{
dImpl.closeStmt();
dCn.closeCn(); 
}	

%>