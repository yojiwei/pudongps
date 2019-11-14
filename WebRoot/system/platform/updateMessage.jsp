
<%@ page contentType="text/html; charset=GBK"%>
<%@ page import="com.util.CTools"%>
<%@ page import="java.util.Hashtable"%>
<%@ page import="java.util.Vector"%>
<%@ page import="com.component.database.*"%>
<%@ page import="com.platform.admin.*"%>
<%@ page import="com.platform.CManager"%>
<%@ page import="com.platform.UI.mainFrame"%>
<link href="style.css" rel="stylesheet" type="text/css">
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

	//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 
	CTools tools = new CTools();
	String at_loginname = ""; //注册名
	String at_password = ""; //密码
	String at_realname = ""; //姓名
	String at_nickname = ""; //昵称
	CManager manager = (CManager) session.getAttribute("manager");
	
	at_loginname = manager.getLoginName();
	at_password = manager.getPassword();
	String str_sql = " SELECT * FROM TB_ADMINISTRATOR WHERE AT_LOGINNAME = '"+ at_loginname +"' "
	 			   + " AND AT_PASSWORD = '"+ at_password  +"' ";
	Hashtable rs = dImpl.getDataInfo(str_sql);
	if(rs != null){
		if(rs.get("at_password") != null)
			at_password = String.valueOf(rs.get("at_password"));
		if(rs.get("at_realname") != null)
			at_realname = String.valueOf(rs.get("at_realname"));
		if(rs.get("at_nickname") != null)
			at_nickname = String.valueOf(rs.get("at_nickname"));
	}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>修改注册信息</title>
    
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
    <meta http-equiv="description" content="This is my page">
    
    <!--
    <link rel="stylesheet" type="text/css" href="styles.css">
    -->
    <script type="text/javascript">
	<!--
		function checkpassword(){
			var form = document.formData ;
			var password = form.AT_password.value;
			var confirmPass = form.confirmPassword.value;
			if(password == null || password == ""){
				alert("密码不可为空!");
				form.AT_password.select();
				return false;
			}
			if(password != confirmPass){
				alert("密码不一致!");
				form.confirmPassword.select();
				return false;
			}
			return true;
		}
		
		function updatePassword(){
			var form = document.formData ;
			if(checkpassword()){
				form.action="system/platform/admin/adminUpdInfo.jsp";
				form.submit();
			}
		}
	//-->
	</script>
  </head>
  <body bgColor=#FFFFFF leftMargin=0
text=#000000 topMargin=0 marginheight="0" marginwidth="0">

<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<TABLE border=0 cellPadding=0 cellSpacing=0 width="60%" align="center">
  <TBODY>
  <TR bgColor=#ffffff>
    <TD bgColor=#fff3c8 vAlign=top colspan="2">
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
    </TD>
  </TR>
  <tr>
  	<table border=0 cellpadding=0 cellspacing=0 width="60%" height="152" align="center">
	  <form name="formData" action="" method="post">	
	  	<TR>
	  		<TD bgcolor="#fff3c8" style="font-size:14px" colspan="2" align="center">
	  		修改注册信息
	  		</TD>
	  	</TR>
	  	<tr >
	    	<td width="15%" align="right" bgcolor="#fff3c8"><span style="color:red">*</span>注册名：</td>
			<td width="85%" bgcolor="#fff3c8"><input name="AT_loginname" size="20" class="text-line"
				value="<%= at_loginname%>" tabindex="1" maxlength="20" readonly="true">
			&nbsp;&nbsp;&nbsp;&nbsp;<span style="color:#606060">
			</span></td>
		</tr>
		<tr>
			<td width="15%" bgcolor="#fff3c8" align="right"><span style="color:red">*</span>原密码：</td>
			<td width="85%" bgcolor="#fff3c8"><input type="password" class="text-line"
				name="AT_passwordOld" size="21" tabindex="2" value=""
				maxlength="20"> &nbsp;&nbsp;&nbsp;&nbsp;<span style="color:#606060">
			</span></td>
		</tr>
		<tr>
			<td width="15%" bgcolor="#fff3c8" align="right"><span style="color:red">*</span>新密码：</td>
			<td width="85%" bgcolor="#fff3c8"><input type="password" class="text-line"
				name="AT_password" size="21" value="" tabindex="3" maxlength="20">
				 &nbsp;&nbsp;&nbsp;&nbsp;<span style="color:#606060">(字母和数字组合，长度8--20)
			</span></td>
		</tr>
		<tr>
			<td width="15%" bgcolor="#fff3c8" align="right"><span style="color:red">*</span>确认密码：</td>
			<td width="85%" bgcolor="#fff3c8"><input type="password" class="text-line"
				name="confirmPassword" size="21" value="" tabindex="4" maxlength="20">
				 &nbsp;&nbsp;&nbsp;&nbsp;<span style="color:#606060">(字母和数字组合，长度8--20)
			</span></td>
		</tr>
		<tr>
			<td width="15%" bgcolor="#fff3c8" align="right"><span style="color:red">*</span>姓名：</td>
			<td width="85%" bgcolor="#fff3c8"><input name="AT_realname" size="20" class="text-line"
				value="<%= at_realname%>"  maxlength="20" tabindex="5">
			&nbsp;&nbsp;&nbsp;&nbsp;<span style="color:#606060">(可以用字母和数字组合，长度不超过20个，汉字不超过10个)
			</span></td>
		</tr>
		<tr>
			<td width="15%" bgcolor="#fff3c8" align="right">昵称：</td>
			<td width="85%" bgcolor="#fff3c8"><input name="AT_nickname" size="20" class="text-line"
				value="<%= at_nickname%>" maxlength="20" tabindex="6"> &nbsp;&nbsp;&nbsp;&nbsp;<span
				style="color:#606060">(可以用字母和数字组合，长度不超过20个，汉字不超过10个) </span></td>
		</tr>
		<tr>
	 		
            <td align="center" bgcolor="#fff3c8" colspan="2">
              <img height=21
              src="/system/images/tijiao.gif" tabindex="7" width=37 style="cursor:hand" onclick="javascript:updatePassword()">
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              <img height=21
              src="/system/images/fanhui.gif" tabindex="8" style="cursor:hand" onclick="javascript:history.back()">
            </td>
	   </tr>
	  </form>
	</table>
  </tr>
  </TBODY>
</TABLE>
<TABLE border=0 cellPadding=0 cellSpacing=0 width="60%" align="center">
  <TBODY>
  <TR>
    <TD background=/system/images/top_4.gif><IMG height=12
      src="/system/images/top_4.gif" width=5></TD></TR></TBODY></TABLE>
</body>
</html>
<%


} catch (Exception ex) {
	System.out.println(new java.util.Date() + "--"
			+ request.getServletPath() + " : " + ex.getMessage());
} finally {
	if(dImpl != null)
	dImpl.closeStmt();
	if(dCn != null)
	dCn.closeCn();
}

%>