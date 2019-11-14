<%@page contentType="text/html; charset=gb2312" language="java" import="java.sql.*"  %>
<%@include file="/website/include/import.jsp"%>
<%
String pwd1 = CTools.dealString(request.getParameter("pwd1"));
String pwd2 = CTools.dealString(request.getParameter("pwd2"));
if(pwd1!=null && pwd2!=null && !pwd1.equals("") && pwd1.equals(pwd2) && session.getValue("UserName")!=null)//更改密码
{
//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 
	long uid = 0;
	Hashtable ht = dImpl.getDataInfo("select ur_id from userinfo where ur_loginname='"+session.getValue("UserName")+"'");
	if(ht!=null) uid = Long.parseLong(ht.get("ur_id").toString());
	//密码更改
	dImpl.edit("userinfo","ur_id",uid);
	dImpl.setValue("ur_password",pwd1,dImpl.STRING);
	if(dImpl.update()) out.print("<script>alert('密码更改成功！');window.close();</script>");
	else out.print("<script>alert('密码更改失败，请重试！');</script>");




} catch (Exception ex) {
	System.out.println(new java.util.Date() + "--"
			+ request.getServletPath() + " : " + ex.getMessage());
} finally {
	if(dImpl != null)
	dImpl.closeStmt();
	if(dCn != null)
	dCn.closeCn();
}


}
%>
<html>
<head><title>用户信息－密码修改</title></head>
<body>
<link href="/oa30/website/images/main.css" rel="stylesheet" type="text/css" />
<table width="300"  border="0" align="center" cellpadding="1" cellspacing="1" bgcolor="#CCCCCC">
<form name="form1" method="post">
  <tr bgcolor="#FFFFFF">
    <td height="40" colspan="2"><div align="center">用户信息－密码修改（当前用户：<% if (session.getValue("UserName")!=null) out.print(session.getValue("UserName"));%>）</div></td>
  </tr> 
  <tr bgcolor="#FFFFFF">
    <td width="150" height="40"><div align="right">新密码：</div></td>
    <td width="150"><input type="password" name="pwd1" mes="新密码" compareto="" field="text"></td>
  </tr>
  <tr bgcolor="#FFFFFF">
    <td height="40"><div align="right">新密码确认：</div></td>
    <td><input type="password" name="pwd2" mes="新密码确认" compareto="" field="text"></td>
  </tr>
  <tr bgcolor="#FFFFFF">
    <td height="40"><div align="right">
      <input type="button" name="sub" value="更　改" onclick="return check();">
    </div></td>
    <td><input type="reset" name="reset" value="重　填"></td>
  </tr>
  </form>
</table>
</body>
</html>
<script language="JavaScript">
function check()
{
	var sform = document.form1;
	for(i=0;i<sform.length;i++)
	{
		if(sform[i].mes!="undefined" && sform[i].field=="text" && sform[i].value==sform[i].compareto)
		{
			alert(sform[i].mes+"不能为空！");
			sform[i].focus();
			return false;
		}		
	}
	if(sform.pwd1.value != sform.pwd2.value )
	{
		alert("新密码与确认密码不一致！");
		sform.pwd2.value = "";
		sform.pwd2.focus();
		return false;
	}
	sform.action="passUpdate.jsp";
	sform.submit();

}
</script>