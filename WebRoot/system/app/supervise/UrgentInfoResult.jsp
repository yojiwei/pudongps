<%@page contentType="text/html; charset=GBK"%>
<%@include file="../skin/import.jsp"%>
<%@page import="com.component.database.*"%>
<%
String selfdtid="";
String sender_id="";
CMySelf self = (CMySelf)session.getAttribute("mySelf");

selfdtid = String.valueOf(self.getDtId());//取当前用户部门id的值
sender_id = String.valueOf(self.getMyID());//取当前用户id的值


String UngerName="";
String UngerContent ="";
String  wo_id="";
String  co_id="";
String  dt_id="";

String sqlWait="";



//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 

DataDealImpl dDealImpl = new DataDealImpl(dCn.getConnection());
java.util.Date FinishTime = new java.util.Date();


 co_id = CTools.dealString(request.getParameter("co_id")).trim();
 wo_id = CTools.dealString(request.getParameter("wo_id")).trim();
 dt_id = CTools.dealString(request.getParameter("dt_id")).trim();

 UngerName = CTools.dealString(request.getParameter("UngerName")).trim();
 UngerContent = CTools.dealString(request.getParameter("UngerContent")).trim();

dCn.beginTrans();
//当co_id为空的时候表示，提交的是项目催办
if (co_id.equals(""))
{
 //a表示接受数据库表自动生成的ur_id
 String a=dImpl.addNew("tb_urgent","ur_id",CDataImpl.PRIMARY_KEY_IS_VARCHAR);

dImpl.setValue("ur_dtname",UngerName,CDataImpl.STRING);
//ur_type值为2时，表示项目的催办
dImpl.setValue("ur_type","2",CDataImpl.STRING);
dImpl.setValue("UR_FOREIGNID",wo_id,CDataImpl.STRING);
dImpl.update();
dImpl.setClobValue("ur_content",UngerContent);

 dImpl.addNew("tb_documentexchange","de_id",CDataImpl.PRIMARY_KEY_IS_VARCHAR);

dImpl.setValue("de_primaryid",a,CDataImpl.STRING);
dImpl.setValue("de_type","2",CDataImpl.STRING);
dImpl.setValue("de_sendtime",FinishTime.toLocaleString(),CDataImpl.DATE);
dImpl.setValue("de_senddeptid",selfdtid,CDataImpl.STRING);
dImpl.setValue("de_senderid",sender_id,CDataImpl.STRING);
dImpl.setValue("de_status","1",CDataImpl.STRING);
dImpl.setValue("de_receiverdeptid",dt_id,CDataImpl.STRING);
dImpl.update();
}
else
{
String b = dImpl.addNew("tb_urgent","ur_id",CDataImpl.PRIMARY_KEY_IS_VARCHAR);

dImpl.setValue("ur_dtname",UngerName,CDataImpl.STRING);
//ur_type是3表示协调单的催办
dImpl.setValue("ur_type","3",CDataImpl.STRING);
dImpl.setValue("UR_FOREIGNID",co_id,CDataImpl.STRING);
dImpl.update();
dImpl.setClobValue("ur_content",UngerContent);

 dImpl.addNew("tb_documentexchange","de_id",CDataImpl.PRIMARY_KEY_IS_VARCHAR);
dImpl.setValue("de_primaryid",b,CDataImpl.STRING);
dImpl.setValue("de_type","3",CDataImpl.STRING);//de_type是协调单催办“3”
dImpl.setValue("de_sendtime",FinishTime.toLocaleString(),CDataImpl.DATE);
dImpl.setValue("de_senddeptid",selfdtid,CDataImpl.STRING);
dImpl.setValue("de_senderid",sender_id,CDataImpl.STRING);
dImpl.setValue("de_status","1",CDataImpl.STRING);
dImpl.setValue("de_receiverdeptid",dt_id,CDataImpl.STRING);
dImpl.update();
}

dCn.commitTrans();
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
alert("\u50AC\u529E\u5355\u5DF2\u63D0\u4EA4\uFF01");
window.close();


</script>