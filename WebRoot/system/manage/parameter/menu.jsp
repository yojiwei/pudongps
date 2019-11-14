<%@ page contentType="text/html; charset=GBK" %>
<%@ page import="com.component.treeview.*" %>
<%@ page import="com.platform.module.CModuleXML" %>
<html>
<head>
<meta http-equiv="pragma" content="no-cache">
<link href="../style.css" rel="stylesheet" type="text/css">
<title></title>
<script LANGUAGE="javascript" src="../../common/treeview/treeJs.js"></script>
</head>

<script language="javascript">
function title_click()
{
	var url = "/system/platform/setholidays/SetCalendar.jsp";
	//alert(url);
	parent.frames("main").location.href=url;
	return;
}
</script>
<body bgcolor="#9FB7C0" topmargin="0" leftmargin=10  style="font-size: 8pt; border: 1 dotted #000000" >

<div style="position: absolute; top: 7; left: 29; width: 86; height: 10;TEXT-ALIGN:center;COLOR: #99ccff;" class="dotted-table">
系统设置
</div>
<table border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="26%" id="AutoNumber1">
  <tr>
    <td width="100%" colspan="3">
    <table border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="100%" id="AutoNumber2">
      <tr>
        <td width="19%" background="../images/FrameTopLeft.gif">
        <img border="0" src="../images/FrameTopLeft.gif" width="136" height="31"></td>
        <td width="82%" background="../images/FrameTopcenter.gif" align=right>
        <a href="javascript:window.location.reload();">刷新</a>
        </td>
        <td width="100%"  align="right"><img border="0" src="../images/FrameTopRight.gif" width="12" height="31"></td>
      </tr>
    </table>
    </td>
  </tr>
  <tr>
    <td width="100%" colspan="3">
    <table border="0" cellpadding="0" id="dataBoard" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="100%" id="AutoNumber3" height="54">
      <tr>
        <td width="3%" background="../images/FrameLeft.gif" height="54">
        <img border="0" src="../images/FrameLeft.gif" width="13" height="9"></td>
        <td width="208%" height="355" valign=top class=dotted-table>

			<br>
			<img src="/system/images/arrow.gif" border="0" WIDTH="12" HEIGHT="13">
			<a target="main" href="/system/platform/parameter/parameterList.jsp">预设参数</a>
			<br>
			<img src="/system/images/arrow.gif" border="0" WIDTH="12" HEIGHT="13">
			<a target="main" href="/system/platform/setholidays/SetCalendar.jsp">工作日/节假日设置</a>
			<br>
			<img src="/system/images/arrow.gif" border="0" WIDTH="12" HEIGHT="13">
			<a target="main" href="/system/platform/formatdatabase/format.jsp">清除数据库数据</a>
			<br>
			<img src="/system/images/arrow.gif" border="0" WIDTH="12" HEIGHT="13">
			<a href="/SendMailServlet">发送邮件</a>
		</td>
        <td width="22%" background="../images/FrameRight.gif" height="54">
        <p align="right">
        <img border="0" src="../images/FrameRight.gif" width="7" height="9"></td>
      </tr>
    </table>
    </td>
  </tr>
  <tr>
    <td width="3%" background="../images/FrameBottomCenter.gif" height="8">
    <img border="0" src="../images/FrameBottomLeft.gif" width="15" height="8"></td>
    <td width="97%" background="../images/FrameBottomCenter.gif">
    <img border="0" src="../images/FrameBottomCenter.gif" width="10" height="8"></td>
    <td width="3%" align=right>
    <img border="0" src="../images/FrameBottomRight.gif" width="11" height="8"></td>
  </tr>
</table>

