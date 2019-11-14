<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="../head.jsp" %>
<%
String tr_id=""; //½ÇÉ«id
String sql = "";
String deptIds = "";
String userIds = "";
String url = "";
long id;

tr_id   = CTools.dealNumber(request.getParameter("tr_id"));
deptIds = request.getParameter("userDirIds");
userIds = request.getParameter("userFileIds");
//out.println(deptIds+"==");
//out.println(userIds);

CDataCn dCn = null;
		CRoleInfo jdo = null;
		try{
			dCn = new CDataCn();
			jdo = new CRoleInfo(dCn);
id  = java.lang.Long.parseLong(tr_id);
jdo.setUsers(id,deptIds,userIds);
//out.print("OK");
%>

<%
jdo.closeStmt();
dCn.closeCn();

url = "roleUserInfo.jsp?tr_id="+tr_id;
response.sendRedirect(url);
} catch (Exception ex) {
	System.out.println(new java.util.Date() + "--"
			+ request.getServletPath() + " : " + ex.getMessage());
} finally {
	if(jdo != null)
	jdo.closeStmt();
	if(dCn != null)
	dCn.closeCn();
}
%>

