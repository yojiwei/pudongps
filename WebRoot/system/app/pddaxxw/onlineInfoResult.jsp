<%@ page contentType="text/html; charset=GBK" %>
<%@include file="../skin/head.jsp"%>
<%
//update 20091113

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象
String dx_id="";
String back_con="";
String dx_type = "";
try {
dCn = new CDataCn(); 
dImpl = new CDataImpl(dCn); 

dx_id = CTools.dealString(request.getParameter("dx_id")).trim();
back_con = CTools.dealString(request.getParameter("back_con")).trim();
dx_type = CTools.dealString(request.getParameter("dx_type")).trim();


	dImpl.edit("tb_daxx","dx_id",dx_id);
	dImpl.setValue("dx_status","1",CDataImpl.STRING);
	dImpl.setValue("dx_backcontent",back_con,CDataImpl.STRING);
	dImpl.update();

} catch (Exception ex) {
	System.out.println(new java.util.Date() + "--"
			+ request.getServletPath() + " : " + ex.getMessage());
} finally {
	if(dImpl != null)
	dImpl.closeStmt();
	if(dCn != null)
	dCn.closeCn();
}
if("apply".equals(dx_type)){
%>
<script language="javascript">
window.location.href="onlineList.jsp";
</script>
<%}else{
%>
<script language="javascript">
window.location.href="onlineAskList.jsp?clstatus=0";
</script>
<%}%>
<%@include file="../skin/bottom.jsp"%>