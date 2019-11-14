<%@page contentType="text/html; charset=gb2312" language="java" %>
<html>
<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link rel='stylesheet' type='text/css' href='inc/TURBOCRM.CSS'>
</head>
<BODY oncontextmenu=self.event.returnValue=false>
<table width="100%" border="0" height="100%">
<tr align="center"> 
<td>
<form method="post" action="" name="forms[0]">
        <table border="1" bordercolorlight="000000" bordercolordark="FFFFFF" cellspacing="0" bgcolor="#C0EFFE">
          <tr>
<td>
              <table border="0" bgcolor="#00CCFF" cellspacing="0" cellpadding="2" width="350">
                <tr>
                  <td width="342"></td>
<td width="18">
<table border="1" bordercolorlight="666666" bordercolordark="FFFFFF" cellpadding="0" bgcolor="E0E0E0" cellspacing="0" width="18">
<tr>
<td width="16"><b><a href="javascript:history.go(-1)" onMouseOver="window.status='';return true" onMouseOut="window.status='';return true" title="关闭"><font color="000000">×</font></a></b></td>
</tr>
</table>
</td>
</tr>
</table>
<table border="0" width="350" cellpadding="4">
<tr> 
                  <td width="59" align="center" valign="top">&nbsp;</td>
<td width="269">

<%
  String Id=request.getParameter("id");
  if (Id==null)
     out.println("<P>非法操作!请稍后再试试!</P>");
  else
  {
  int Err_id=0;
	Err_id=Integer.parseInt(Id);
  if (Err_id==1)
     out.println("<P>贴子的标题和内容不能为空!</P>");
  else if(Err_id==2)
	  out.println("<P>用户名和密码不能为空,请重输!</P>");
  else if(Err_id==3)
	  out.println("<p>此用户名已存在,请选择其他的用户名!</p>");
    else if(Err_id==4)
	  out.println("<p>你输入的用户名和密码不正确,请重输!</p>");
    else if(Err_id==5)
	  out.println("<p>你还没有登陆，如果你还没有注册，请注册用户!</p>");
	else if(Err_id==6)
	  out.println("<p>你的权限不够，只有系统管理员和本板斑竹才能修改别人的贴子!</p>"); 
	else if(Err_id==7)
	  out.println("<p>你的权限不够，只有系统管理员和本板斑竹才能删除别人的贴子!</p>");
	else if(Err_id==8)
	  out.println("<p>你的用户名已被禁用，请速与管理员联系!</p>");
	else if(Err_id==9)
	  out.println("<p>两次密码输入不同，请重新输入人的密码!</p>");
		else if(Err_id==10)
	  out.println("<p>密码的长度不能大于12个字符,小于6个字符!</p>"); 
	else if(Err_id==11)
	  out.println("<p>E-Mail不能为空，主输入你的E_MAIL地址!</p>");
	else if(Err_id==12)
	  out.println("<p>用户名中含有非法字符!</p>");
	else if(Err_id==13)
	  out.println("<p>E_Mail地址输入不合法，请重输!</p>");
		else if(Err_id==14)
	  out.println("<p>你的权限不够，请与系统管员联系统!</p>");
	else if(Err_id==15)
	  out.println("<p>论坛名称不能为空!</p>");
		else if(Err_id==16)
	  out.println("<p>此用户不存在，不能成为斑竹，请注册该用户!</p>");
		else if(Err_id==17)
	  out.println("<p>正在制做之中，请大家试目以待!</p>");
	  	else if(Err_id==91)
	  out.println("<p>只有版主（斑竹）和管理员可以发新贴！但您可以在相关论题下跟贴，若您想发新贴，可发布在“金点子”栏目中的置顶贴中！</p>");
	  	else if(Err_id==92)
	  out.println("<p>请登录后再发新贴！</p>");
  }
%>

</td>
</tr>
<tr>
<td colspan="2" align="center" valign="top">
<input type="button" name="ok" value="　确 定　" onclick=javascript:history.go(-1)>
</td>
</tr>
</table>
</td>
</tr>
</table>
</form>
</td>
</tr>
</table>

</body>
</html>

<html><script language="JavaScript"></script></html>

