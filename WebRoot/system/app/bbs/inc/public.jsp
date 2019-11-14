<%@page contentType="text/html; charset=gb2312" language="java" import="java.sql.*"  %>
<%
response.setHeader("Cache-Control","no-store");
response.setHeader("Pragrma","no-cache");
response.setDateHeader("Expires",0);
%>
<script language=JavaScript>
function check(val)
{
	var form = document.form9;
	if(val == 1)
	{
		if(form.username.value == "")
		{
			alert("请输入用户名！");
			form.username.focus();
			return false;
		}
		form.action = "pass.jsp";
	}
	else
	{
		form.action = "logout.jsp";
	}
	var input = document.createElement("input");
	input.name = "_forPage";
	input.type = "hidden";
	input.value = window.location.href;
	form.appendChild(input);	
	form.submit();	
}
</script>
      <table border="0" cellspacing="1" bgcolor="#e9e9e9" cellpadding="6"  width="100%" height="30" align="center">
        <tr>
	<form method="POST" name="form9"  onSubmit="return check(1);">  
          	<td  width="100%" bgcolor="#ffffff"  colspan="7" height="1">


	<table border="0" width="100%" align="center" cellpadding="0"  cellspacing="0" >
  <tr>
   
<%
	String w = "";
	if ((session.getValue("UserClass")!=null) && session.getValue("UserClass").equals("系统管理员"))
		w = "30%";
	else
		w = "40%";
  %>
	<td width="<%=w%>">
       
		<%
		if (session.getValue("UserName")==null)
		{
		%>
		用户名:<input type="text" name="username" size="7" value=""> 密码:<input type="password" name="password" size="7"> <input type="submit" value="登录">
         <%
		}	
		else
		  out.println(session.getValue("UserName")+" 欢迎您！");
		%>

            	<%
		String datestr;
		java.text.DateFormat df = new java.text.SimpleDateFormat("HH:mm MM月dd日 E");
		datestr = df.format(new java.util.Date()) ;
		//out.println(datestr);
		String manageStr="";
		if ((session.getValue("UserClass")!=null)&&session.getValue("UserClass").equals("系统管理员"))
		   manageStr = "<a href='board_manager_note.jsp'>帖子管理</a> | <a href='board_manager.jsp'>栏目管理</a> | ";
		
		%></font>
	
		</td>		 
    <td align="right">
	<%=manageStr%><a href='reg.jsp'>用户注册</a> | 
<% if (session.getValue("UserName")!=null){ %>
<!--a href='/website/bbs/inc/passUpdate.jsp'>修改密码</a-->
<a href='#' onclick="javascript:window.open('/oa30/bbs/inc/passUpdate.jsp', 'placard', 'Top=250px,Left=400px,Width=360,Height=200,toolbar=no,location=no,status=no,menubar=no')">修改密码</a> | 
<%}%>
	<a href="search.jsp">搜索</a>

<%
/*
if (session.getValue("UserName")!=null)
out.println(" | <a href='modifyinfo.jsp'><font color='#B6F1FD'>修改资料</font></a>");
*/
%>


| <!--<a href="chatroom.jsp"><font color="#B6F1FD">聊天室</font></a> | --><a href="/oa30/bbs/index.jsp">论坛首页</font></a>
<%
if (session.getValue("UserName")!=null)
out.println("| <a href='#' onClick=\"check(2);\">退出</a>");
%>




</font></td>
  </tr>
</table>
</td> 
 </form>
 </tr>

<html><script language="JavaScript"></script></html>