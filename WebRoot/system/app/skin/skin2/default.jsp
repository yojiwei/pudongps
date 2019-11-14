<%@ page contentType="text/html; charset=GBK" %>
<html>
<head>
<title>办公自动化系统 (Ver 2.0)--[当前用户：xxx</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
</head>
<script>
var y=100;
function expend(){
    main_frm.cols="110,*";
}
function close(){
    main_frm.cols="0,*";
}

function goUp(){
	y=y-100;
	if (y<=0) y=0;
	for (var I=y; I>=0; I--){
		window.nav.scroll(1,I);
  }
}
function goDown(){
	y=y+100;
	for (var I=1; I<=y; I++){
		window.nav.scroll(1,I);
  }

}
	function unloads()
	{
		PopupForm.navigate ("common/callcenter/clearUser.jsp");
	}


</script>
<frameset onunload="unloads()" rows="79,*" cols="*" frameborder="NO" border="0" framespacing="0">
  <frame name="topFrame" scrolling="NO" noresize src="top.jsp" >
  <frameset name="main_frm" cols="110,*" frameborder="NO" border="0" framespacing="0" rows="*">
    <frame NAME="nav" noresize scrolling="NO" src="Menu.jsp">
    <frameset cols="22,*,0" frameborder="NO" border="0" framespacing="0">
      <frame NAME="menu" name="leftFrame1" scrolling="NO" noresize src="left_2.jsp">
      <frame NAME="main" name="mainFrame" src="/system/app/navigator/todayaffair/AffairList.jsp?Menu=导航&Module=今日事务&SubMenuID=432">
	  <frame NAME="PopupForm" SRC="">
    </frameset>
  </frameset>
</frameset>

<noframes>
<body bgcolor="#FFFFFF" text="#000000">
</body>
</noframes>
</html>
<html>
</html>
