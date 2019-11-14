<%@ page contentType="text/html; charset=GBK" %>
<%@page import="java.sql.*"%>
<%@page import="java.io.*"%>
<%@page import="java.util.*"%>
<%@page import="com.component.database.*"%>
<%@page import="com.util.*"%>


<%
String list_id;
boolean t ;
%>
<%
    list_id = CTools.dealNumber(request.getParameter("list_id")).trim();;
    //update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl jdo=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 jdo = new CDataImpl(dCn); 

    jdo.setTableName("tb_subject");
    jdo.setPrimaryFieldName("sj_id");
    t = jdo.setSequence("module","sj_sequence",request);
    //t = jdo.setSequence("module","sj_sequence",null);
    //out.print(t);
//System.out.print(list_id);
//out.close();
	dCn.closeCn();
    response.sendRedirect("subjectList.jsp?sj_id="+list_id);
    
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
