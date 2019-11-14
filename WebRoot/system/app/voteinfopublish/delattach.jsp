<%@page contentType="text/html; charset=GBK"%>
<%@include file="../skin/head.jsp"%>
<%
CDataCn dCn = null;
CDataImpl dImpl = null;
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn);

String va_id = CTools.dealString(request.getParameter("va_id")).trim();
String th_id =  CTools.dealString(request.getParameter("th_id")).trim();
dCn.beginTrans();
dImpl.executeUpdate("delete from tb_voteattach where va_id='"+va_id+"'");
dImpl.update();

if (dCn.getLastErrString().equals(""))
{	
	dCn.commitTrans();	
	out.print("<script language='javascript'>alert('操作成功！');window.location='SubjectInfo.jsp?th_id="+th_id+"&OPType=Edit';</script>");
%>

<%
}
else
{
dCn.rollbackTrans();
%>
<script language="javascript" >
	alert("发生错误，删除失败！");
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