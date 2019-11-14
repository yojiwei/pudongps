<%@page contentType="text/html; charset=GBK"%>
<%@page import="com.util.*"%>
<%@page import="com.component.database.*"%>
<%@ include file="/website/include/import.jsp"%>

<%

String CC_id="";
String CT_id="";
String CC_type="";
String CC_url="";

CC_id = CTools.dealNumber(request.getParameter("cc_id")).trim();
CT_id = CTools.dealNumber(request.getParameter("ct_id")).trim();
CC_type = CTools.dealNumber(request.getParameter("cc_type")).trim();
if (CC_type.equals("Wenji")) {
CC_url = "/system/app/infopublish/commentListWJ.jsp?ct_id="+CT_id;
}

//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 

try
{
  dImpl.delete("tb_contentcomment","cc_id",CC_id);
  dImpl.update() ;
  dImpl.closeStmt();
  dCn.closeCn();
  out.println("<script language=\"javascript\">window.location.href=\""+ CC_url +"\";</script>");
}
catch(Exception e)
{
  out.println("error message:" + e.getMessage());
}
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