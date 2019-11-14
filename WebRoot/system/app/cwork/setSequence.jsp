<%@ page contentType="text/html; charset=GBK" %>
<%@include file="/system/app/skin/import.jsp"%>

<%
        boolean t = false;
        CDataCn  dCn_se = null;
        CDataImpl jdo_se = null;
        try{
        
   dCn_se = new CDataCn();
         jdo_se = new CDataImpl(dCn_se);
	jdo_se.setTableName("tb_commonwork");
        jdo_se.setPrimaryKeyType(CDataImpl.PRIMARY_KEY_IS_VARCHAR);
	jdo_se.setPrimaryFieldName("cw_id");
        t = jdo_se.setSequence("module","cw_sequence",request);
        dCn_se.closeCn();
        
} catch (Exception ex) {
	System.out.println(new java.util.Date() + "--"
			+ request.getServletPath() + " : " + ex.getMessage());
} finally {
	if(jdo_se != null)
	jdo_se.closeStmt();
	if(dCn_se != null)
	dCn_se.closeCn();
}
	response.sendRedirect("CommonWorkList.jsp");
%>
