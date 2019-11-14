<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%@page import="com.util.*"%>
<%@page import="Evaluate.*"%>
<%@page import="vote.*"%>
<%
//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 


String jd_id = "";

jd_id = CTools.dealString(request.getParameter("jd_id")).trim();


%>
	<script language="javascript">
		//alert("删除已成功");
	<%
	if(treeid.equals(""))
	{
	%>
		window.location.href="list.jsp?upperid=<%=upperid%>";
	<%
	}
	else
	{
	%>
	window.location.href="listtree.jsp?treeid=<%=treeid%>";
	<%
	}	
	%>
	</script>
<%
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