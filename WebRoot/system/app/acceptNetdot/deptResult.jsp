<%@page contentType="text/html; charset=GBK"%>
<%@include file="../skin/head.jsp"%>

<%
String dt_id = CTools.dealString(request.getParameter("dt_id"));
String OPType = CTools.dealString(request.getParameter("OPType"));
String dt_name = CTools.dealString(request.getParameter("dt_name"));
String dt_addr = CTools.dealString(request.getParameter("dt_addr"));
String dt_phone = CTools.dealString(request.getParameter("dt_phone"));
String dt_email = CTools.dealString(request.getParameter("dt_email"));
String dt_postnum = CTools.dealString(request.getParameter("dt_postnum"));
String dt_postaddr = CTools.dealString(request.getParameter("dt_postaddr"));
String dt_fax = CTools.dealString(request.getParameter("dt_fax"));
String dt_principal = CTools.dealString(request.getParameter("dt_principal"));
String dt_officehours = CTools.dealString(request.getParameter("dt_officehours"));
String dt_x = CTools.dealString(request.getParameter("mp_x"));
String dt_y = CTools.dealString(request.getParameter("mp_y"));


String dt_create_time = new CDate().getThisday();
CDataCn dCn = null;
CDataImpl dImpl = null;
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn);

dImpl.setTableName("tb_departinfo");
dImpl.setPrimaryFieldName("dt_id");
if(OPType.equals("Add"))
{
	dt_id = Long.toString(dImpl.addNew());	
}
else if(OPType.equals("Edit"))
{
	dImpl.edit("tb_departinfo","dt_id",Integer.parseInt(dt_id));	
}

dImpl.setValue("dt_name",dt_name,CDataImpl.STRING);
dImpl.setValue("dt_addr",dt_addr,CDataImpl.STRING);
dImpl.setValue("dt_phone",dt_phone,CDataImpl.STRING);
dImpl.setValue("dt_create_time",dt_create_time,CDataImpl.DATE);
dImpl.setValue("dt_email",dt_email,CDataImpl.STRING);
dImpl.setValue("dt_postnum",dt_postnum,CDataImpl.STRING);
dImpl.setValue("dt_postaddr",dt_postaddr,CDataImpl.STRING);
dImpl.setValue("dt_fax",dt_fax,CDataImpl.STRING);
dImpl.setValue("dt_principal",dt_principal,CDataImpl.STRING);
dImpl.setValue("dt_officehours",dt_officehours,CDataImpl.STRING);
dImpl.setValue("dt_x",dt_x,CDataImpl.INT);
dImpl.setValue("dt_y",dt_y,CDataImpl.INT);
dImpl.update();

if (dCn.getLastErrString().equals(""))
	{
		
		dCn.commitTrans();
%>
		<script language="javascript">
			alert("操作已成功！");
			window.location="deptList.jsp";
		</script>
<%
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
