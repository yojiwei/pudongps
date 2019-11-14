<%@page contentType="text/html; charset=GBK"%>
<%@page import="com.util.*"%>
<%@page import="com.component.database.*"%>
<%@ include file="/website/include/import.jsp"%>

<%

String CT_id="";

CT_id=CTools.dealNumber(request.getParameter("ct_id")).trim();//??id
//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 

try
{
  dImpl.delete("tb_content","ct_id",Long.parseLong(CT_id));
  dImpl.update() ;
  dImpl.closeStmt();
  dCn.closeCn();
  out.println("yes?");
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