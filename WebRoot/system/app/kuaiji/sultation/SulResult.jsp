<%@page contentType="text/html; charset=GBK"%>
<%@page import="java.sql.*"%>
<%@page import="java.io.*"%>
<%@page import="java.util.*"%>
<%@page import="com.component.database.*"%>
<%@page import="com.util.*"%>
<%

String cl_id="";//主键
String cl_code="";//是否由会计中心处理，1为是
String cl_type="";//是否已读，1为已读
cl_id=CTools.dealString(request.getParameter("cl_id")).trim();
cl_code=CTools.dealString(request.getParameter("cl_code")).trim();
if (!cl_code.equals("1"))
{
	cl_code = "0";
}
cl_type=CTools.dealString(request.getParameter("cl_type")).trim();
if (!cl_type.equals("1"))
{
	cl_type = "0";
}


//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 

try
{

  dImpl.edit("tb_consultation","cl_id",Integer.parseInt(cl_id));

  dImpl.setValue("cl_code",cl_code,CDataImpl.STRING);
  dImpl.setValue("cl_type",cl_type,CDataImpl.STRING);
  dImpl.update() ;
  dImpl.closeStmt();
  dCn.closeCn();
  response.sendRedirect("SulList.jsp");
}
catch(Exception e)
{
  out.println("error message:" + e.getMessage() +e.toString() );
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