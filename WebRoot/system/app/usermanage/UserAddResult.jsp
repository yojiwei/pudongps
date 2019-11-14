<%@ page contentType="text/html; charset=GBK" %>
<%@include file="../skin/head.jsp"%>
<%@page import="java.sql.*"%>
<%@page import="java.io.*"%>
<%@page import="java.util.*"%>
<%@page import="com.component.database.*"%>
<%@page import="com.util.*"%>
<%@page import="com.website.*"%>
<%
String OPType="";
String us_uid="";
String us_name="";
String us_type="";
String us_email="";
String us_tel="";
String us_address="";
String us_id="";
String us_password="";
String us_isok="";
String ws_id = "";
String us_zip="";
String rt="";

rt=CTools.dealString(request.getParameter("rt")).trim();
OPType=CTools.dealString(request.getParameter("OPType")).trim();
us_uid=CTools.dealString(request.getParameter("us_uid")).trim();
us_name=CTools.dealString(request.getParameter("us_name")).trim();
us_type=CTools.dealString(request.getParameter("us_type")).trim();
us_email=CTools.dealString(request.getParameter("us_email")).trim();
us_tel=CTools.dealString(request.getParameter("us_tel")).trim();
us_address=CTools.dealString(request.getParameter("us_address")).trim();
us_id=CTools.dealString(request.getParameter("us_id")).trim();
us_password=CTools.dealString(request.getParameter("us_password")).trim();
us_isok=CTools.dealNumber(request.getParameter("us_active_flag")).trim();
us_zip=CTools.dealString(request.getParameter("us_zip")).trim();
ws_id=CTools.dealString(request.getParameter("ws_id")).trim();
us_idcardnumber=CTools.dealString(request.getParameter("us_idcardnumber")).trim();
out.println(rt);
//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 

User user = new User(dCn);
/*
if(OPType.equals("Add"))
  {

  dImpl.addNew("tb_user","us_id",CDataImpl.PRIMARY_KEY_IS_VARCHAR);

  }
  else if(OPType.equals("Edit")||OPType.equals("Check"))
	{
  	dImpl.edit("tb_user","us_id",us_id);
	}

  dImpl.setValue("us_name",us_name,CDataImpl.STRING);
  dImpl.setValue("uk_id",us_type,CDataImpl.STRING);
  dImpl.setValue("us_uid",us_uid,CDataImpl.STRING);
  dImpl.setValue("us_email",us_email,CDataImpl.STRING);
  dImpl.setValue("us_address",us_address,CDataImpl.STRING);
  dImpl.setValue("us_tel",us_tel,CDataImpl.STRING);
  dImpl.setValue("us_pwd",us_password,CDataImpl.STRING);
  dImpl.setValue("us_isok",us_isok,CDataImpl.INT);
  dImpl.setValue("us_zip",us_zip,CDataImpl.STRING);
  dImpl.setValue("ws_id",ws_id,CDataImpl.STRING);
  dImpl.update();
*/

user.setAddress(us_address);
user.setEmail(us_email);
user.setIstemp(us_isok);
user.setPwd(us_password);
user.setId(us_id);
user.setTel(us_tel);
user.setUid(us_uid);
user.setUserKind(us_type);
user.setUserName(us_name);
user.setWsid(ws_id);
user.setZip(us_zip);
user.set
if(OPType.equals("Add")){
	user.newUser();
} else (OPType.equals("Edit")||OPType.equals("Check")){
	user.updateUser();
}
%>
<%
  dImpl.closeStmt();
  dCn.closeCn();
  if(rt.equals("1"))
	{
	response.sendRedirect("UserList.jsp");
	}
  else response.sendRedirect("UserAdd.jsp?OPType=Add");
%>

<%@include file="../skin/bottom.jsp"%>
<%


} catch (Exception ex) {
	System.out.println(new java.util.Date() + "--"
			+ request.getServletPath() + " : " + ex.getMessage());
} finally {
	if(dImpl != null)
	dImpl.closeStmt();
	if(dCn != null)
	dCn.closeCn();
}

%>
