<%@page contentType="text/html; charset=GBK"%>
<%@ include file="/website/include/import.jsp" %>
<%
String url = "http://shuyuandj.pudong.gov.cn";
try{ 

WeChatController wc = new WeChatController();
String returnMsg = wc.getWechatParam(url);
System.out.println(returnMsg);

}catch(Exception testexp){
	testexp.printStackTrace();
}
%>