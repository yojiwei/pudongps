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
String us_istemp="";
String us_idcardnumber="";
String us_cellphonenumber="";
String today = "";
String ssoSql = "";

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
us_istemp=CTools.dealString(request.getParameter("us_istemp")).trim();
us_idcardnumber=CTools.dealString(request.getParameter("us_idcardnumber"));
us_cellphonenumber=CTools.dealString(request.getParameter("us_cellphonenumber"));
today = new CDate().getThisday();
//update20090410 by yo
Hashtable contentSso = null;
//浦东数据库
CDataCn dCn = null;
CDataImpl dImpl = null;
//通行证数据库
MyCDataCn mydCn = null;
MyCDataImpl mydImpl = null;
try {
//浦东数据库
dCn = new CDataCn(); 
dImpl = new CDataImpl(dCn); 
//通行证数据库
mydCn = new MyCDataCn();
mydImpl = new MyCDataImpl(mydCn); 
 
//浦东数据库操作
User user = new User(dCn);
user.setAddress(us_address);
user.setEmail(us_email);
user.setIstemp(us_isok);
user.setPwd(us_password);  //暂时不能修改密码 update by 20090410
user.setId(us_id);
user.setTel(us_tel);
user.setUid(us_uid);
user.setUserKind(us_type);
user.setUserName(us_name);
user.setWsid(ws_id);
user.setZip(us_zip);
user.setIdCardNumber(us_idcardnumber);
user.setCellPhoneNumber(us_cellphonenumber);
//通行证数据库操作
CassoUser us = new CassoUser(mydCn);
//
if(us_uid.indexOf("@pudong.gov.cn")==-1){
	us_uid += "@pudong.gov.cn";
}
us.setUid(us_uid);
us.setPwd(us_password);
us.setRegdate(today);
us.setIsok(us_isok);

	if(OPType.equals("Add")){
		user.newUser();
		us.newUser();
	}else if(OPType.equals("Edit")||OPType.equals("Check")){
	//得到通行证数据库的用户ID
		ssoSql = "select us_id from tb_user where us_uid ='"+us_uid+"'";
		contentSso  = mydImpl.getDataInfo(ssoSql);
		if(contentSso!=null){
			us_id = CTools.dealNull(contentSso.get("us_id"));
		}
		us.setId(us_id);
		user.updateUser();
		us.updateUser();
	}
	
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
  response.sendRedirect("UserList.jsp");
  
%>

<%@include file="../skin/bottom.jsp"%>
