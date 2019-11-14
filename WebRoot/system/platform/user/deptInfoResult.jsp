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
String OPType="";//操作方式 Add是添加 Edit是修改
String dd_id="";//编号
String dd_name="";//名称
String dt_id="0";//父id
String dt_iswork="0";//活动标志
String strSql="";		//判断部门重复的SQL语句
String dt_shortname = "";//部门名称简写
String dt_custodyflag = "";//是否为监管部门　1为是，0或NULL为非

OPType=CTools.dealString(request.getParameter("OPType")).trim();
dd_id=CTools.dealNumber(request.getParameter("dd_id")).trim();
dd_name=CTools.dealString(request.getParameter("dd_name")).trim();
dt_id=CTools.dealNumber(request.getParameter("dt_id")).trim();
dt_iswork=CTools.dealNumber(request.getParameter("dt_iswork")).trim();
dt_shortname = CTools.dealString(request.getParameter("dt_shortname")).trim();
dt_custodyflag = CTools.dealString(request.getParameter("dt_custodyflag")).trim();

//out.print(dd_id);

//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 
try
{
  dImpl.setTableName("tb_deptinfo");
  dImpl.setPrimaryFieldName("dt_id");
  if (OPType.equals("Add"))
	{
    	dImpl.addNew();
        strSql="select dt_id from tb_deptinfo where dt_name='"+dd_name+"' and dt_parent_id="+dt_id+"";
	}
  else if (OPType.equals("Edit"))
	{
	 if (dd_id.equals(dt_id))
		{
			out.print("<SCRIPT LANGUAGE='JavaScript'>");
			out.print("alert('部门选择错误！不能将本部门作为上级部门，请重新选择！');");
			out.print("history.go(-1);");
			out.print("</SCRIPT>");
			out.close();
		}
	else
		{
			dImpl.edit("tb_deptinfo","dt_id",Integer.parseInt(dd_id));
			strSql="select dt_id from tb_deptinfo where dt_name='"+dd_name+"' and dt_parent_id="+dt_id+" and dt_id<>"+dd_id+"";
		}
	}
	//out.print(strSql);
	Hashtable content=dImpl.getDataInfo(strSql);
	if (content==null)
	{
	dImpl.setValue("dt_name",dd_name,CDataImpl.STRING);
  dImpl.setValue("dt_parent_id",dt_id,CDataImpl.INT);
  dImpl.setValue("dt_iswork",dt_iswork,CDataImpl.INT);
  dImpl.setValue("dt_shortname",dt_shortname,CDataImpl.STRING);
  dImpl.setValue("dt_custodyflag",dt_custodyflag,CDataImpl.STRING);

  dImpl.update() ;
	}
	else
	{
			out.print("<SCRIPT LANGUAGE='JavaScript'>");
			out.print("alert('部门名称重复，请重新输入！');");
			out.print("history.go(-1);");
			out.print("</SCRIPT>");
			out.close();
	}
  dImpl.closeStmt();
  dCn.closeCn();
  String urlRedirect="userList.jsp?list_id="+dt_id;
  response.sendRedirect(urlRedirect);

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