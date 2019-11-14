<%@ page contentType="text/html; charset=GBK" %>
<%@include file="../skin/head.jsp"%>
<%@page import="java.sql.*"%>
<%@page import="java.io.*"%>
<%@page import="java.util.*"%>
<%@page import="com.component.database.*"%>
<%@page import="com.util.*"%>
<%@page import="com.website.*"%>
<%
String us_uid="";
String us_id="";
String us_isok = "";
String us_password="";
String today = "";
String pudongus_id = "";

us_id=CTools.dealNull(request.getParameter("us_id")).trim();
pudongus_id=CTools.dealNull(request.getParameter("pudongus_id")).trim();
us_uid=CTools.dealNull(request.getParameter("us_uid")).trim();
us_password=CTools.dealNull(request.getParameter("newpassword")).trim();
us_isok=CTools.dealNull(request.getParameter("us_isok")).trim();
today = new CDate().getThisday();
//casso data
MyCDataCn mydCn = null;
MyCDataImpl mydImpl = null;
//pudong data 20090319
CDataCn dCn = null;
CDataImpl dImpl = null;
try {
//浦东数据库
mydCn = new MyCDataCn();
mydImpl = new MyCDataImpl(mydCn); 
//CASSO数据库
dCn = new CDataCn();
dImpl = new CDataImpl(dCn);

	 CassoUser us = new CassoUser(mydCn);
	 us.setId(us_id);
	 us.setPwd(us_password);
	 us.setRegdate(today);
	 us.setIsok(us_isok);
	 us.updateUser();
	 us.setLogin(true);
	 
	 User pudongus = new User(dCn);
	 pudongus.setId(pudongus_id);
	 pudongus.setUid(us_uid);
	 pudongus.setPwd(us_password);
	 pudongus.updateUser();
	 pudongus.setLogin(true);
	 
	 /*mydImpl.edit("tb_user", "us_uid",us_uid);
	 mydImpl.setValue("us_pwd",us_password,MyCDataImpl.STRING);//pudong user password
	 mydImpl.update();*/
	 
  } catch (Exception ex) {
	System.out.println(new java.util.Date() + "--"
			+ request.getServletPath() + " : " + ex.getMessage());
} finally {
	if(mydImpl != null)
		mydImpl.closeStmt();
	if(dImpl != null)
		dImpl.closeStmt();
	if(mydCn != null)
		mydCn.closeCn();
	if(dCn != null)
		dCn.closeCn();
}
  response.sendRedirect("UserList1.jsp");
%>
<%@include file="../skin/bottom.jsp"%>
