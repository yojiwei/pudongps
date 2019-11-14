<%@page contentType="text/html; charset=gb2312" language="java" import="java.sql.*"  %>
<%
if ((session.getValue("UserName")==null)||(session.getValue("UserClass")==null)||(!session.getValue("UserClass").equals("系统管理员")))
{
 response.sendRedirect("err.jsp?id=14");
 return;
}

%>
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
       alert("论坛名称不能为空!");
       form1.title.focus();
	   return false;
}
if (form1.user.value=="")
	{
       alert("斑竹不能为空!");
       form1.user.focus();
	   return false;
}
}

function icon(theicon) {
document.input.message.value += " "+theicon;
document.input.message.focus();
}
</script>
<script LANGUAGE="javascript" src="publish/chooseTreeJs.jsp"></script>

<script LANGUAGE="javascript">

function on_choose_user()
{
  if(chooseTree('user','form1'))
  {
  }
  //formData.submit();
}
</script>


<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
</head>
<body>
<%@include file="inc/left.jsp"%>

      <jsp:include page="inc/public.jsp" flush="true"/>
  <!--<tr> 
    <td class="tablerow" colspan="7" bgcolor="#FFFFFF" height="16"> 
      <table border="0" align="center" cellspacing="0" width="100%" cellpadding="0">
     	<tr> 
          <!--<td width="50%" align="center"><font color="#333399"><b><a href='manager.jsp'><font color="red">公告管理</font></a></b></font></td>-->
          <!--<td  align="center"><font color="#333399"><b><a href='board_manager.jsp'>论坛管理</a></b></font></td>
          <!--Jony:屏蔽<td width="40%" align="left"><font color="#333399"><b><a href='user_manager.jsp'>用户管理</a></b></font></td>-->
        <!--</tr>
      </table>
    </td>
  </tr>--> 
  <%
if ((session.getValue("UserClass")!=null)&&session.getValue("UserClass").equals("系统管理员"))
{
%>
<tr bgcolor="#ffffff"> 
    <td colspan="5" align="right"><a href="#" onClick="document.setNoteSequence.submit()">修改排序</a>&nbsp;&nbsp;&nbsp;<a href="Javascript:history.back();">返回</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
  </tr>
<%}%>
  <tr bgcolor="#e9e9e9"> 
    <td width="57%" height="14" align="center">文章名称</td>
    <td width="15%" height="14" align="center">论坛名称</td>
    <td width="10%" align="center" height="14" align="center">论坛斑竹</td>
    <td width="10%" align="center" height="14" align="center">排序</td>
    <td width="8%" align="center" height="14" align="center">删除 </td>
  </tr>
  <form name="setNoteSequence" action = "setNoteSequence.jsp" method="post">
<%! String Notice_Id,sql,Not_Title,Not_Content,Submit_Button;%>
 <%
  int PageSize=15;
  int RecordCount=0;
  int PageCount=0;
  int ShowPage=1;
  
   Connection con=yy.getConn();
   Statement  stmt=con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
   ResultSet rs=null;

  sql="Select p.post_id,p.post_title,p.post_sequence,f.*,u.ur_realname from forum_post p,forum_board f,userinfo u where p.post_board_id = f.fm_id and u.ur_loginname=f.fm_master_name and p.post_reply_id = 0 order by p.post_sequence ";
  //sql="Select f.* from forum_board f order by fm_id desc";	
  // Statement  stmt=con.createStatement();
  //select f.post_id,f.post_board_id,f.post_title,b.fm_name,b.fm_id from forum_post f,forum_board b where b.fm_id = f.post_board_id and f.post_reply_id = 0 order by f.post_date desc
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
for (int i=0;i<PageSize;i++)
{
Notice_Id=rs.getString("fm_id");
%>
  <tr bgcolor="#F7FBFF"> 
    <td height="26">&nbsp;<img src="image/folder.gif" width="13" height="16">&nbsp;<a href="shownote.jsp?fid=<%=Notice_Id%>&noteid=<%=rs.getString("post_id")%>" target="_blank"><font color=#000099><%=rs.getString("post_title")%></font></a></td>
    <td height="26"  bgcolor="#F7FBFF" align="center"><a href="board.jsp?fid=<%=Notice_Id%>"> 
      <%=rs.getString("fm_name")%></a>
    </td>
    <td align="center" height="26"><%=rs.getString("fm_master_name")%></td>
    <td align="center" height="26"><input type="text" name="noteid<%=rs.getString("post_id")%>" size="5" style="border:1px solid #000000;background-color:#F7FBFF" value="<%if(rs.getString("post_sequence")!=null) out.print(rs.getString("post_sequence"));%>"></td>
    <td align="center" height="26"><a href='delNote.jsp?deleteID=<%=rs.getString("post_id")%>&curPage=<%=ShowPage%>' onclick="{if(confirm('确定删除该主题及其下所有内容吗?')){return true;}return false;}">删除</a></td>

  </tr>
<%
if (!rs.next())
break;
}
}


