<%@page contentType="text/html; charset=GBK"%>
<%@page import="java.sql.*"%>
<%@page import="java.io.*"%>
<%@page import="java.util.*"%>
<%@page import="com.component.database.*"%>
<%@page import="com.util.*"%>
<%@include file="../skin/import.jsp"%>
<%

String in_id="";

in_id=CTools.dealString(request.getParameter("in_id")).trim();//

//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 

  try
  {
    
	dImpl.delete("tb_info","in_id",Integer.parseInt(in_id));
	
    dImpl.closeStmt();
    dCn.closeCn();
    out.print("<script>");
    out.print("alert('成功删除！');");
	
	out.print("</script>");
    response.sendRedirect("leadBoxList.jsp");
  }
  catch(Exception e)
  {
    out.println("error message:" + e.getMessage());
  }
%>
<%@include file="../skin/bottom.jsp"%>




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
