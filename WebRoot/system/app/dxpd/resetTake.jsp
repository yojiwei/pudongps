<%@ page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%@page import="com.website.*,com.website.UserTake,com.component.database.CDataControl"%>
<script language="javascript" src="../js/supervise.js"></script>
<script language="javascript" src="../js/common.js"></script>
<script language="javascript"  src="../js/check.js"></script>
<%
String hello="";
CDataCn dCn = null;
CDataImpl dImpl = null;
Vector vectorPage = null;
String ut_id="";
String subid="";
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn); 
CDataControl ctrol = new CDataControl();//操作数据库的东西
subid = CTools.dealString(request.getParameter("subid")).trim();
ut_id = CTools.dealString(request.getParameter("ut_id")).trim();


//删除subscibesetting表中的属于那个用户的信息
dImpl.delete("subscibesetting","id",Long.parseLong(subid));
dImpl.update() ;
  
//String delSql="delete from subscibesetting s where s.id="+subid+"";
//ctrol.executeUpdate(delSql);

}
catch(Exception e)
{
 System.out.println(new java.util.Date() + "--"
			+ request.getServletPath() + " : " + e.getMessage());
}
finally
{
 dImpl.closeStmt();
 dCn.closeCn(); 
}
%>
<script language='javascript'>window.location.href='UserTakeDetail.jsp?id=<%=ut_id%>';</script>

