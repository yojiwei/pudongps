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
String et_id = "";
String et_name = "";
String et_address = "";
String et_phone = "";
String et_corporation = "";
String et_fund = "";
String et_fare = "";
String et_qualification = "";
String et_records = "";
String et_status = "";
String et_license = "";
String et_licensetime = "";
String et_limittime = "";
String et_qaleader = "";
String et_kind = "";

OPType=CTools.dealString(request.getParameter("OPType")).trim();
et_id=CTools.dealString(request.getParameter("et_id")).trim();
et_name=CTools.dealString(request.getParameter("et_name")).trim();
et_address=CTools.dealString(request.getParameter("et_address")).trim();
et_phone=CTools.dealString(request.getParameter("et_phone")).trim();
et_corporation=CTools.dealString(request.getParameter("et_corporation")).trim();
et_fund=CTools.dealString(request.getParameter("et_fund")).trim();
et_fare=CTools.dealString(request.getParameter("et_fare")).trim();
et_qualification=CTools.dealString(request.getParameter("et_qualification")).trim();
et_records=CTools.dealString(request.getParameter("et_records")).trim();
et_status=CTools.dealString(request.getParameter("et_status")).trim();
et_license=CTools.dealString(request.getParameter("et_license")).trim();
et_licensetime=CTools.dealString(request.getParameter("et_licensetime")).trim();
et_limittime=CTools.dealString(request.getParameter("et_limittime"));
et_qaleader=CTools.dealString(request.getParameter("et_qaleader"));
et_kind=CTools.dealString(request.getParameter("et_kind"));

//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 

//判断企业名称是否重复，若重复返回重新填写
String sqlHasName = "select et_id from tb_creditenterprise where et_name = '"+ et_name +"'";
ResultSet rs_sh = dImpl.executeQuery(sqlHasName);
	if (rs_sh.next()) {
		out.print("<script>alert('企业名称已经存在，请核实后填写！');history.back();</script>");
		return;
	}

if(OPType.equals("Add"))
  {

  //dImpl.addNew("tb_creditenterprise","et_id",CDataImpl.PRIMARY_KEY_IS_N);
  dImpl.setTableName("tb_creditenterprise");
    dImpl.setPrimaryFieldName("et_id");
	dImpl.addNew();

  }
  else if(OPType.equals("Edit"))
{
  	dImpl.edit("tb_creditenterprise","et_id",et_id);
	out.print(et_id);
}


  dImpl.setValue("et_name",et_name,CDataImpl.STRING);
  dImpl.setValue("et_address",et_address,CDataImpl.STRING);
  dImpl.setValue("et_phone",et_phone,CDataImpl.STRING);
  dImpl.setValue("et_corporation",et_corporation,CDataImpl.STRING);
  dImpl.setValue("et_fund",et_fund,CDataImpl.STRING);
  dImpl.setValue("et_fare",et_fare,CDataImpl.STRING);
  dImpl.setValue("et_qualification",et_qualification,CDataImpl.STRING);
  dImpl.setValue("et_records",et_records,CDataImpl.STRING);
  dImpl.setValue("et_status",et_status,CDataImpl.STRING);
  dImpl.setValue("et_license",et_license,CDataImpl.STRING);
  dImpl.setValue("et_licensetime",et_licensetime,CDataImpl.STRING);
  dImpl.setValue("et_limittime",et_limittime,CDataImpl.STRING);
  dImpl.setValue("et_qaleader",et_qaleader,CDataImpl.STRING);
  dImpl.setValue("et_kind",et_kind,CDataImpl.STRING); 
  dImpl.update();

  dImpl.closeStmt();
  dCn.closeCn();
  
} catch (Exception ex) {
	System.out.println(new java.util.Date() + "--"
			+ request.getServletPath() + " : " + ex.getMessage());
} finally {
	if(dImpl != null)
	dImpl.closeStmt();
	if(dCn != null)
	dCn.closeCn();
}
  response.sendRedirect("EnterpriseList.jsp");
%>

<%@include file="../skin/bottom.jsp"%>
