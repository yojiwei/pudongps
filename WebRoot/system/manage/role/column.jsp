<%@ page contentType="text/html; charset=GBK"%>
                   <tr class="igray" height="3">
                      <td width="100%" align="left" colspan="2">
                                <a href="roleInfo.jsp?tr_id=<%=tr_id%>">基本</a>&nbsp;&nbsp;
                                <a href="roleModuleInfo.jsp?tr_id=<%=tr_id%>">权限</a>&nbsp;&nbsp;
                                <a href="roleSubjectImportInfo.jsp?tr_id=<%=tr_id%>">导入权限</a>&nbsp;&nbsp;
<%
CDataCn  dCn1 = null;
CRoleAccess ado1=null; 
try{
	dCn1 = new CDataCn();
	ado1=new CRoleAccess(dCn1); 
CMySelf self1 = (CMySelf)session.getAttribute("mySelf");
String user_id1 = String.valueOf(self1.getMyID());

boolean isAdmin1=ado1.isAdmin(user_id1);
if(isAdmin1){
%>
                                <a href="roleUserInfo.jsp?tr_id=<%=tr_id%>">用户</a>&nbsp;&nbsp;
                                |&nbsp;&nbsp;
                                <a href="roleOrgInfo.jsp?tr_id=<%=tr_id%>">机构</a>&nbsp;&nbsp;
                                <a href="roleFunctionsInfo.jsp?tr_id=<%=tr_id%>">模块</a>&nbsp;&nbsp;
                                <a href="roleMetaInfo.jsp?tr_id=<%=tr_id%>">字典</a>&nbsp;&nbsp;
  															<!--a href="roleAuditInfo.jsp?tr_id=<%=tr_id%>">审核</a>&nbsp;&nbsp;-->
<%
}
dCn1.closeCn();
%>
                                <a href="roleSubjectInfo.jsp?tr_id=<%=tr_id%>">栏目</a>&nbsp;&nbsp;

                                <span style="color:red"></span>
                      </td>
                   </tr>


<%


} catch (Exception ex) {
	System.out.println(new java.util.Date() + "--"
			+ request.getServletPath() + " : " + ex.getMessage());
} finally {
	if(ado1 != null)
	ado1.closeStmt();
	if(dCn1 != null)
	dCn1.closeCn();
}

%>