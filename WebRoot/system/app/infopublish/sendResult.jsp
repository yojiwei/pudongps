<%@page contentType="text/html; charset=GBK"%>
<%@ page import="com.beyondbit.web.publishinfo.Messages,com.smsCase.*" %>
<%@ page import="com.beyondbit.dataexchange.*,org.apache.log4j.*" %>
<%@include file="/system/app/skin/head.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <body>
<%
CMySelf mySelf = (CMySelf)session.getAttribute("mySelf");
String userName = mySelf.getMyName();
String userId = String.valueOf(mySelf.getMyUid());
String dt_id= String.valueOf(mySelf.getDtId());

String messages = CTools.dealString(request.getParameter("messages"));
messages=messages+" 详见“上海浦东”";
String sj_id = CTools.dealString(request.getParameter("mysj_id"));
String sendTime = CDate.getNowTime();
String sm_tel="";
String sm_con =messages;
String ct_id =  CTools.dealNull(request.getParameter("ct_id"));

CDataCn dCn = new CDataCn(); //新建数据库连接对象
CDataImpl dImpl = new CDataImpl(dCn); //新建数据接口对象
Hashtable contentyn = null;
Hashtable contentlj = null;
  
if(!messages.equals(" 详见“上海浦东”"))
{
	dImpl.addNew("tb_sms","sm_id");
	dImpl.setValue("sm_tel", sm_tel, CDataImpl.STRING);// 用户手机号码----保存为空
	dImpl.setValue("sm_con", sm_con, CDataImpl.STRING);// 发送内容----------手机短信
	dImpl.setValue("sm_flag","2", CDataImpl.STRING);// 发送与否的标志没有发送1发送成功0发送失败3正在发送中...
	dImpl.setValue("sm_flagtoo","10", CDataImpl.STRING);//发送的优先级别1发送验证码快10发送短信内容
	dImpl.setValue("sm_check","1",CDataImpl.STRING);//待审核1没有通过3通过2
	dImpl.setValue("sm_dtid", dt_id, CDataImpl.STRING);//部门ID
	dImpl.setValue("sm_sj_id",sj_id,CDataImpl.STRING);//所属栏目ID
	dImpl.setValue("sm_sendtime",sendTime,CDataImpl.DATE);	//发布的时间
	dImpl.setValue("sm_ct_id",ct_id,CDataImpl.STRING);	//跟发布的哪个信息有关
	dImpl.setValue("sm_detail","",CDataImpl.STRING);	//发布内容为空
	dImpl.update();
	
	//保存subscriptlog里放一份
	dImpl.addNew("subscibelog","id");
	dImpl.setValue("content", sm_con, CDataImpl.STRING);// 发送内容--------手机验证码--手机短信
	dImpl.setValue("sendflag", String.valueOf(2), CDataImpl.STRING);// 2待审核3审核通过
	dImpl.setValue("sj_id", sj_id, CDataImpl.STRING);//发送的优先级别1发送验证码快10发送短信内容垃圾
	dImpl.setValue("subscibeid",sm_tel,CDataImpl.STRING);//审核没有通过的标志
	dImpl.setValue("sendtime",sendTime,CDataImpl.DATE);	//发布的时间
	dImpl.update();
}
dImpl.closeStmt();
dCn.closeCn();
%>
<script language='javascript'>window.location.href='sendDx.jsp';</script>
  </body>
</html>