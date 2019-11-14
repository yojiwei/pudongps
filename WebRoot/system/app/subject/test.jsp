<%@include file="../skin/import.jsp"%>
<%
CDataCn dCn = new CDataCn(); 
CDataImpl dImpl = new CDataImpl(dCn); 
String OPType=CTools.dealString(request.getParameter("OPType")).trim();
String strId=CTools.dealString(request.getParameter("sj_id")).trim();
String sjdir = CTools.dealString(request.getParameter("sjDir")).trim();
String sqlwhere = "";
if(!strId.equals("")) sqlwhere = "and sj_id<>'" + strId + "'";

Hashtable content = dImpl.getDataInfo("select sj_id from tb_subject where sj_dir='" + sjdir + "' " + sqlwhere);
out.println("select sj_id from tb_subject where sj_dir='" + sjdir + "' " + sqlwhere);
dImpl.closeStmt();
dCn.closeCn();
if(content!=null) out.println("{no}");
else
	out.println("{yes}");
%>