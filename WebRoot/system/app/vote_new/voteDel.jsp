<%@page contentType="text/html; charset=GBK"%>
<%@include file="../skin/import.jsp"%>
<%
String strId;
strId=CTools.dealString(request.getParameter("strId"));
CDataCn dCn = new CDataCn(); //新建数据库连接对象
CDataImpl dImpl = new CDataImpl(dCn); //新建数据接口对象

dImpl.delete("tb_votelist","vt_id",Integer.parseInt(strId));
dImpl.delete("tb_vote","vt_id",Integer.parseInt(strId));
dImpl.delete("tb_vote_datavalue ","vt_id",Integer.parseInt(strId));


dImpl.closeStmt();
dCn.closeCn();
response.sendRedirect("voteList.jsp");

%>