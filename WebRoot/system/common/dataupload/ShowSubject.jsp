
<%@ page language="java" import="java.util.StringTokenizer" pageEncoding="UTF-8"%>
<%
String subStr = request.getParameter("subject1");
String strValue = request.getParameter("subjectValue");
StringTokenizer token = new StringTokenizer(subStr,",");
StringTokenizer token2 = new StringTokenizer(strValue,",");
int len = token.countTokens();
String[] str = new String[len];
for(int cnt = 0; cnt < len; cnt++)
	str[cnt] = 	token.nextToken();

int len2 = token2.countTokens();
String[] str2 = new String[len2];
for(int k = 0; k < len2; k++)
	str2[k] = 	token2.nextToken();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    
    
    <title>ShowSubject.jsp</title>
    
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
    <meta http-equiv="description" content="This is my page">
    
    <!--
    <link rel="stylesheet" type="text/css" href="styles.css">
    -->
  </head>
 <form name="showsubject" mothed="post" action="" >
  <body>
  	请选择要提交到的栏目：<br/>
  	<%
  	for(int count = 0; count < str.length; count++){
  	%>  
  	<INPUT type="checkBox" name="radioSub" value="<%= str2[count]%>"><%= str[count]%><br/>
  	<%
  	}
  	%>
  	<br/>
  	<br/>
  	<input type="button" name="tijiao" value="确定" onclick="setSubValue()"/>
  	<input type="button" name="guanbi" value="关闭" onclick="window.close();"/>
  </body>
 </form>
<script language="javascript">
 function setSubValue(){
 	var subValue = document.getElementsByName("radioSub");
 	var len = subValue.length;
 	var rtnStr = "";
 	for(var cnt = 0; cnt < len; cnt++){
 		if(subValue[cnt].checked)
 			rtnStr = rtnStr + subValue[cnt].value + ",";
 	}
 	
 	if(rtnStr != ""){
 		returnValue=rtnStr;
	 	window.close();
	 }else{
	 	alert("您没有选择部门！");
	 }
 	
 }
</script>
</html>