%>
<input type="hidden" name="curPage" value="<%=ShowPage%>">
  </form>
  <tr bgcolor="#F7FBFF"> 
	<td colspan="7" height="10" align="right">  
       共 <B><%=RecordCount%></B> 条信息 共 <B><%=PageCount%></B> 页 现在是第 <B><font color=red ><%=ShowPage%></font></B> 页&nbsp;
  <%
	if((ShowPage==1)&&(PageCount==1)){
		out.print("<font style='color:silver'>第一页</font>&nbsp;");
		out.print("<font style='color:silver'>上一页</font>&nbsp;");
		out.print("<font style='color:silver'>下一页</font>&nbsp;");
		out.print("<font style='color:silver'>最后页</font>&nbsp;");
	}
	else if((ShowPage==1)&&(ShowPage<PageCount))
	{
		out.print("<font style='color:silver'>第一页</font>&nbsp;");
		out.print("<font style='color:silver'>上一页</font>&nbsp;");
		out.print("<a href='board_manager_note.jsp?page="+(ShowPage+1)+"'>下一页</a>&nbsp;");
		out.print("<a href='board_manager_note.jsp?page="+PageCount+"'>最后页</a>&nbsp;");
	}
	else if((ShowPage>1)&&(ShowPage<PageCount))
	{
		out.print("<a href='board_manager_note.jsp?page=1'>第一页</a>&nbsp;");
		out.print("<a href='board_manager_note.jsp?page="+(ShowPage-1)+"'>上一页</a>&nbsp;");
		out.print("<a href='board_manager_note.jsp?page="+(ShowPage+1)+"'>下一页</a>&nbsp;");
		out.print("<a href='board_manager_note.jsp?page="+PageCount+"'>最后页</a>&nbsp;");
	}
	else if((ShowPage>1)&&(ShowPage==PageCount))
	{
		out.print("<a href='board_manager_note.jsp?page=1'>第一页</a>&nbsp;");
		out.print("<a href='board_manager_note.jsp?page="+(ShowPage-1)+"'>上一页</a>&nbsp;");
		out.print("<font style='color:silver'>下一页</font>&nbsp;");
		out.print("<font style='color:silver'>最后页</font>");
	}
  %>
   </td>
  </tr>

<%
String Modify_Id=request.getParameter("modifyid");
String userId="";
if (Modify_Id!=null)
{
sql="select f.*,u.ur_realname,u.ur_id from forum_board f,userinfo u where fm_id="+Modify_Id+" and u.ur_loginname=f.fm_master_name";
rs=stmt.executeQuery(sql);
while(rs.next())
	{
     Not_Title=rs.getString("fm_name");
	 Not_Content=rs.getString("fm_master_name");
	 userId = rs.getString("ur_id");
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
</table>
</td></tr></table>
<%@include file="inc/bottom.jsp"%>