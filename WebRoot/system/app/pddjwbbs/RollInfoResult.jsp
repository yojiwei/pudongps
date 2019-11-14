<%@ page contentType="text/html; charset=GBK" %>
<%@include file="../skin/head.jsp"%>
<%@page import="java.sql.*"%>
<%@page import="java.io.*"%>
<%@page import="java.util.*"%>
<%@page import="com.component.database.*"%>
<%@page import="com.util.*"%>
<%@page import="com.website.*"%>

<%
String ro_id="";
String ro_content  = "";
String optype = "";

ro_content=CTools.dealString(request.getParameter("ro_content")).trim();
ro_id=CTools.dealString(request.getParameter("ro_id")).trim();
optype=CTools.dealString(request.getParameter("optype")).trim();

CDataCn dCn = null;
CDataImpl dImpl = null;
try {
dCn = new CDataCn("pddjw"); 
dImpl = new CDataImpl(dCn); 


	if(optype.equals("Add")){
		
		dImpl.setTableName("forum_roll");
		dImpl.setPrimaryFieldName("ro_id");
		dImpl.addNew();
	}else if(optype.equals("Edit")){
		dImpl.edit("forum_roll","ro_id",ro_id);
	}
		dImpl.setValue("ro_content",ro_content,CDataImpl.STRING);
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
response.sendRedirect("RollList.jsp");
%>

<%@include file="../skin/bottom.jsp"%>
