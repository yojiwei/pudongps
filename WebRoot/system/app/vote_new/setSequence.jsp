<%@ page contentType="text/html; charset=GBK" %>
<%@ page import="com.component.database.*" %>
<%@ page import="java.io.*" %>


<%
  boolean t ;

    CDataCn  dCn = new CDataCn();
    CDataImpl jdo = new CDataImpl(dCn);
    jdo.setTableName("tb_vote");
    jdo.setPrimaryFieldName("vt_id");
    t = jdo.setSequence("module","vt_sequence",request);
	dCn.closeCn();
    response.sendRedirect("voteList.jsp");
%>
