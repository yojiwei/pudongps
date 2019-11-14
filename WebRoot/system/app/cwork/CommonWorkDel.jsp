<%@page contentType="text/html; charset=GBK"%>
<%@include file="../skin/import.jsp"%>
<%
String workId = CTools.dealString(request.getParameter("workId")).trim();
String sql = "delete from tb_commonwork where cw_id = '" + workId + "'";

//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 


dCn.beginTrans();

if(!workId.equals("")) {
	dImpl.executeUpdate(sql);
	if (dCn.getLastErrString().equals("")) {
		dCn.commitTrans();
		%>
		<script language="javascript">
			alert("删除成功！");
			location.href="CommonWorkList.jsp";
		</script>
		<%
	}
	else {
		dCn.rollbackTrans();
		%>
		<script language="javascript">
			alert("删除过程中出现错误！");
			location.href="CommonWorkList.jsp";
		</script>
		<%
	}
}
dImpl.closeStmt();
dCn.closeCn();
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
<%@include file="../skin/bottom.jsp"%>


