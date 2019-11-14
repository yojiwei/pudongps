<%@ include file="/website/include/import.jsp" %>
<%
//update by yo 20090113 
CDataCn tdCn = null;
CDataImpl tdImpl = null;
CDataControl tctrol = null;
String tsqlStr = "";
try{
tdCn = new CDataCn();
tdImpl = new CDataImpl(tdCn); 
tctrol = new CDataControl();
if(pr_id!=null){
	tsqlStr = "update tb_proceeding_new set pr_count=pr_count+1 where pr_id='"+pr_id+"'";
	tctrol.executeUpdate(tsqlStr);
	tdCn.commitTrans();
}
}
catch(Exception e){
	out.print(e.toString());
}
finally{
	tdImpl.closeStmt();
	tdCn.closeCn(); 
}
%>