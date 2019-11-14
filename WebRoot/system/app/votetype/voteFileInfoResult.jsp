<%@ page contentType="text/html; charset=GBK" %>
<%@include file="../skin/head.jsp"%>
<%

//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 
String vd_code = "";
String vd_value = "";
String ty_id = "" ;
String OType = "" ;
String vd_id = "" ;
String vd_disimage = "";
String vd_number = "" ;
vd_value = CTools.dealString(request.getParameter("vd_value")).trim();
vd_code =  CTools.dealString(request.getParameter("vd_code")).trim();
vd_disimage =  CTools.dealString(request.getParameter("vd_disimage")).trim();
vd_number =  CTools.dealString(request.getParameter("vd_number")).trim();
ty_id = CTools.dealString(request.getParameter("ty_id")).trim();
OType = CTools.dealString(request.getParameter("OType")).trim();
if("add".equals(OType))
vd_id = dImpl.addNew("tb_votetypedata","vd_id",CDataImpl.PRIMARY_KEY_IS_VARCHAR);
if("edit".equals(OType))
{
	vd_id =  CTools.dealString(request.getParameter("vd_id")).trim();;
 dImpl.edit("tb_votetypedata","vd_id",vd_id);
}
dImpl.setValue("vd_value",vd_value,CDataImpl.STRING);
dImpl.setValue("vd_code",vd_code,CDataImpl.STRING);
dImpl.setValue("vd_number",vd_number,CDataImpl.STRING);
dImpl.setValue("vd_disimage",vd_disimage,CDataImpl.STRING);
dImpl.setValue("ty_id",ty_id,CDataImpl.STRING);
dImpl.update();
  dImpl.closeStmt();
  dCn.closeCn();
  response.sendRedirect("voteDetailList.jsp?ty_id="+ty_id);
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