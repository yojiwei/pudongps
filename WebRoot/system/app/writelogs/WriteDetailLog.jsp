<%@page contentType="text/html; charset=GBK"%>
<%
//session丢失处理
response.addHeader("P3P","CP=CAO PSA OUR");

com.app.CMySelf logself = (com.app.CMySelf)session.getAttribute("mySelf");
String logUid = String.valueOf(logself.getMyUid());
com.service.log.LogservicePd logservicepd = new com.service.log.LogservicePd();
SimpleDateFormat logdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
//写日志

String log_levn = "互动查看";
String log_description = logUid+"用户在"+logdf.format(new java.util.Date())+"操作"+logstrMenu+"--"+logstrModule+"-"+cw_id+"-的详细页面";
String log_issuccess = "成功";
//logservicepd.writeLog(log_levn,log_description,log_issuccess,logUid);
//写日志
%>