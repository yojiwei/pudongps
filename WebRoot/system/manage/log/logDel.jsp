<%@ page contentType="text/html; charset=GBK" %>
<%@ page import="com.component.database.*" %>
<%@ page import="com.platform.log.*" %>
<%
  String url;
  CDataCn dCn = null;
  CLogInfo jdo = null;
  try{
  	dCn = new CDataCn();
  	jdo = new CLogInfo(dCn);
  jdo.clearLog(jdo.LOGIN);
  url = "logList.jsp";
  } catch (Exception ex) {
	System.out.println(new java.util.Date() + "--"
			+ request.getServletPath() + " : " + ex.getMessage());
} finally {
	if(jdo != null)
	jdo.closeStmt();
	if(dCn != null)
	dCn.closeCn();
}
  
  response.sendRedirect(url);
%>
