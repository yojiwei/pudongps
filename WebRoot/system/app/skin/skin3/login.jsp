<%@ page contentType="text/html; charset=GBK" %>
<%@include file="../../../../system/manage/head.jsp"%>
<html>
<head>
<title>上海浦东门户网站后台管理系统</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache"> 
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache"> 
<META HTTP-EQUIV="Expires" CONTENT="0"> 
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
                alert("请填写登录用户！");
                form.UI_name.focus();
                return false;
        }
        else {
        	if (form.UI_name.value.indexOf("'")>=0||form.UI_name.value.indexOf("=")>=0) 
        	{
        		alert ("您的输入包含空格等非法字符！");
            return false;
        	}
        }
        if	 (form.UI_password.value =="")
        {
                alert("请填写登录密码！");
                form.UI_password.focus();
                return false;
        }
        else {
        	if (form.UI_password.value.indexOf("'")>=0||form.UI_password.value.indexOf("=")>=0) 
        	{
        		alert ("您的输入包含空格等非法字符！");
            return false;
        	}
        }
        if	 (form.rand.value =="")
        {
                alert("请填写4位图片验证码！");
                form.rand.focus();
                return false;
        }
        form.submit() ;
}
</script>
<link href="images/main.css" rel="stylesheet" type="text/css">
</head>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="40" marginwidth="0" marginheight="0">
<!-- ImageReady Slices (未标题-1) -->
<table width="780" height="329" border="0" align="center" cellpadding="0" cellspacing="0">
	<tr>
		<td>
			<img src="images/login_01.jpg" width="152" height="329" alt=""></td>
		<td>
			<img src="images/login_02.jpg" width="148" height="329" alt=""></td>
		<td>
			<img src="images/login_03.jpg" width="167" height="329" alt=""></td>
		<td>
			<img src="images/login_04.jpg" width="162" height="329" alt=""></td>
		<td><img src="images/login_05.jpg" width="151" height="329" alt=""></td>
	</tr>
</table>
<table width="780" border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="#F0F0F0">
  <tr>
    <td height="162" valign="top"><table width="776" height="100%" border="0" align="center" cellpadding="0" cellspacing="0">
      <tr>
        <td bgcolor="#FFFFFF">&nbsp;</td>
      </tr>
      <tr>
<form name="formData" action="../../login.jsp" method="post">
        <td height="100" align="center" valign="middle" bgcolor="#FFFFFF"><table border="0" cellpadding="0" cellspacing="0">
          <tr>
            <td width="59" height="25" valign="middle">用户名：</td>
            <td valign="middle" colspan="2"><input  name="UI_name" size=12 value="" onKeyPress="check()" type="text" class="input-text01" style="width:130"/></td>
            <td></td>
            <td width="80"></td>
            </tr>
          <tr>
          <tr>
            <td height="11" colspan="5"></td>
          </tr>
          </tr>
          <tr>
            <td height="25" valign="middle">密&nbsp; 码：</td>
            <td valign="middle" colspan="2"><input name="UI_password" type="password"  size=12 value="" onKeyPress="check()" class="input-text01" style="width:130"></td>
            <td></td><input type=hidden name=applySkin3 id=applySkin3 value=true>
            <td valign="top"></td>
          </tr>
          <tr>
            <td height="11" colspan="5"></td>
          </tr>
          <tr>
            <td height="25" valign="middle">验证码：</td>
            <td valign="middle" width="70"><img border=0 src="/system/manage/imgcheck/image.jsp"></td>
            <td valign="middle" width="60"><input type=text name=rand size=4 maxlength=4 value="" class="input-text01" style="width:60" onKeyPress="check()"></td>
            <td></td>
            <td align="right"><img src="images/login_06.gif" style="cursor:hand" onClick="javascript:checklogin()" width="74" height="25" border="0"></td>
          </tr>
        </table>
        <table width="84%" border="0" cellpadding="0" cellspacing="0">
        	<tr>
        		<td height="39">* 为了做好门户网站专项安全整改工作，<font color="#FF0000">请各单位网管于7月10日前完成用户密码修改工作，所有密码修改成数字与字母混合或者更高级模式。</font>若在规定时间内未修改的单位，电子政务管理中心将强行处理。
				<!--font color="#FF0000">* 门户网站短信服务即日起正式运行，使用前请务必阅读<a href="/doc/dx.doc"><strong><font color="#FF0000">《用户须知及操作手册》</font></strong></a>。希望各位同仁积极报送短信信息。</font--></td>
        	</tr>
        </table>
        </td>
      </tr>
      <tr>
        <td height="62" bgcolor="#FFFFFF"></td>
      </tr>
    </table></td></form>
  </tr>
</table><table width="780" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td height="38" align="center" valign="middle" bgcolor="#F0F0F0">上海互联网软件有限公司开发与维护</td>
  </tr>
</table>

<!-- End ImageReady Slices -->
</body>
</html>