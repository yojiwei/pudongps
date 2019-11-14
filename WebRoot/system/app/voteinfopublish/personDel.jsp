<%@page contentType="text/html; charset=GBK"%>
<%@include file="../skin/head.jsp"%>
<%
CDataCn dCn = null;
CDataImpl dImpl = null;
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn);

String ct_id = CTools.dealString(request.getParameter("ct_id")).trim();
String th_id = CTools.dealString(request.getParameter("th_id")).trim();
String th_powercode = CTools.dealString(request.getParameter("th_powercode")).trim();
dCn.beginTrans();
dImpl.executeUpdate("delete from tb_content where ct_id="+ct_id);
dImpl.executeUpdate("delete from tb_voteadvanced where ct_id="+ct_id);
dImpl.executeUpdate("delete from tb_relate where ct_id="+ct_id);
dImpl.update();

if (dCn.getLastErrString().equals(""))
{	
	dCn.commitTrans();	
%>
<script language="javascript">
	alert("操作已成功！");
	window.location="Personlist1.jsp?th_id=<%=th_id%>&th_powercode=<%=th_powercode%>";
</script>
<%
}
else
{
dCn.rollbackTrans();
%>
<script language="javascript" >
	alert("发生错误，录入失败！");
	window.history.go(-1);
</script>
<%
}	

}
catch(Exception e){
//e.printStackTrace();
out.print(e.toString());
}
finally{
dImpl.closeStmt();
dCn.closeCn(); 
}
%>