<%@ page contentType="text/html; charset=GBK" %>
<%@page import="java.sql.*"%>
<%@page import="java.io.*"%>
<%@page import="java.util.*"%>
<%@page import="com.component.database.*"%>
<%@page import="com.util.*"%>

<%
String OPType="";
String us_id="";
String us_name="";
String us_active_flag="0";

OPType=CTools.dealString(request.getparameter(OPType)).trim();

//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 
try
{
  dImpl.setTableName("tb_user");
  dImpl.setPrimaryFieldName("us_id");
  if(OPType=="Add")
	{
        dImpl.Addnew();
	strSql = "select us_id from tb_user where us_name='"+us_name+"'";
	}
	Hashtable content= dImpl.getDataInfo(strSql);
	{
	if(content=null)
	dImpl.setValue("us_name",us_name,CDataImpl.STRING);
	dImpl.setValue("uk_id",us_type,CDataImpl.STRING);
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
