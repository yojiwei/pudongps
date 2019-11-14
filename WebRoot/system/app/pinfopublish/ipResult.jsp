<%@page contentType="text/html; charset=GBK"%>
<%@page import="java.sql.*"%>
<%@page import="java.io.*"%>
<%@page import="java.util.*"%>
<%@page import="com.component.database.*"%>
<%@page import="com.util.*"%>

<%
String OPType = "";//操作方式 Add是添加 Edit是修改
String il_begin_1 = "";
String il_begin_2 = "";
String il_begin_3 = "";
String il_begin_4 = "";
String il_begin = "";
String il_end_1 = "";
String il_end_2 = "";
String il_end_3 = "";
String il_end_4 = "";
String il_end = "";

String il_id = "";

il_begin_1 = CTools.dealString(request.getParameter("il_begin_1")).trim();
il_begin_2 = CTools.dealString(request.getParameter("il_begin_2")).trim();
il_begin_3 = CTools.dealString(request.getParameter("il_begin_3")).trim();
il_begin_4 = CTools.dealString(request.getParameter("il_begin_4")).trim();

il_end_1 = CTools.dealString(request.getParameter("il_end_1")).trim();
il_end_2 = CTools.dealString(request.getParameter("il_end_2")).trim();
il_end_3 = CTools.dealString(request.getParameter("il_end_3")).trim();
il_end_4 = CTools.dealString(request.getParameter("il_end_4")).trim();

OPType = CTools.dealString(request.getParameter("OPType")).trim();
il_id = CTools.dealString(request.getParameter("il_id")).trim();

il_begin = il_begin_1 + "." + il_begin_2 + "." + il_begin_3 + "." + il_begin_4;
il_end = il_end_1 + "." + il_end_2 + "." + il_end_3 + "." + il_end_4;

//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 


dImpl.setTableName("tb_iplist");
dImpl.setPrimaryFieldName("il_id");

if (OPType.equals("Add")){
	il_id = String.valueOf(dImpl.addNew());
}else if(OPType.equals("Edit")){
	dImpl.edit("tb_iplist","il_id",Integer.parseInt(il_id));
}

dImpl.setValue("il_begin",il_begin,CDataImpl.STRING);
dImpl.setValue("il_end",il_end,CDataImpl.STRING);
dImpl.setValue("il_status","0",CDataImpl.STRING);

dImpl.update() ;
} catch (Exception ex) {
	System.out.println(new java.util.Date() + "--"
			+ request.getServletPath() + " : " + ex.getMessage());
} finally {
	if(dImpl != null)
	dImpl.closeStmt();
	if(dCn != null)
	dCn.closeCn();
}

response.sendRedirect("ipList.jsp");
%>
