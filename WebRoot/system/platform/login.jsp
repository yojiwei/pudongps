<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/import.jsp"%>
<%
CDataCn dCn = null;
CManager manager = null;
try{
	dCn = new CDataCn();
	manager = new CManager(dCn);
String uid = CTools.dealString(request.getParameter("UI_name")).trim();
String pwd = CTools.dealString(request.getParameter("UI_password")).trim();
String operate = CTools.dealString(request.getParameter("operate")).trim();
int flag = manager.login(uid,pwd);
 
if(flag == 1 ) {
  session.setAttribute("manager",manager);
  if("login".equals(operate))
  	response.sendRedirect("/system/platform/main.jsp");
  if("update".equals(operate))
  	response.sendRedirect("/system/platform/updateMessage.jsp");
} else if(flag ==0) {
  session.removeAttribute("manager"); //清除变量
%>
  <script language="javascript">
  alert("用户名或密码错误！");
  window.location="/system/platform/index.jsp";
	</script>
<%
}else if(flag == -1){
	session.removeAttribute("manager"); //清除变量
%>
	<script type="text/javascript">
	<!--
		alert("密码已过期，请联系管理员！");
  		window.location="/system/platform/index.jsp";
	//-->
	</script>
<%
	}else if(flag == -3){
	session.removeAttribute("manager"); //清除变量
%>
	<script type="text/javascript">
	<!--
		alert("帐号已被管理员停用，请联系管理员！");
  		window.location="/system/platform/index.jsp";
	//-->
	</script>
<%
	}
manager.closeStmt();
dCn.closeCn();
} catch (Exception ex) {
	System.out.println(new java.util.Date() + "--"
			+ request.getServletPath() + " : " + ex.getMessage());
} finally {
	if(manager != null)
	manager.closeStmt();
	if(dCn != null)
	dCn.closeCn();
}
%>