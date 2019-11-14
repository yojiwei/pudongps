<%@page contentType="text/html; charset=gb2312" language="java" import="java.sql.*"  %>

<%
if ((session.getValue("UserName")==null)||(session.getValue("UserClass")==null)||(!session.getValue("UserClass").equals("系统管理员")))
{
 response.sendRedirect("err.jsp?id=14");
 return;
}

%>

<html><script language="JavaScript"></script></html>

<html>
<head>
<META NAME="keywords" CONTENT=" 论坛  java forum jsp forum">
<META NAME="description" CONTENT=" 论坛  java forum jsp forum">
<link rel='stylesheet' type='text/css' href='inc/FORUM.CSS'>

<script language="JavaScript">
function Popup(url, window_name, window_width, window_height)
{ settings=
"toolbar=no,location=no,directories=no,"+
"status=no,menubar=no,scrollbars=yes,"+
"resizable=yes,width="+window_width+",height="+window_height;

NewWindow=window.open(url,window_name,settings); }

function icon(theicon) {
document.input.message.value += " "+theicon;
document.input.message.focus();
}
</script>

<title>论坛</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
</head>
<body>
<table cellspacing="0" cellpadding="0" border="0" width="99%" align="center">
  <tr> 
    <td bgcolor="#009ACE" width="17"> 
      <jsp:include page="inc/public.jsp" flush="true"/>
  <tr> 
    <td class="tablerow" colspan="7" bgcolor="#FFFFFF" height="16"> 
      <table border="0" cellspacing="0" width="100%" cellpadding="0">
        <tr> 
          <td width="40%" align="right"><font color="#333399"><b><a href='manager.jsp'>公告管理</a></b></font></td>
          <td width="20%" align="center"><font color="#333399"><b><a href='board_manager.jsp'>论坛管理</a></b></font></td>
          <td width="40%" align="left"><font color="#333399"><b><a href='user_manager.jsp'><font color="red">用户管理</font></a></b></font></td>
        </tr>
      </table>
    </td>
  </tr>
  <tr bgcolor="#9CCFFF"> 
    <td width="80" align="center" height="14">用户名</td>
    <td width="80" align="center" height="14" >用户性别</td>
	<td width="100" align="center" height="14">用户等级</td>
    <td width="100" align="center" height="14">发帖/访问次数</td>
	<td width="80" align="center" height="14">禁启状态</td>
	<td width="86" align="center" height="14">修改</td>
    <td width="80" align="center" height="14">删除 </td>

  </tr>
  <jsp:useBean id="yy" scope="page" class="yy.jdbc"/>
<%! String User_Name,User_Id,sql,Not_Title,Not_Content,Submit_Button;%>
 <%
  Submit_Button=request.getParameter("Submit");
  User_Name=request.getParameter("username");
  int PageSize=10;
  int RecordCount=0;
  int PageCount=0;
  int ShowPage=1;
  
   Connection con=yy.getConn();
   Statement  stmt=con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
   ResultSet rs=null;
  sql="Select * from USERINFO order by ur_id desc";
  
  if (Submit_Button!=null)
  {
	  if (Submit_Button.equals("删除该用户的所有贴子"))
	  {
		sql="delete from forum_post where post_author='"+User_Name+"'";
		stmt.executeUpdate(sql);
		sql="Select * from USERINFO order by ur_id desc";
	  }
	  else if (Submit_Button.equals("搜索"))
	  {
	  	sql="Select * from USERINFO where ur_loginname like '%"+User_Name+"%'";
	  }
  }
  rs=stmt.executeQuery(sql);
  rs.last();
  RecordCount=rs.getRow();
  PageCount=(RecordCount % PageSize==0)?(RecordCount/PageSize):(RecordCount/PageSize+1);
  String Page=request.getParameter("page");
  if (Page!=null)
  {
     ShowPage=Integer.parseInt(Page);
     if (ShowPage>PageCount)
        ShowPage=PageCount;
     else if(ShowPage<0)
        ShowPage=1;
  }else
        ShowPage=1;

if (RecordCount>0)
{
rs.absolute((ShowPage-1)*PageSize+1);
for (int i=1;i<PageSize;i++)
{
User_Id=rs.getString("ur_id");
User_Name=rs.getString("ur_loginname");
%>
  <tr bgcolor="#F7FBFF"> 
    <td width="80" align="center" height="14"><a href='modifyuser_manager.jsp?modifyid=<%=User_Id%>'><%=User_Name%></a></td>
    <td width="80" align="center" height="14" ><%=rs.getString("ur_sex")%></td>
	<td width="100" align="center" height="14"><%=rs.getString("ur_grade")%></td>
    <td width="100" align="center" height="14"><%=rs.getString("ur_post_count")%>/<%=rs.getString("ur_visit_count")%></td>
	<td width="80" align="center" height="14">
	<%
	if (rs.getString("ur_isactive").equals("1"))
	   out.println("<a href='queryuser_manager.jsp?stopid="+User_Id+"&isuser=0'>启用</a></td>");
	   else
	   	   out.println("<a href='queryuser_manager.jsp?stopid="+User_Id+"&isuser=1'>禁用</a></td>");
	%>
	
	
	<td width="86" align="center" height="14"><a href='modifyuser_manager.jsp?modifyid=<%=User_Id%>'>修改</a></td>
    <td width="80" align="center" height="14"><a href='queryuser_manager.jsp?deleteid=<%=User_Id%>&username=<%=User_Name%>' onclick="{if(confirm('确定删除该用户，该用户所发表的所有贴子也同时被删除?')){return true;}return false;}">删除</a></td>

  </tr>
<%
if (!rs.next())
break;
}
}


%>
  <tr bgcolor="#F7FBFF"> 
    <form method="POST" action="user_manager.jsp">
	<td align="center" height="10" width="17">&nbsp;</td>
    <td colspan="6" height="10" align="right"> 
      
        现在是第 <font color=black ><%=ShowPage%></font> 页 转到 
        <select size="1" name="page">
<%
for (int i=1;i<=PageCount;i++)
{
    out.println(" <option value="+i+">"+i+"页</option>");
}
%>
</select>
<input type="submit" value="go" name="B1">

    </td>
  </tr>



</form>
  <tr bgcolor="#F7FBFF"> 
	<td align="center" height="10" width="17">&nbsp;</td>
    <td colspan="6" height="10" align="right" valign="middle"> 
      <div align="left"></div>
      <form name="form1" method="post" action="user_manager.jsp" >
        <div align="center">用户名：
          <input type="text" name="username" >

          <input type="submit" name="Submit" value="搜索">
          <input type="submit" name="Submit" onclick="{if(confirm('确定删除该用户所发表的所有贴子?')){return true;}return false;}" value="删除该用户的所有贴子">
        </div>
      </form>
      </td>
  </tr>

</table>
</td></tr></table>
<jsp:include page="inc/jumpboard.jsp" flush="true"/>



<html><script language="JavaScript"></script></html>
<jsp:include page="inc/online.jsp" flush="true"/>
