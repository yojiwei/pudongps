
<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@page import="com.util.CBase64"%>
<%
//String content1 = CBase64.getFileEncodeString("F:\\jpg\\yanker.jpg");
String content2 = CBase64.getFileEncodeString("e:\\646PIC.BMP");
String content3 =  CBase64.getFileEncodeString("d:\\bea\\user_projects\\newdomain\\applications\\DefaultWebApp\\front\\image\\deptlistindex24.gif");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
<SCRIPT LANGUAGE="javascript" src="http://dangwu.pudong.gov.cn/system/common/dataupload/DataUploadJs.js"></SCRIPT>
    <title>My JSP 'TestData.jsp' starting page</title>
    
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
    <meta http-equiv="description" content="This is my page">
    
    <!--
    <link rel="stylesheet" type="text/css" href="styles.css">
    -->
  </head>
  
  <body>
    <input type="button" name="tijiao" value="提交" onClick="getSubmitValues('title','中俄地撒国务卿俄特务不罕见','2006-05-04','ehrh','<%=content2%>,<%=content3%>,','bmp,gif,','dsfbhwdf,2462,2462437,','273,274,275,','23');"/>
    
  </body>
</html>
