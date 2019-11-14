<%@ page contentType="text/html; charset=GBK" %>
<%@include file="/system/app/skin/import.jsp"%>
<%
String pr_id = "";
String [] pl_id = null;
pr_id = CTools.dealString(request.getParameter("pr_id")).trim();
pl_id = request.getParameterValues("del");
CDataCn dCn = null;
CDataImpl dImpl = null;
try{
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