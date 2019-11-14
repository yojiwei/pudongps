<%@page contentType="text/html; charset=GBK"%>
<%@ include file="../import.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

<style type="text/css">
<!--
@import url("/system/app/skin/skin3/images/main.css");
-->
</style>
<script LANGUAGE="javascript" src="/system/app/publish/common/common.js"></script>
<link href="/system/app/skin/skin3/images/style.css" rel="stylesheet" type="text/css">
</head>
<body leftmargin="0" topmargin="0">
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td height="8"></td>
  </tr>
<%
  String strMenu1=CTools.dealString(request.getParameter("Menu"));
  String strModule1=CTools.dealString(request.getParameter("Module"));
  if(!strMenu1.equals("")) session.setAttribute("_strMenu1",strMenu1);
  if(!strModule1.equals("")) session.setAttribute("_strModule1",strModule1);
  strMenu1=CTools.dealNull(session.getAttribute("_strMenu1"));
  strModule1=CTools.dealNull(session.getAttribute("_strModule1"));
%>
  <tr>
    <td height="20" valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0">
      <tr>
        <td width="42"><img src="/system/app/skin/skin3/images/index_righttb_01.gif" width="42" height="20" /></td>
        <td background="/system/app/skin/skin3/images/index_righttb_bg.gif" class="f12w"><a href="#" class="f12w">广告管理</a></td>
        <td width="115"><img src="/system/app/skin/skin3/images/index_righttb_03.gif" width="115" height="20" /></td>
        <td width="20" background="/system/app/skin/skin3/images/index_righttb_bg.gif"><a href="#" title="刷新页面" onclick="javascript:location.reload();"><img src="/system/app/skin/skin3/images/index_righttb_04.gif" width="20" height="20" border="0" /></a></td>
        <td width="40"><img src="/system/app/skin/skin3/images/index_righttb_02.gif" width="40" height="20" /></td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td height="410" align="center" valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="11" background="/system/app/skin/skin3/images/index_righttd_bgL.gif"></td>
        <td valign="top">
