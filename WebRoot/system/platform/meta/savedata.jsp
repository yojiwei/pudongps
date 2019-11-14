<%@page contentType="text/html; charset=GBK"%>
<%@page import="java.sql.*"%>
<%@page import="java.io.*"%>
<%@page import="java.util.*"%>
<%@page import="com.component.database.*"%>
<%@page import="com.util.*"%>
<%
String s_ID=request.getParameter("T_id");
String s_PID=request.getParameter("T_pid");
String s_CONTENT=request.getParameter("S_Content");
String s_OP=request.getParameter("edit");
//out.println(CTools.iso2gb(s_CONTENT));
//out.close();

//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); );
try
{
  dImpl.setTableName("test1");
  dImpl.setPrimaryFieldName("form_instance_id");

  if (s_OP.compareTo("edit")==0)
  {
    dImpl.edit("test1","form_instance_id",Integer.parseInt(s_ID));
  }
  else if(s_OP.compareTo("add")==0)
  {
    dImpl.addNew();

  }


  dImpl.setValue("form_instance_id",s_ID,CDataImpl.STRING);
  dImpl.setValue("project_id",s_PID,CDataImpl.STRING);
  dImpl.setValue("arh_mark",CTools.iso2gb(s_CONTENT),CDataImpl.STRING);

  dImpl.update() ;
  dImpl.closeStmt();
  dCn.closeCn();
  response.sendRedirect("listdata.jsp");
}
catch(Exception e)
{
  out.println("error message:" + e.getMessage() );
}
%>


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