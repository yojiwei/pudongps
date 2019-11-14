<%@page contentType="text/html; charset=GBK"%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>上海浦东门户网站后台管理系统</title>
<link href="/system/app/skin/skin4/css/style_list.css" rel="stylesheet" type="text/css">
<script LANGUAGE="javascript" src="/system/app/infopublish/common/common.js"></script>
</head>
<script LANGUAGE="javascript">
try{
if(parent.window != window || parent.opener != null){
 
}else{
    window.location.href="http://system.pudong.gov.cn";
}
}catch(e){}
</script>
<body leftmargin="0" topmargin="0">
<%
  String strMenu2=CTools.dealString(request.getParameter("Menu"));
  String strModule2=CTools.dealString(request.getParameter("Module"));
  if(!strMenu2.equals("")) session.setAttribute("_strMenu2",strMenu2);
  if(!strModule2.equals("")) session.setAttribute("_strModule2",strModule2);
  strMenu2=CTools.dealNull(session.getAttribute("_strMenu2"));
  strModule2=CTools.dealNull(session.getAttribute("_strModule2"));
%>