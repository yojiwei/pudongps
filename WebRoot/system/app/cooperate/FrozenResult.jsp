<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/system/app/skin/import.jsp"%>
<%@page import="com.component.database.*"%>
<%@page import="com.app.*"%>
<%
String selfdtid="";
String sender_id="";

CMySelf self = (CMySelf)session.getAttribute("mySelf");
selfdtid = String.valueOf(self.getDtId());
sender_id = String.valueOf(self.getMyID());

String co_id="";
String cf_reason="";
String de_id="";

co_id = CTools.dealString(request.getParameter("co_id")).trim();
cf_reason = CTools.dealString(request.getParameter("cf_reason")).trim();
de_id = CTools.dealString(request.getParameter("de_id")).trim();
//out.println(de_id);

//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 



dCn.beginTrans();


dImpl.edit("tb_correspond","co_id",co_id);
dImpl.setValue("co_status","2",CDataImpl.STRING);
dImpl.update();

dImpl.addNew("tb_correspondfrozen","cf_id",CDataImpl.PRIMARY_KEY_IS_VARCHAR);
dImpl.setValue("co_id",co_id,CDataImpl.STRING);
dImpl.setValue("cf_reason",cf_reason,CDataImpl.STRING);
dImpl.setValue("cf_starttime",(new java.util.Date()).toLocaleString(),CDataImpl.DATE);
dImpl.update();

dImpl.edit("tb_documentexchange","de_id",de_id);
dImpl.setValue("de_status","2",CDataImpl.STRING);
dImpl.update();

if(dCn.getLastErrString().equals(""))
{
  dCn.commitTrans();
}
else
{
  dCn.rollbackTrans();
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
<script language="javascript">
alert("理由已发送!");
window.opener.location.href="/system/app/cooperate/SignedCorrList.jsp";
window.close();
</script>

