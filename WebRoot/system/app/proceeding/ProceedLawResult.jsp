<%@ page contentType="text/html; charset=GBK" %>
<%@include file="/system/app/skin/import.jsp"%>
<%
String pr_id = "";
String pr_name = "";
String categoryId = "";
String contentIds = "";
String [] idSet = null;
String sqlStr = "";

pr_id = CTools.dealString(request.getParameter("pr_id")).trim();
pr_name = CTools.dealString(request.getParameter("pr_name")).trim();
contentIds = CTools.dealString(request.getParameter("selectedContent")).trim();
categoryId = CTools.dealString(request.getParameter("category")).trim();

if (!contentIds.equals(""))
{
	idSet = CTools.split(contentIds,",");
}
//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 
dCn.beginTrans();

for (int i=0;i<idSet.length;i++)
{
	sqlStr = "select pl_id from tb_proceedlaw where pr_id='"+pr_id+"'and contentid="+idSet[i]+" and categoryid="+categoryId;
	Hashtable content = dImpl.getDataInfo(sqlStr);
	if (content!=null)
	{
		//不处理
	}
	else
	{
		dImpl.addNew("tb_proceedlaw","pl_id",CDataImpl.PRIMARY_KEY_IS_VARCHAR);
		dImpl.setValue("pr_id",pr_id,CDataImpl.STRING);
		dImpl.setValue("pr_name",pr_name,CDataImpl.STRING);
		dImpl.setValue("contentid",idSet[i],CDataImpl.INT);
		dImpl.setValue("categoryid",categoryId,CDataImpl.INT);
		dImpl.update();
	}
}
if (dCn.getLastErrString().equals(""))
{
	%>
	<script language="javascript">
	alert("记录已写入！");
	</script>
	<%
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
window.history.go(-1);
</script>