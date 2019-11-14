<%@ page contentType="text/html; charset=GBK" %>
<%@page import="java.sql.*"%>
<%@page import="java.io.*"%>
<%@page import="java.util.*"%>
<%@page import="com.component.database.*"%>
<%@page import="com.util.*"%>


<%
boolean t = false;
%>
<%
    //out.println(Menu);
//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl jdo=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 jdo = new CDataImpl(dCn); 
    jdo.setTableName("tb_connproc");
    jdo.setPrimaryKeyType(CDataImpl.PRIMARY_KEY_IS_VARCHAR);
    jdo.setPrimaryFieldName("cp_id");
    t = jdo.setSequence("module","cp_sequence",request);
    //t = jdo.setSequence("module","cp_sequence",null);
    //out.print(t);
//System.out.print(list_id);
//out.close();
	dCn.closeCn();
	} catch (Exception ex) {
	System.out.println(new java.util.Date() + "--"
			+ request.getServletPath() + " : " + ex.getMessage());
} finally {
	if(jdo != null)
	jdo.closeStmt();
	if(dCn != null)
	dCn.closeCn();
}
    response.sendRedirect("ProceedingList.jsp");
%>
