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
String OPType="";
String us_uid="";
String us_pwd="";
String ec_name="";
String ec_enroladd="";
String ec_enrolzip="";
String ec_corporation="";
String ec_produceadd="";
String ec_producezip="";
String ec_mgr="";
String ec_linkman="";
String ec_fax="";
String ec_email="";
String us_istemp ="";
String url = "";
String ssoSql = "";
String today = "";
String sso_us_id = "";

us_uid = CTools.dealString(request.getParameter("us_uid")).trim();
OPType=CTools.dealString(request.getParameter("OPType")).trim();
us_id=CTools.dealString(request.getParameter("us_id")).trim();
us_pwd=CTools.dealString(request.getParameter("us_pwd")).trim();
ec_name=CTools.dealString(request.getParameter("ec_name")).trim();
ec_enroladd=CTools.dealString(request.getParameter("ec_enroladd")).trim();
ec_enrolzip=CTools.dealString(request.getParameter("ec_enrolzip")).trim();
ec_corporation=CTools.dealString(request.getParameter("ec_corporation")).trim();
ec_produceadd=CTools.dealString(request.getParameter("ec_produceadd")).trim();
ec_producezip=CTools.dealString(request.getParameter("ec_producezip")).trim();
ec_mgr=CTools.dealString(request.getParameter("ec_mgr")).trim();
ec_linkman=CTools.dealString(request.getParameter("ec_linkman")).trim();
ec_fax=CTools.dealString(request.getParameter("ec_fax")).trim();
ec_email=CTools.dealString(request.getParameter("ec_email")).trim();
us_istemp=CTools.dealString(request.getParameter("us_istemp")).trim();
today = new CDate().getThisday();

//update20080122
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


 MD5 md5 = new MD5();
if(OPType.equals("Audit")){
	dImpl.edit("tb_user","us_id",us_id);
	dImpl.setValue("us_istemp",us_istemp,CDataImpl.STRING);
	dImpl.update();
	url="BEUserList.jsp?OPType=Audit";
}else{ 
	if(OPType.equals("Add")){
		String sql_cong="select us_id from tb_user where us_uid='"+us_uid+"'";
		Hashtable content_2  = dImpl.getDataInfo(sql_cong);
		if(content_2!=null){
			out.println("<script>alert('用户名重复,请重新注册!');");
			out.println("</script>");
			out.println("<script>window.history.back();</script>");
		}else{
			//注册新企业用户
			us_id = dImpl.addNew("tb_user","us_id",CDataImpl.PRIMARY_KEY_IS_VARCHAR);
			dImpl.setValue("us_uid",us_uid,CDataImpl.STRING);
			dImpl.setValue("us_pwd",md5.getMD5ofStr(us_pwd),CDataImpl.STRING);
			dImpl.setValue("us_name",ec_name,CDataImpl.STRING); //新增公司的名称
			dImpl.setValue("uk_id","o2",CDataImpl.STRING);
			dImpl.setValue("ws_id","o27",CDataImpl.STRING);
			dImpl.setValue("us_isok","1",CDataImpl.STRING);
			dImpl.update();	
			//通行证数据库操作
			CassoUser us = new CassoUser(mydCn);
			if(us_uid.indexOf("@pudong.gov.cn")==-1){
				us_uid += "@pudong.gov.cn";
			}
			us.setUid(us_uid);
			us.setPwd(us_pwd);
			us.setRegdate(today);
			us.setIsok("1");
			us.newUser();
			//通行证数据操作结束 
		}
		dImpl.addNew("tb_enterpvisc","ec_id");
		dImpl.setValue("us_id",us_id,CDataImpl.STRING);
		dImpl.setValue("ec_name",ec_name,CDataImpl.STRING); //新增公司的名称 
	}
	else{
	//修改企业用户的密码
	dImpl.edit("tb_user","us_id",us_id);
	dImpl.setValue("us_pwd",md5.getMD5ofStr(us_pwd),CDataImpl.STRING); //修改企业用户的密码
	dImpl.update();
	//通行证数据库操作
	CassoUser us = new CassoUser(mydCn);
	if(us_uid.indexOf("@pudong.gov.cn")==-1){
		us_uid += "@pudong.gov.cn";
	}
	ssoSql = "select us_id from tb_user where us_uid ='"+us_uid+"'";
	contentSso  = mydImpl.getDataInfo(ssoSql);
	if(contentSso!=null){
		sso_us_id = CTools.dealNull(contentSso.get("us_id"));
	}
	us.setId(sso_us_id);
	us.setUid(us_uid);
	us.setPwd(us_pwd);
	us.setRegdate(today);
	us.setIsok("1");
	us.updateUser();
	//
	dImpl.edit("tb_enterpvisc","us_id",us_id);
	}
	//dImpl.setValue("ec_name",ec_name,CDataImpl.STRING); //不能修改公司的名称 
	dImpl.setValue("ec_enroladd",ec_enroladd,CDataImpl.STRING);
	dImpl.setValue("ec_enrolzip",ec_enrolzip,CDataImpl.STRING);
	dImpl.setValue("ec_corporation",ec_corporation,CDataImpl.STRING);
	dImpl.setValue("ec_produceadd",ec_produceadd,CDataImpl.STRING);
	dImpl.setValue("ec_producezip",ec_producezip,CDataImpl.STRING);
	dImpl.setValue("ec_mgr",ec_mgr,CDataImpl.STRING);
	dImpl.setValue("ec_linkman",ec_linkman,CDataImpl.STRING);
	dImpl.setValue("ec_fax",ec_fax,CDataImpl.STRING);
	dImpl.setValue("ec_email",ec_email,CDataImpl.STRING);
	dImpl.update();
	
	url="BEUserList.jsp";
}
dImpl.closeStmt();
dCn.closeCn();

out.println("<script>window.location.href='BEUserList.jsp';</script>");
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
%>



<%@include file="../skin/bottom.jsp"%>
