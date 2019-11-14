<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%@page import="com.util.*"%>
<%@page import="Evaluate.*"%>
<%@page import="vote.*"%>

<%

CDataCn dCn = null;

try{
	cCn = new CDataCn();

CDataImpl dImpl = new CDataImpl(dCn);

String state="";
state = CTools.dealString(request.getParameter("state")).trim();
String vt_id = "";
vt_id =	CTools.dealString(request.getParameter("vt_id")).trim();
String del="";
del =	CTools.dealString(request.getParameter("del")).trim();

dImpl.edit("tb_votediyext","vt_id",Integer.parseInt(vt_id));
if(del.equals("0")){
if(state.equals("0")){
dImpl.setValue("vde_status","1",CDataImpl.STRING);
}
if(state.equals("1")){
dImpl.setValue("vde_status","0",CDataImpl.STRING);
}
}
else if(del.equals("1")){
dImpl.setValue("vde_status","2",CDataImpl.STRING);
}
dImpl.update();

if (dCn.getLastErrString().equals(""))
{
	dCn.commitTrans();
	out.print("<script language=javascript>");
	out.print("alert(\"操作已成功\");");
	out.print("window.location.href=\"list.jsp?vde_status="+state+"\";");
	out.print("</script>");
}
else
{
	dCn.rollbackTrans();
	out.print("<script language=javascript>");
	out.print("alert(\"发生错误，录入失败！\");");
	out.print("window.history.go(-1);");
	out.print("</script>");
}

dImpl.update();
dImpl.closeStmt();
}catch(Exception exex){
	
}finally{
	dCn.closeCn();
}

%>
