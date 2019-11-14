<%@ page contentType="text/html; charset=GBK" %>
<%@include file="/system/app/skin/import.jsp"%>
<%
String pr_id = "";
String [] pl_id = null;
pr_id = CTools.dealString(request.getParameter("pr_id")).trim();
pl_id = request.getParameterValues("del");

//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 
dCn.beginTrans();
if (pl_id.length>0)
{
	for (int i=0;i<pl_id.length;i++)
	{
		dImpl.delete("tb_proceedlaw","pl_id",pl_id[i]);
	}
}

if (dCn.getLastErrString().equals(""))
{
	dCn.commitTrans();
}
else
{
	%>
	<script language="javascript">
	alert("<%=dCn.getLastErrString()%>");
	</script>
	<%
	dCn.rollbackTrans();
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
<script language="javascript">
window.location.href="ProceedLawInfo.jsp?pr_id=<%=pr_id%>";
</script>