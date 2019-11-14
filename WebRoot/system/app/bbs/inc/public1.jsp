<%@page contentType="text/html; charset=gb2312" language="java" import="java.sql.*"  %>
      <table border="0" cellspacing="1" cellpadding="6"  width="100%" height="30" align="center">
        <tr>
	<form method="POST" name="form9" action="pass.jsp">  
          	<td  width="100%" bgcolor="#F7FBFF" colspan="7" height="1">


	<table border="0" width="100%" align="center" cellpadding="0"  cellspacing="0">
  <tr>
   

	<td>
        <p>
		
		<%
		if (session.getValue("UserName")==null)
		{
		%>
		用户名:<input type="text" name="username" size="7"> 密码:<input type="password" name="password" size="7"> <input type="submit" value="登录"> <!--【<a href="reg.jsp"><font color="yellow">注册</font></a>】-->
         <%
		}	
		else
		  out.println(session.getValue("UserRealName")+" 欢迎您！");
		%>

            	<%
		String datestr;
		java.text.DateFormat df = new java.text.SimpleDateFormat("HH:mm MM月dd日 E");
		datestr = df.format(new java.util.Date()) ;
		//out.println(datestr);
		String manageStr="";
		if ((session.getValue("UserClass")!=null)&&session.getValue("UserClass").equals("系统管理员"))
		   manageStr = "<a href='board_manager.jsp'>管理</a> | ";
		
		%></font>	
		</td>
    <td>
	  <p align="right"><%=manageStr%>
<a href="search.jsp">搜索</a>
| <a href="indexBoard.jsp">论坛列表</a> | <a href="/oa30/bbs/index.jsp">论坛首页</font></a>
<%
if (session.getValue("UserName")!=null)
out.println("| <a href='logout.jsp'>退出</a>");
%>
</font></td>
  </tr>
</table>




</td> 
 </form>
 </tr>

<html><script language="JavaScript"></script></html>