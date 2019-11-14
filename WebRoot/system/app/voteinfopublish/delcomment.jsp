<%@page contentType="text/html; charset=GBK"%>
<%@include file="../skin/head.jsp"%>
<%
CDataCn dCn = null;
CDataImpl dImpl = null;
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn);

String th_id = CTools.dealString(request.getParameter("th_id")).trim();
String uc_id = CTools.dealString(request.getParameter("uc_id")).trim();
String th_votetype = CTools.dealString(request.getParameter("th_votetype")).trim();
dCn.beginTrans();
dImpl.executeUpdate("delete from tb_voteusercomment where uc_id='"+uc_id+"'");
dImpl.update();

if (dCn.getLastErrString().equals(""))
{	
	dCn.commitTrans();	
	out.print("<script language='javascript'>alert('操作成功！');window.location='commentlist.jsp?th_id="+th_id+"&th_votetype="+th_votetype+"';</script>");
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