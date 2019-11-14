<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/import.jsp"%>
<%
CDataCn dCn = new CDataCn(); //新建数据库连接对象
CDataImpl dImpl = new CDataImpl(dCn); //新建数据接口对象

com.jspsmart.upload.SmartUpload myUpload = new com.jspsmart.upload.SmartUpload();
myUpload.initialize(pageContext);
myUpload.setDeniedFilesList("exe,bat,jsp");
myUpload.upload();

String sendTime = new CDate().getNowTime();
String mmt_id = CTools.dealUploadString(myUpload.getRequest().getParameter("sm_id"));
String mmt_ct_id = CTools.dealUploadString(myUpload.getRequest().getParameter("sm_ct_id"));
String sj_id = CTools.dealUploadString(myUpload.getRequest().getParameter("mysj_id"));
String sm_con = CTools.dealUploadString(myUpload.getRequest().getParameter("content1"));

System.out.println(sm_con+"--------"+mmt_id);
dImpl.edit("tb_sms","sm_id",mmt_id);    //修改短信内容
dImpl.setValue("sm_con",sm_con,CDataImpl.STRING);//修改后的内容
dImpl.setValue("sm_sendtime",sendTime,CDataImpl.DATE);//修改后的时间
dImpl.setValue("sm_sj_id",sj_id,CDataImpl.STRING);//修改后的栏目ID
dImpl.update();


dImpl.closeStmt();
dCn.closeCn();
%>
<script>window.location="message.jsp";</script>