<%@page contentType="text/html; charset=GBK"%>
<%@include file="../skin/head.jsp"%>
<%
String th_id = CTools.dealString(request.getParameter("th_id"));
String [] ct_id =request.getParameterValues("ct_id");
String [] ct_sequence =request.getParameterValues("ct_sequence");

//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 

dCn.beginTrans();
dImpl.setTableName("tb_content");
dImpl.setPrimaryFieldName("ct_id");
for (int i=0;i<ct_id.length;i++){
	dImpl.edit("tb_content","ct_id",Integer.parseInt(ct_id[i]));
	dImpl.setValue("ct_sequence",ct_sequence[i],CDataImpl.STRING);
	dImpl.update();	
}

if (dCn.getLastErrString().equals(""))
{
	
	dCn.commitTrans();
	out.print("<script>window.location='Personlist1.jsp?th_id="+th_id+"'</script>");
}
else
{
	dCn.rollbackTrans();
	%>
	<script language="javascript">
		alert("发生错误，录入失败！");
		window.history.go(-1);
	</script>
	<%
}
dImpl.closeStmt();
dCn.closeCn();
} catch (Exception ex) {
	System.out.println(new java.util.Date() + "--"
			+ request.getServletPath() + " : " + ex.getMessage());
} finally {
	if(dImpl != null)
	dImpl.closeStmt();
	if(dCn != null)
	dCn.closeCn();
}

%>