<%@page contentType="text/html; charset=GBK"%>
<%@include file="../skin/import.jsp"%>
<%@page import="com.app.*"%>
<!--接受反馈信息（项目督办，协调单督办），存入数据库-->
<%

    String sv_type="";
   sv_type= CTools.dealString(request.getParameter("sv_type")).trim();
   //out.println("sv_type ="+sv_type);

   String sv_feedback="";
   sv_feedback= CTools.dealString(request.getParameter("sv_feedback")).trim();
  // out.println("sv_feedback ="+sv_feedback);

  String de_id="";
  de_id = CTools.dealString(request.getParameter("de_id")).trim();
  //out.println("de_id ="+de_id);

    String sv_id="";
  sv_id = CTools.dealString(request.getParameter("sv_id")).trim();
  //out.println("sv_id ="+sv_id + "efer");


    String dt_id="";
  dt_id = CTools.dealString(request.getParameter("dt_id")).trim();
  //out.println("dt_id ="+dt_id );

String selfdtid="";
String sender_id="";
CMySelf self = (CMySelf)session.getAttribute("mySelf");
selfdtid = String.valueOf(self.getDtId());//取当前用户部门id的值
sender_id = String.valueOf(self.getMyID());//取当前用户id的值


//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 
DataDealImpl dDealImpl = new DataDealImpl(dCn.getConnection()); //\u6570\u636E\u4EA4\u6362\u5B9E\u73B0
dCn.beginTrans();


dImpl.edit("tb_documentexchange","de_id",de_id);
dImpl.setValue("de_senddeptid",selfdtid,CDataImpl.STRING);



dImpl.setValue("de_status","4",CDataImpl.STRING);
java.util.Date FinishTime = new java.util.Date();//取得当前系统的时间
dImpl.setValue("de_feedbacktime",FinishTime.toLocaleString(),CDataImpl.DATE);
dImpl.setValue("DE_RECEIVERDEPTID",dt_id,CDataImpl.STRING);
dImpl.update();


dImpl.edit("tb_supervise","sv_id",sv_id);
dImpl.setValue("sv_type",sv_type,CDataImpl.STRING);
dImpl.update();
dImpl.setClobValue("sv_feedback",sv_feedback);

dCn.commitTrans();
dImpl.closeStmt();
dCn.closeCn();
%>

<script language="javascript">
alert("反馈信息已提交");
window.opener.location.href='SupervisalSign.jsp';
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