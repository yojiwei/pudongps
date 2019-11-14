<%@ page contentType="text/html; charset=GBK" %>
<%@include file="../skin/head.jsp"%>
<%@page import="java.sql.*"%>
<%@page import="java.io.*"%>
<%@page import="java.util.*"%>
<%@page import="com.component.database.*"%>
<%@page import="com.util.*"%>
<%@page import="com.website.*"%>

<%
String us_id="";
String us_name="";
String us_uid  = "";
String us_pwd = "";
String optype = "";

us_name=CTools.dealString(request.getParameter("us_name")).trim();
us_pwd=CTools.dealNumber(request.getParameter("us_pwd")).trim();
us_uid=CTools.dealString(request.getParameter("us_uid")).trim();
us_id=CTools.dealString(request.getParameter("us_id")).trim();
optype=CTools.dealString(request.getParameter("optype")).trim();

//
MD5 md = new MD5();
us_pwd = md.getMD5ofStr(us_pwd);

CDataCn dCn = null;
CDataImpl dImpl = null;
try {
dCn = new CDataCn("pddjw"); 
dImpl = new CDataImpl(dCn); 


	if(optype.equals("Add")){
		String usercheckSql = "select us_id from forum_user where us_uid = '"+us_uid+"'";
		Hashtable content = (Hashtable)dImpl.getDataInfo(usercheckSql);
		if(content!=null){
			out.print("<script>alert('µÇÂ¼ÃûÖØ¸´!');window.location.href='UserList.jsp';</script>");
			return;
		}
		
		dImpl.setTableName("forum_user");
		dImpl.setPrimaryFieldName("us_id");
		dImpl.addNew();
	}else if(optype.equals("Edit")){
		dImpl.edit("forum_user","us_id",us_id);
	}
		dImpl.setValue("us_uid",us_uid,CDataImpl.STRING);
		dImpl.setValue("us_pwd",us_pwd,CDataImpl.STRING);
		dImpl.setValue("us_name",us_name,CDataImpl.STRING);
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
  response.sendRedirect("UserList.jsp");
  
%>

<%@include file="../skin/bottom.jsp"%>
