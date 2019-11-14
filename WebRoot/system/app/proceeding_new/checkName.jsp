<%@page contentType="text/html; charset=GBK"%><%@ include file="/website/include/import.jsp" %><%
//Update 20061231
CDataCn dCn = null;
CDataImpl dImpl = null;

String sqlStr = "";
Hashtable content = null;
Vector vPage = null;
String sv = CTools.dealString(request.getParameter("pr_name")).trim();
String dt_id = CTools.dealString(request.getParameter("dt_id")).trim();
String pr_id = CTools.dealString(request.getParameter("pr_id")).trim();

String sqlWhere = "";

if(!pr_id.equals("")) sqlWhere = " and pr_id <> '" + pr_id + "'";

try{
	dCn = new CDataCn();
	dImpl = new CDataImpl(dCn);

	sqlStr = "select pr_id from tb_proceeding_new where dt_id = " + dt_id + sqlWhere + " and pr_name = '"+sv+"'";
	//out.println(sqlStr);
	content = dImpl.getDataInfo(sqlStr);
	if(content!=null) out.println("true");
	else out.println("false");
}
catch(Exception e){
	//e.printStackTrace();
	System.out.println(new java.util.Date() + "--"
			+ request.getServletPath() + " : " + e.getMessage());
}finally{
	dImpl.closeStmt();
	dCn.closeCn(); 
}
%>