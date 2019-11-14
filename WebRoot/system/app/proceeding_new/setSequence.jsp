<%@ page contentType="text/html; charset=GBK" %>
<%@page import="java.sql.*"%>
<%@page import="java.io.*"%>
<%@page import="java.util.*"%>
<%@page import="com.component.database.*"%>
<%@page import="com.util.*"%>


<%
String OType;
boolean t ;

    OType = CTools.dealNumber(request.getParameter("OType")).trim();;
    //update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl jdo=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 jdo = new CDataImpl(dCn); 

    jdo.setTableName("tb_proceeding_new");
    jdo.setPrimaryFieldName("pr_id");
    jdo.setPrimaryKeyType(0);
    t = jdo.setSequence("module","pr_sequence",request);

	dCn.closeCn();
    response.sendRedirect("ProceedingList.jsp?OType="+OType);
    
} catch (Exception ex) {
	System.out.println(new java.util.Date() + "--"
			+ request.getServletPath() + " : " + ex.getMessage());
} finally {
	if(jdo != null)
	jdo.closeStmt();
	if(dCn != null)
	dCn.closeCn();
}
    
%>
