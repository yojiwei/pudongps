<%@page contentType="text/html; charset=GBK"%>
<%@include file="../skin/head.jsp"%>
<%
CDataCn dCn = null;
CDataImpl dImpl = null;
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn);

String th_id = CTools.dealString(request.getParameter("th_id")).trim();

dCn.beginTrans();
dImpl.executeUpdate("delete from tb_votetheame where th_id="+th_id);
dImpl.update();
dImpl.executeUpdate("delete from tb_content where ct_id in(select r.ct_id from tb_relate r where r.th_id="+th_id+")");
dImpl.update();
dImpl.executeUpdate("delete from tb_voteadvanced where ct_id in(select r.ct_id from tb_relate r where r.th_id="+th_id+")");
dImpl.update();
dImpl.executeUpdate("delete from tb_relate where th_id="+th_id);
dImpl.update();

if (dCn.getLastErrString().equals(""))
{	
	dCn.commitTrans();	
%>
<script language="javascript">
	alert("操作已成功！");
	window.location="SubjectList.jsp";
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