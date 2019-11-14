<%@page contentType="text/html; charset=GBK"%><%@ include file="/website/include/import.jsp" %><%
//Update 20061231
CDataCn dCn = null;
CDataImpl dImpl = null;

String sqlStr = "";
Hashtable content = null;
Vector vPage = null;
String sv = "";
String st [] = (CTools.dealString(request.getParameter("st")).trim()).split(",");
try{
	dCn = new CDataCn();
	dImpl = new CDataImpl(dCn);

	for(int i=0; i<st.length; i++){
		sqlStr = "select ct_title from tb_content where ct_id = " + st[i];
		content = dImpl.getDataInfo(sqlStr);
		if(content!=null) sv += content.get("ct_title").toString() + ",";
	}
	out.println(sv);
}
catch(Exception e){
	//e.printStackTrace();
	out.print(e.toString());
}finally{
	dImpl.closeStmt();
	dCn.closeCn(); 
}
%>