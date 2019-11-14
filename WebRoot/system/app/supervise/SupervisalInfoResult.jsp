<%@page contentType="text/html; charset=GBK"%>
<%@include file="../skin/import.jsp"%>
<%@page import="com.component.database.*"%>
<!--接受督办信息（项目督办，协调单督办），存入数据库-->
<%
String selfdtid="";
String sender_id="";
CMySelf self = (CMySelf)session.getAttribute("mySelf");
//out.println(self.getDtId());
selfdtid = String.valueOf(self.getDtId());//\u53D6\u5F53\u524D\u7528\u6237\u90E8\u95E8id\u7684\u503C
sender_id = String.valueOf(self.getMyID());//\u53D6\u5F53\u524D\u7528\u6237id\u7684\u503C

//out.println("dept is"+selfdtid);
//out.println("member is"+sender_id);

String svName="";
String svContent ="";
String svdtName="";

String  wo_id="";
String dt_id="";
String strStatus = "4";//\uFF08\u6587\u4EF6\u4EA4\u6362\u7BB1\u7C7B\u578B\uFF092\u662F\u9879\u76EE\u7763\u529E
String status_id ="1";//\uFF08\u6587\u4EF6\u4EA4\u6362\u72B6\u6001\uFF091\u662F\u53D1\u9001
String sqlWait="";
String sv_id="";
String co_id="";


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
 //out.println("wo_id is"+wo_id);
 //out.println("dt_id is"+dt_id);
 svName = CTools.dealString(request.getParameter("svName")).trim();
 svContent = CTools.dealString(request.getParameter("svContent")).trim();

dCn.beginTrans();
if (co_id.equals(""))
{

String a = dImpl.addNew("tb_supervise","sv_id",CDataImpl.PRIMARY_KEY_IS_VARCHAR);
// out.println("sv_id is"+sv_id);
dImpl.setValue("sv_dtname",svName,CDataImpl.STRING);
dImpl.setValue("sv_type","4",CDataImpl.STRING);
dImpl.setValue("sv_FOREIGNID",wo_id,CDataImpl.STRING);
dImpl.update();
dImpl.setClobValue("sv_content",svContent);

String de_id = dImpl.addNew("tb_documentexchange","de_id",CDataImpl.PRIMARY_KEY_IS_VARCHAR);



dImpl.setValue("de_primaryid",a,CDataImpl.STRING);
dImpl.setValue("de_type","4",CDataImpl.STRING);
dImpl.setValue("de_sendtime",FinishTime.toLocaleString(),CDataImpl.DATE);
dImpl.setValue("de_senddeptid",selfdtid,CDataImpl.STRING);
dImpl.setValue("de_senderid",sender_id,CDataImpl.STRING);
dImpl.setValue("de_status",status_id,CDataImpl.STRING);
dImpl.setValue("de_receiverdeptid",dt_id,CDataImpl.STRING);
dImpl.update();
}
else
{

String b = dImpl.addNew("tb_supervise","sv_id",CDataImpl.PRIMARY_KEY_IS_VARCHAR);
// out.println("sv_id is"+sv_id);
dImpl.setValue("sv_dtname",svName,CDataImpl.STRING);
dImpl.setValue("sv_type","5",CDataImpl.STRING);
dImpl.setValue("sv_FOREIGNID",co_id,CDataImpl.STRING);
dImpl.update();
dImpl.setClobValue("sv_content",svContent);

String de_id = dImpl.addNew("tb_documentexchange","de_id",CDataImpl.PRIMARY_KEY_IS_VARCHAR);
//dDealImpl.setRecord("tb_documentexchange",ConstantList.RECORDINSERT,de_id);


dImpl.setValue("de_primaryid",b,CDataImpl.STRING);
dImpl.setValue("de_type","5",CDataImpl.STRING);
dImpl.setValue("de_sendtime",FinishTime.toLocaleString(),CDataImpl.DATE);
dImpl.setValue("de_senddeptid",selfdtid,CDataImpl.STRING);
dImpl.setValue("de_senderid",sender_id,CDataImpl.STRING);
dImpl.setValue("de_status",status_id,CDataImpl.STRING);
dImpl.setValue("de_receiverdeptid",dt_id,CDataImpl.STRING);
dImpl.update();


}
dCn.commitTrans();
dImpl.closeStmt();
dCn.closeCn();
%>

<script language="javascript">
alert("督办单已提交");
window.close();
</script>
<%


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
