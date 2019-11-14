<%@ page contentType="text/html; charset=GBK" %>
<%@page import="java.sql.*"%>
<%@page import="java.io.*"%>
<%@page import="java.util.*"%>
<%@page import="com.component.database.*"%>
<%@page import="com.util.*"%>


<%
String upperid;
String treeid;
boolean t ;
%>
<%
    upperid = CTools.dealString(request.getParameter("upperid")).trim();
	treeid = CTools.dealString(request.getParameter("treeid")).trim();
    CDataCn  dCn = new CDataCn();
    CDataImpl jdo = new CDataImpl(dCn);
    jdo.setTableName("tb_votediy");
    jdo.setPrimaryFieldName("vt_id");
    t = jdo.setSequence("module","vt_sequence",request);
	dCn.closeCn();
	if(!upperid.equals(""))
		response.sendRedirect("list.jsp?upperid="+upperid);
	if(!treeid.equals(""))
		response.sendRedirect("listtree.jsp?treeid="+treeid);
%>
