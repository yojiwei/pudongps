<%@page contentType="text/html; charset=GBK"%>
<%@include file="../../manage/head.jsp"%>
<%
	String OPType = CTools.dealString(request.getParameter("OPType")).trim();
	String ct_id = CTools.dealString(request.getParameter("ct_id")).trim();
	String cna_id = CTools.dealString(request.getParameter("cna_id")).trim();
	
	//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 
	
	String sql = "delete from tb_countnewsabout where cna_id = " + cna_id;
	dImpl.executeUpdate(sql);
	
	dImpl.closeStmt();
	dCn.closeCn();
%>
<script language="javascript">
	alert("删除成功！");
	opener.location.reload();
	location.href="publishListAbout.jsp?ct_id=<%=ct_id%>&OPType=<%=OPType%>";
</script>
<%


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