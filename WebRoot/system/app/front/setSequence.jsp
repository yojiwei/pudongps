<%@ page contentType="text/html; charset=GBK" %>
<%@include file="/system/app/skin/import.jsp"%>

<%
	boolean t = false;
	CDataCn  dCn_se = new CDataCn();
	CDataImpl jdo_se = new CDataImpl(dCn_se);
	//update20080122

try {
 dCn_se = new CDataCn(); 
 jdo_se = new CDataImpl(dCn_se); 
	String list_id = CTools.dealString(request.getParameter("list_id")).trim();
	String type = CTools.dealString(request.getParameter("type")).trim();

	jdo_se.setTableName("tb_frontsubject");
    jdo_se.setPrimaryKeyType(CDataImpl.PRIMARY_KEY_IS_VARCHAR);
	jdo_se.setPrimaryFieldName("fs_id");
	t = jdo_se.setSequence("subject","fs_sequence",request);

	jdo_se.setTableName("tb_frontinfo");
    jdo_se.setPrimaryKeyType(CDataImpl.PRIMARY_KEY_IS_VARCHAR);
	jdo_se.setPrimaryFieldName("fi_id");
	t = jdo_se.setSequence("info","fi_sequence",request);
    
	dCn_se.closeCn();
	if(type.equals("2")) {
		response.sendRedirect("frontRadioList.jsp?list_id="+list_id);
	} else {
		response.sendRedirect("frontSubjectList.jsp?list_id="+list_id);
	}
	} catch (Exception ex) {
	System.out.println(new java.util.Date() + "--"
			+ request.getServletPath() + " : " + ex.getMessage());
} finally {
	if(jdo_se != null)
	jdo_se.closeStmt();
	if(dCn_se != null)
	dCn_se.closeCn();
}
%>
