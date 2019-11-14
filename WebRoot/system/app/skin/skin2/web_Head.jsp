<%
	if session("_userID")="" then
%>
<script LANGUAGE="javascript">
<!--
	alert('请重新登录！');
	top.navigate("../../default.asp");
//-->
</script>
<%
	End if
%>
<head>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="expires" content="web,26 Feb 1960 08:21:57 GMT">
<meta http-equiv="Content-Type" content="text/html;charset=gb2312">
<META<%if 24=Session("_PageEffect") then Response.Write "1"%> content=revealTrans(Duration=1.0,Transition=<%=Session("_PageEffect")%>) http-equiv=Page-Enter>
<link href="/system/app/skin/skin2/Include/style.css" rel="stylesheet" type="text/css">
<title> 电子政务系统</title>
</head>
<!--#include file="../../Include/cn.asp"-->
<body  onload="window.focus();" <%if Session("_Shield")=1 then%><%=Application("_sysEffect")%><%end if%> topmargin="0" leftmargin="0">
<%
	'//查询菜单信息，放置到Session
	SubMenuID=Request.QueryString("SubMenuID")  '//子菜单项
	if SubMenuID<>"" then '//如果是点击左侧的子菜单项进入
		Session("_SubMenuID")=SubMenuID
		Session("_Menu")=Request.QueryString("Menu")		 '//大菜单项
		Session("_Module")=Request.QueryString("Module")		 '//模块名称
		Sql="Select * from Functions where ID="&SubMenuID
		Set Rs=Cn.execute(Sql)
		Session("_SubMenuName")=Rs("Name")			'功能名称
		Session("_SubMenuFastHelp")=Rs("FastHelp")			'功能快速入门
		Session("_SubMenuHelpID")=Rs("HelpID")			'功能帮助主题ID
	end if

	Call GetHeadInfo()
%>

<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
</head>

<body bgcolor="#FFFFFF" text="#000000">
<div id="fastHelp" style="display:none"><%=Session("_SubMenuFastHelp")%></div>
<!--#include file="inc/web_main_top.asp"-->
<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
<iframe style="display:none" id="hiddenFrm"></iframe>
<form name="NavigateFrm" target="main">
	<input type=hidden value="<%=Session("_SubMenuHelpID")%>" name=helpID>
</form>
  <tr>
    <td width="18" background="/system/app/skin/skin2/oa_pic/main_4.gif"><img src="/system/app/skin/skin2/oa_pic/main_4.gif" width="13" height="5"></td>
    <td valign="top">
