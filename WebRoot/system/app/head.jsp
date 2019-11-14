<%@ page contentType="text/html;charset=gb2312" %>
<html>
<head>
<title>管理系统</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link rel="stylesheet" href="main.css" type="text/css">
</head>
<body>
<script>
function tick() {
var hours, minutes, seconds, xfile;
var intHours, intMinutes, intSeconds;
var today;
today = new Date();
intHours = today.getHours();
intMinutes = today.getMinutes();
intSeconds = today.getSeconds();
if (intHours == 0) {
hours = "12:";
xfile = "午夜";
} else if (intHours < 12) {
hours = intHours+":";
xfile = "上午";
} else if (intHours == 12) {
hours = "12:";
xfile = "中午";
} else {
intHours = intHours - 12
hours = intHours + ":";
xfile = "下午";
}
if (intMinutes < 10) {
minutes = "0"+intMinutes+":";
} else {
minutes = intMinutes+":";
}
if (intSeconds < 10) {
seconds = "0"+intSeconds+" ";
} else {
seconds = intSeconds+" ";
}
timeString = xfile+hours+minutes+seconds;
Clock.innerHTML = timeString;
window.setTimeout("tick();", 100);
}
window.onload = tick;
</script>

<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr>
    <td colspan="3" class="color1" height=10></td>
  </tr>
  <tr>
    <td colspan="3" height="1" class="color2"></td>
  </tr>
  <tr>
    <td width="668"><img src="system_head_1.gif" width="668" height="68"></td>
    <td background="system_head_line.gif">&nbsp;</td>
    <td width="95"><img src="system_head_2.gif" width="95" height="68"></td>
  </tr>
 <%
 /*
   String sUser=(String)session.getAttribute("User");
	if (sUser==null)
	{
		out.print("<script language=javascript>");
		out.print("alert('登录已超时,请返回首页重新登录!');");
		out.print("window.parent.location='/system/login.jsp'");
		out.print("</script>");
		return;
	}

*/

 %>
  <tr>
    <td colspan="3" height=20 class="color3" align=center>
      <table width="90%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="91%">
            <div align="center">
              <table width=450 cellspacing=0 cellpadding=0 border=0 aling=center>
                <tr>
                  <td align=center> <font color="#ffffff">亲爱的用户</font>&nbsp;<font color="#ffb400"><%//=sUser%></font>&nbsp;<font color="#ffffff">您好！</font>
                  </td>
                  <td align=center width=250> <font color=#ffffff>现在是：
                    <script language=JavaScript>
	<!--
	function makeArray() {
	var args = makeArray.arguments;
	for (var i = 0; i < args.length; i++) {
	this[i] = args[i];
	}
	this.length = args.length;
	}
	function fixDate(date) {date.setTime(Date.parse(document.lastModified));}
	function getString(date) {var months = new makeArray("1", "2", "3","4","5","6", "7","8","9","10", "11", "12");
	var day_of_week = date.getDay();
	var str = "";
	if (day_of_week == 0)
	    str = "星期天 ";
	if (day_of_week == 1)
	    str = "星期一 ";
	if (day_of_week == 2)
	    str = "星期二 ";
	if (day_of_week == 3)
 	   str = "星期三 ";
	if (day_of_week == 4)
 	   str = "星期四 ";
	if (day_of_week == 5)
 	   str = "星期五 ";
	if (day_of_week == 6)
	    str = "星期六 ";
	return ((date.getYear() < 100) ? "19" : "") + date.getYear()+"年"+"    "+months[date.getMonth()] + "月" + date.getDate() + "日"+"    "+str;
	}
	var cur = new Date();
	fixDate(cur);
	var str = getString(cur);
	document.write(str);
	// -->
	</script>
                    </font> </td>
                  <td align=center width=85><font color=#ffffff>
                    <div id="Clock" align="center"></div>
                    </font></td>
                </tr>
              </table>
            </div>
          </td>
          <td width="9%"><a href="/system/app/logout.jsp" target="_parent"><font color="#FFFFFF">退出</font></a></td>
        </tr>
      </table>
    </td>
  </tr>
</table>