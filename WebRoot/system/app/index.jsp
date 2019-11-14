<%@ page contentType="text/html; charset=GBK" %>
<%response.sendRedirect("skin/skin4/login.jsp");%>
<HTML><HEAD><TITLE>上海浦东--后台管理</TITLE>
<META content="text/html; charset=gb2312" http-equiv=Content-Type>
<META content="MSHTML 5.00.2920.0" name=GENERATOR>
<link rel="stylesheet" href="/system/images/yangshi.css" type="text/css">
<script LANGUAGE="javascript">
function check()
{
	var key = event.keyCode;
	if (key == 13)
        checklogin();
	return;
}

function checklogin()
{
	var form = document.formData ;
	if	 (form.UI_name.value =="")
	{
		alert("请填写登陆用户！");
		form.UI_name.focus();
		return false;
	}
	if	 (form.UI_password.value =="")
	{
		alert("请填写登陆密码！");
		form.UI_password.focus();
		return false;
	}
	form.submit() ;
}
</script>
</HEAD>
<BODY bgColor=#FFFFFF leftMargin=0
text=#000000 topMargin=0 marginheight="0" marginwidth="0">
<table border=0 cellpadding=0 cellspacing=0 width="45%" align="center">
	<tr>
		<td height="100" valign="bottom"><b>注：“局长信箱”、“网上咨询”、“网上投诉”模块更新了“垃圾信件”功能，可将收到的垃圾信件做此处理！</b></td>
	</tr>
</table>
<TABLE border=0 cellPadding=0 cellSpacing=0 width="50%" align="center">
  <TBODY>
  <TR bgColor=#ffffff>
    <TD bgColor=#fff3c8 vAlign=top>
      <TABLE border=0 cellPadding=0 cellSpacing=0 width="100%">
        <TBODY>
        <TR>
          <TD vAlign=top width=3><IMG height=16
            src="/system/images/bian.gif" width=3></TD>
          <TD background=/system/images/bian2.gif><IMG height=16
            src="/system/images/bian2.gif" width=3></TD>
        </TR>
        </TBODY>
      </TABLE>
      <br>
      <table border=0 cellpadding=0 cellspacing=0 width=160 height="152" align="center">
<form name="formData" action="login.jsp" method="post">
        <tbody>
        <tr>
          <td background=/system/images/denglu.gif colspan=2 height=155
          valign=top width="157">
            <table border=0 cellpadding=0 cellspacing=2 width="50%">
              <tbody>
              <tr>
                <td colspan=2>&nbsp;</td>
              </tr>
              <tr>
                <td colspan=2 height=13>&nbsp;</td>
              </tr>
              <tr>
                <td height=20 width="40%">&nbsp; </td>
                <td height=20 width="60%">
                  <input name="UI_name" size=12 value="admin" onkeypress="check()">
                </td>
              </tr>
              <tr>
                <td height=33>&nbsp; </td>
                <td height=33>
                  <input name="UI_password" type="password"  size=12 value="......" onkeypress="check()">
               </td>
              </tr>
              <tr>
                <td colspan=2>
                  <div align=center><img height=21 align=ablmiddle
                  src="/system/images/dl.gif" width=37 style="cursor:hand" onclick="javascript:checklogin()">
                  &nbsp;<input type=checkbox name=applySkin2 id=applySkin2 value=true>
                  <label for=applySkin2 style=cursorL:hand>换肤1</label><br>
                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type=checkbox name=applySkin3 id=applySkin3 value=true>
                  <label for=applySkin3 style=cursorL:hand>换肤2</label>
 </div>
                </td>
              </tr>
              <tr>
                <td colspan=2><img height=2
                  src="/system/images/denglu_1.gif"
            width=156></td>
              </tr>
              </tbody>
			  </form>
            </table>
          </td>
        </tr>
        <tr>
          <td valign=top width=157 height="2">
            <p>&nbsp;</p>
          </td>
        </tr>
        </tbody>
      </table>
    </TD>
  </TR>
  </TBODY>
</TABLE>
<TABLE border=0 cellPadding=0 cellSpacing=0 width="50%" align="center">
  <TBODY>
  <TR>
    <TD background=/system/images/top_4.gif><IMG height=12
      src="/system/images/top_4.gif" width=5></TD></TR></TBODY></TABLE>
</BODY></HTML>
