<%@page contentType="text/html; charset=GBK"%>
<%@ page import="com.beyondbit.web.publishinfo.Messages,com.smsCase.*" %>
<%@ page import="com.beyondbit.dataexchange.*,org.apache.log4j.*" %>
<%@include file="/system/app/skin/head.jsp"%>
<html>
  <body>
<%
CMySelf mySelf = (CMySelf)session.getAttribute("mySelf");
String userName = mySelf.getMyName();
String userId = String.valueOf(mySelf.getMyUid());
String dt_id= String.valueOf(mySelf.getDtId());

String sm_con = CTools.dealString(request.getParameter("content"));
String sendTime = new com.util.CDate().getNowTime();
String sm_tel =  CTools.dealNull(request.getParameter("tel"));

CDataCn dCn =null; //新建数据库连接对象
CDataImpl dImpl = null; //新建数据接口对象
try{

dCn = new CDataCn(); //新建数据库连接对象
dImpl = new CDataImpl(dCn); //新建数据接口对象

dImpl.addNew("tb_sms","sm_id");
dImpl.setValue("sm_tel", sm_tel, CDataImpl.STRING);// 用户手机号码----保存为空
dImpl.setValue("sm_con", sm_con, CDataImpl.STRING);// 发送内容----------手机短信
dImpl.setValue("sm_flag","3", CDataImpl.STRING);// 发送与否的标志0发送失败1发送成功2没有发送3正在发送中
dImpl.setValue("sm_flagtoo","1", CDataImpl.STRING);//发送的优先级别1发送验证码快10发送短信内容
dImpl.setValue("sm_check","2",CDataImpl.STRING);//1待审核2通过3审核没通过
dImpl.setValue("sm_dtid", dt_id, CDataImpl.STRING);//部门ID
dImpl.setValue("sm_sendtime",sendTime,CDataImpl.DATE);	//发布的时间
dImpl.update();

//保存subscriptlog里放一份
dImpl.addNew("subscibelog","id");
dImpl.setValue("content", sm_con, CDataImpl.STRING);// 发送内容--------手机验证码--手机短信
dImpl.setValue("sendflag", String.valueOf(2), CDataImpl.STRING);// 2待审核3审核通过
dImpl.setValue("subscibeid",sm_tel,CDataImpl.STRING);//审核没有通过的标志
dImpl.setValue("sendtime",sendTime,CDataImpl.DATE);	//发布的时间
dImpl.update();

}
catch(Exception ex)
{
	System.out.println(new java.util.Date() + "--"
	+ request.getServletPath() + " : " + ex.getMessage());
}finally{
dImpl.closeStmt();
dCn.closeCn();
}
%>
<script language='javascript'>window.location.href='sendTest.jsp';</script>
  </body>
</html>