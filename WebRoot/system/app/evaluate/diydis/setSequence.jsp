<%@ page contentType="text/html; charset=GBK" %>
<%@page import="java.sql.*"%>
<%@page import="java.io.*"%>
<%@page import="java.util.*"%>
<%@page import="com.component.database.*"%>
<%@page import="com.util.*"%>
<%
String upperid;
String treeid;
String state="";
boolean t ;
upperid = CTools.dealString(request.getParameter("upperid")).trim();
treeid = CTools.dealString(request.getParameter("treeid")).trim();
state = CTools.dealString(request.getParameter("vde_status")).trim();

//update20080122
CDataCn dCn=null;   //新建数据库连接对象
CDataImpl jdo=null;  //新建数据接口对象
try {
 dCn = new CDataCn(); 
 jdo = new CDataImpl(dCn); 
 System.out.println("sdfsdfsdfs");
	jdo.setTableName("tb_votediy");
	jdo.setPrimaryFieldName("vt_id");
	t = jdo.setSequence("module","vt_sequence",request);
	if(!upperid.equals("")){
		if(upperid.equals("0")){
			response.sendRedirect("list.jsp?&vde_status="+state+"");
		}else{
			response.sendRedirect("list.jsp?upperid="+upperid+"&vde_status="+state+"&Typepp=1");
		}
	}
	if(!treeid.equals(""))
		response.sendRedirect("listtree.jsp?treeid="+treeid+"&state="+state+"&Typepp=1");

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
