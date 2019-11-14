<%
/**************************************
this page is made by honeyday 2002-12-6
***************************************/
%>
<%@page contentType="text/html; charset=GBK"%>
<%@page import="java.sql.*"%>
<%@page import="java.io.*"%>
<%@page import="java.util.*"%>
<%@page import="com.component.database.*"%>
<%@page import="com.util.*"%>

<%
String OPType="";
String kind="";
String roleName="";
String Demo="";
String roleLevel="";
String tr_id="";
//String OPType="";

OPType=CTools.dealString(request.getParameter("OPType")).trim();
kind=CTools.dealString(request.getParameter("kind")).trim();
roleName=CTools.dealString(request.getParameter("roleName")).trim();
Demo=CTools.dealString(request.getParameter("Demo")).trim();
roleLevel=CTools.dealNumber(request.getParameter("roleLevel")).trim();
tr_id=CTools.dealNumber(request.getParameter("tr_id")).trim();

//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 

try
{
  dImpl.setTableName("tb_roleinfo");
  dImpl.setPrimaryFieldName("tr_id");
  if (OPType.equals("Add"))
    dImpl.addNew();
  else if (OPType.equals("Edit"))
	dImpl.edit("tb_roleinfo","tr_id",Integer.parseInt(tr_id));
  if (kind.equals("roleInfo"))
	{
		dImpl.setValue("tr_name",roleName,CDataImpl.STRING);
		dImpl.setValue("tr_type","3",CDataImpl.INT);
		dImpl.setValue("tr_level",roleLevel,CDataImpl.INT);
		dImpl.setValue("tr_detail",Demo,CDataImpl.STRING);
    }
  dImpl.update() ;
  dImpl.closeStmt();
  dCn.closeCn();
   response.sendRedirect("roleList.jsp");

}
catch(Exception e)
{
  out.println("error message:" + e.toString()) ;
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
