<%@page contentType="text/html; charset=GBK"%>
<%@page import="java.sql.*"%>
<%@page import="java.io.*"%>
<%@page import="java.util.*"%>
<%@page import="com.component.database.*"%>
<%@page import="com.util.*"%>
<%
String OPType="";//操作方式 Add是添加 Edit是修改
String strId="";//编号
String strPname="";//参数名称
String strPvalue="";//参数值
String strMemo = "";

  strId=CTools.dealString (request.getParameter("strId").trim());
  strPname=CTools.dealString (request.getParameter("IP_name"));
  strPvalue=CTools.dealString (request.getParameter("IP_value"));
  strMemo = CTools.dealString(request.getParameter("IP_memo"));
  OPType=request.getParameter("OPType");

  //out.println(strId+strPname+strPvalue+OPType);
//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 

try
{
  dImpl.setTableName("tb_initparameter");
  dImpl.setPrimaryFieldName("ip_id");
  if (OPType.equals("Add"))
    dImpl.addNew();
  else if (OPType.equals("Edit"))
    dImpl.edit("tb_initparameter","ip_id",Integer.parseInt(strId));

  dImpl.setValue("ip_name",strPname,CDataImpl.STRING);
  dImpl.setValue("ip_value",strPvalue,CDataImpl.STRING);
  dImpl.setValue("ip_memo",strMemo,CDataImpl.STRING);

  dImpl.update() ;
  dImpl.closeStmt();
  dCn.closeCn();
  
  if(strPname.equals("buildXML_interval")) {
     response.sendRedirect("/BuildXMLServlet?type=1&value=" + strPvalue);
  }
  else if(strPname.equals("buildDB_interval")){
     response.sendRedirect("/BuildDBServlet?type=1&value=" + strPvalue);
  }
  else if(strPname.equals("buildXML_startTime")){
     response.sendRedirect("/BuildXMLServlet?type=2&value=" + strPvalue);
  }
  else if(strPname.equals("buildDB_startTime")){
     response.sendRedirect("/BuildDBServlet?type=2&value=" + strPvalue);
  }
  else {
     response.sendRedirect("parameterList.jsp");
  }
}
catch(Exception e)
{
  out.println("error message:" + e.toString()) ;
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