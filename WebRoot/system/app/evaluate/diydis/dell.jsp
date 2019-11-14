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
Hashtable content_del = new Hashtable();
String id = "";
String upperid = "";
String type = "";
String treeid = "";
String vde_status = "";
String Typepp = "";
id = CTools.dealString(request.getParameter("upperid")).trim();
upperid = CTools.dealString(request.getParameter("editid")).trim();
upperid = CTools.dealString(request.getParameter("editid")).trim();
vde_status = CTools.dealString(request.getParameter("vde_status")).trim();
Typepp = CTools.dealString(request.getParameter("Typepp")).trim();
String sql="select * from tb_votediy t where t.vt_upperid='"+upperid+"'";
Vector vectors1 = dImpl.splitPage(sql,request,20);
if(vectors1!=null)
{
out.print("<script language='javascript'>alert(\"栏目下有子栏目存在，请先删除子栏目!\");window.history.go(-1);</script>");
}
else
{
dImpl.delete("tb_votediy","vt_id",upperid);
dImpl.update();
%>
	<script language="javascript">
		alert("删除成功");
		//window.location.href="list.jsp?vde_status="+vde_status+"&upperid="+id+"";
		window.location.href="list.jsp?upperid=<%=id%>&Typepp=<%=Typepp%>";
		//window.history.go(-2);
	</script>
<%
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