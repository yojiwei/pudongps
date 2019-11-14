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
<link rel='stylesheet' type='text/css' href='inc/FORUM.CSS'>
<META NAME="keywords" CONTENT=" 论坛  java forum jsp forum">
<META NAME="description" CONTENT=" 论坛  java forum jsp forum">
<script language="JavaScript">
function Popup(url, window_name, window_width, window_height)
{ settings=
"toolbar=no,location=no,directories=no,"+
"status=no,menubar=no,scrollbars=yes,"+
"resizable=yes,width="+window_width+",height="+window_height;

NewWindow=window.open(url,window_name,settings); }
function CheckValue()
{
if (form1.title.value=="")
	{
       alert("公告标题不能为空!");
       form1.title.focus();
	   return false;


}


}





function icon(theicon) {
document.input.message.value += " "+theicon;
document.input.message.focus();
}
</script>

<title>论坛</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
</head>
<body>
<%@include file="inc/left.jsp"%>

      <jsp:include page="inc/public.jsp" flush="true"/></td></tr>
  <tr> 
    <td class="tablerow" colspan="7" bgcolor="#FFFFFF" height="16"> 
      <table border="0" align="center" cellspacing="0" width="100%" cellpadding="0">
     	<tr> 
          <td width="50%" align="center"><font color="#333399"><b><a href='manager.jsp'><font color="red">公告管理</font></a></b></font></td>
          <td width="50%" align="center"><font color="#333399"><b><a href='board_manager.jsp'>论坛管理</a></b></font></td>
          <!--Jony:屏蔽<td width="40%" align="left"><font color="#333399"><b><a href='user_manager.jsp'>用户管理</a></b></font></td>-->
        </tr>
      </table>
    </td>
  </tr>
  <tr bgcolor="#e9e9e9"> 
    <td width="17" height="14">&nbsp;</td>
    <td width="302" height="14">公告标题</td>
    <td width="172" align="center" height="14">发布时间</td>
    <td width="116" align="center" height="14">修改</td>
    <td width="91" align="center" height="14">删除 </td>

  </tr>
  
<%! String Notice_Id,sql,Not_Title,Not_Content,Submit_Button;%>
 <%
  int PageSize=10;
  int RecordCount=0;
  int PageCount=0;
  int ShowPage=1;
  
   Connection con=yy.getConn();
   Statement  stmt=con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
   ResultSet rs=null;

  sql="Select forum_notice.*,to_char(pn_date,'YYYY-MM-DD HH24:MI') pdFormated from  forum_notice order by pn_id desc";
  // Statement  stmt=con.createStatement();
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
Notice_Id=rs.getString("pn_id");
%>
  <tr bgcolor="#F7FBFF"> 
    <td align="center"  height="26" width="17"><img src="image/folder.gif" width="13" height="16"></td>
    <td height="26" width="302"><a href="manager.jsp?modifyid=<%=Notice_Id%>"> 
      <%=rs.getString("pn_title")%> </a> <br />
    </td>
    <td align="center" height="26" width="172"><%=rs.getString("pdFormated")%></td>
    <td align="center" height="26" width="116"><a href='manager.jsp?modifyid=<%=Notice_Id%>'>修改</a></td>
    <td align="center" height="26" width="91"><a href='querymanager.jsp?deleteid=<%=Notice_Id%>' onclick="{if(confirm('确定删除选定的纪录吗?')){return true;}return false;}">删除</a></td>

  </tr>
<%
if (!rs.next())
break;
}
}


%>
  <tr bgcolor="#F7FBFF"> 
    <form method="POST" action="manager.jsp">
	  <td align="center" height="21" width="17">&nbsp;</td>
      <td colspan="6" height="21" align="right"> 现在是第 <font color=black ><%=ShowPage%></font> 
        页 转到&nbsp; 
        <select size="1" name="page">
<%
for (int i=1;i<=PageCount;i++)
{
    out.println(" <option value="+i+">"+i+"页</option>");
}
%>
</select>
<input type="submit" value="转到" name="B1">
    </td>
 

<%
String Modify_Id=request.getParameter("modifyid");
if (Modify_Id!=null)
{
sql="select * from  forum_notice where pn_id="+Modify_Id;
rs=stmt.executeQuery(sql);
while(rs.next())
	{
     Not_Title=rs.getString("pn_title");
	 Not_Content=rs.getString("pn_content");
    Submit_Button="修改";
}

}else
{
Modify_Id="0";
Not_Title="";
Not_Content="";
Submit_Button="新增";
}
%>
</form>

</tr>
  <tr bgcolor="#F7FBFF"> 
   <form method="POST" name="form1" action="querymanager.jsp">
	<td align="center" height="10" width="17">&nbsp;</td>
    <td colspan="6" height="10" align="right" valign="middle"> 
      <div align="left"></div>
        <div align="center">公告标题：
          <input type="text" name="title" value="<%=Not_Title%>">
          <input type="hidden" name="noticeid" value="<%=Modify_Id%>">内容：
          <textarea name="content" cols="50" rows="3"><%=Not_Content%></textarea>
          <input type="submit" name="Submit" onclick='return CheckValue()';  value="<%=Submit_Button%>">
          <input type="reset" name="Submit2" value="重置">
        </div>
      
      </td></form>
  </tr>

</table>

<%@include file="inc/bottom.jsp"%>
<jsp:include page="inc/online.jsp" flush="true"/>