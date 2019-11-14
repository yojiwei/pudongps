<%@page contentType="text/html; charset=gb2312" language="java" import="java.sql.*"  %>
<%@include file="/website/include/import.jsp"%>
<%
if ((session.getValue("UserClass")==null) || ((session.getValue("UserClass")!=null)&&!session.getValue("UserClass").equals("系统管理员")))
{	
	out.print("<script>alert('你不是系统管理员，无此权限！');window.close();</script>");
	return;
}
String loginName = CTools.dealString(request.getParameter("loginName"));
String ur_password = "";
if(!loginName.equals(""))
{
//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 
	Hashtable ht = dImpl.getDataInfo("select ur_password from userinfo where ur_loginname='"+loginName+"'");
	if(ht!=null) ur_password = ht.get("ur_password").toString();

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
<head><title>用户信息－密码查询</title></head>
<body leftmargin="0">
<link href="/oa30/website/images/main.css" rel="stylesheet" type="text/css" />
<table width="350"  border="0" align="center" cellpadding="1" cellspacing="1" bgcolor="#CCCCCC">
<form name="form1" method="post">
  <tr bgcolor="#FFFFFF">
    <td height="30" colspan="2"><div align="center">用户信息－密码查询</div></td>
  </tr>
  <tr bgcolor="#FFFFFF">
    <td width="50%" height="40"><div align="right">用户登录名&nbsp;&nbsp;&nbsp;<br>（如zhangsan）：</div></td>
    <td width="50%"><input type=text name=loginName></td>
  </tr>
   <tr bgcolor="#FFFFFF">
    <td height="30"><div align="right">
      <input type="button" name="sub" value="查　询" onclick="return check();">
    </div></td>
    <td><input type="reset" name="reset" value="重　填"></td>
  </tr>
  </form>
  </table>
<br><br>
<table width="350"  border="0" align="center" cellpadding="1" cellspacing="1">
	<tr bgcolor="#FFFFFF">
		<td>
			<fieldset>
			<legend>查询结果</legend>
			<table width="100%">		 
			  <tr bgcolor="#FFFFFF">
				<td width="50%" height="30"align="right">当前查询用户：
				</td>
				<td width="50%"><%=loginName%></td>
			  </tr>
			  <tr bgcolor="#FFFFFF">
				<td height="30"><div align="right">密码：</div></td>
				<td><%=ur_password%></td>
			  </tr>
			  </table> 	
			</fieldset>
		</td>
	 </tr>
   </table> 
</body>
</html>
<script language="JavaScript">
function check()
{
	var sform = document.form1;	
	sform.submit();

}
</script>