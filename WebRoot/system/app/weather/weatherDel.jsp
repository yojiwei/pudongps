<%
/*
天气预报删除页面
by honeyday 2002-12-4

*/
%>
<%@page contentType="text/html; charset=GBK"%>
<%@page import="java.sql.*"%>
<%@page import="java.io.*"%>
<%@page import="java.util.*"%>
<%@page import="com.component.database.*"%>
<%@page import="com.util.*"%>
<%@include file="../skin/import.jsp"%>
<%@page import="com.beyondbit.dataexchange.*,org.apache.log4j.*" %>
<%

/*定义变量  开始*/
String WF_id="";
/*定义变量  结束*/
/*获取参数  开始*/
WF_id=CTools.dealNumber(request.getParameter("WF_id")).trim();//新闻id
/*获取参数  结束*/
/*程序主体  开始*/
//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 


try
{
  dImpl.delete("tb_weatherforecast","wf_id",Integer.parseInt(WF_id));

  dImpl.closeStmt();
  dCn.closeCn();

  ThreadCache.pushItem(WF_id,"2","天气预报","271","http://in-inforportal.pudong.sh/sites/manage");
  ThreadCache.pushItem(WF_id,"2","天气预报","270","http://inforportal.pudong.sh/sites/manage");
	
  out.println("成功删除！");
  response.sendRedirect("weatherList.jsp");
}
catch(Exception e)
{
  out.println("error message:" + e.getMessage());
}
/*程序主体  结束*/
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

<%@include file="../skin/bottom.jsp"%>
