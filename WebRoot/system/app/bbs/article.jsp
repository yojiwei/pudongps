<%@page contentType="text/html; charset=gb2312" language="java" import="java.sql.*" %>
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

function icon(theicon) {
document.input.message.value += " "+theicon;
document.input.message.focus();
}
</script>

<title>论坛</title>

</head>
<body text="#0000ff" >
<%@include file="inc/left.jsp"%>
<jsp:include page="inc/public.jsp" flush="true"/>

<table width="100%" cellspacing="0" cellpadding="0" align="center">

<tr>
    <td bgcolor="#ffffff" width="501"> <br>
      <a href="bbs">首页</a>&gt;&gt;<a href="index.jsp">论坛</a>&gt;&gt;搜索结果</td>
      </tr></table>

<table cellspacing="0" cellpadding="0" border="0" width="100%" align="center">
<tr><td bgcolor="#e9e9e9">

      <table border="0" cellspacing="1" cellpadding="6" width="100%" height="58" align="center">




    <tr bgcolor="#e9e9e9">
          <td width="4%" height="14">&nbsp;</td>
          <td width="30%" height="14">文章标题</td>
          <td width="8%" align="center" height="14">新窗</td>
          <td width="10%" align="center" height="14">作者</td>
          <td width="10%" align="center" height="14">回复数量</td>
          <td width="10%" align="center" height="14">浏览数量</td>
          <td width="25%" align="center" height="14">最后回复</td>
     </tr>
<%! String sql,Forum_Id,Note_Id,Note_Name,Replay_Name,Note_Author,Replay_Time,Time_Sql,User_Sql,Board_Sql;%>
 <%
  int PageSize=10;
  int RecordCount=0;
  int PageCount=0;
  int ShowPage=1;

  String S_Key     =request.getParameter("key");
         //S_Key=yy.ex_chinese(S_Key);
  String S_User    =request.getParameter("user");
         //S_User=yy.ex_chinese(S_User);
  String S_Board   =request.getParameter("board");
         //S_Board=yy.ex_chinese(S_Board);
  String S_Time    =request.getParameter("time");
  String S_Area    =request.getParameter("area");
         //S_Area=yy.ex_chinese(S_Area);
  String S_Member  =request.getParameter("member");
  //byte[] temp_t=S_Member.getBytes("ISO8859-1");
  //S_Member =new String(temp_t);
         //S_Member=yy.ex_chinese(S_Member);
  //out.println(S_Member);
  String baseSQL="Select forum_post.*,to_char(post_reply_date,'YYYY-MM-DD HH24:MI') replyDate,ua.ur_realname authorRealName,ur.ur_realname replierRealName from forum_post,userinfo ua,userinfo ur Where ua.ur_loginname=forum_post.post_author and ur.ur_loginname=forum_post.post_replier and ";
  if ((S_Member==null) || (S_Member.equals("null")))
  {
   //out.println("OK");
    if (S_Time.equals("0"))
           Time_Sql="";
    else
           Time_Sql=" datediff('d',[post_date],now()) < "+S_Time+" and ";
    if (S_User.equals(""))
      User_Sql="";
    else
      User_Sql=" post_author='"+S_User+"' And";
    if (S_Board.equals("all"))
      Board_Sql="";
    else
      Board_Sql=" post_board_id="+S_Board+" And";
    if (S_Area.equals("content"))
      sql=baseSQL+Time_Sql+User_Sql+Board_Sql+" post_content like '%"+S_Key+"%' order by post_id desc";
    else if (S_Area.equals("title"))
      sql=baseSQL+Time_Sql+User_Sql+Board_Sql+" post_title like '%"+S_Key+"%' order by post_id desc";
    else if (S_Area.equals("both"))
      sql=baseSQL+Time_Sql+User_Sql+Board_Sql+" (post_content like '%"+S_Key+"%' or "+Time_Sql+User_Sql+Board_Sql+" post_title like '%"+S_Key+"%') order by post_id desc";
  }else
  {
    sql=baseSQL+" post_author='"+S_Member+"'";
  }
 //out.println(sql);
 String fid=request.getParameter("fid");
 Connection con=yy.getConn();
 Statement  stmt=con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
 ResultSet rs=null;

  rs=stmt.executeQuery(sql);
  if(!rs.next()){
  rs.last();
  }
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
  Note_Id=rs.getString("post_reply_id");
  if (Note_Id.equals("0"))
  Note_Id=rs.getString("post_id");
  Note_Name=rs.getString("post_title");
  Note_Author=rs.getString("authorRealName");
  Replay_Name=rs.getString("replierRealName");
  Replay_Time=rs.getString("replyDate");
  Forum_Id   =rs.getString("post_board_id");
%>
         <tr bgcolor="#F7FBFF">
          <td align="center" height="16"><img src="IMAGES/<%=rs.getString("post_image")%>.GIF" ></td>
          <td height="16" bgcolor="#F7FBFF"><a href="shownote.jsp?fid=<%=Forum_Id%>&noteid=<%=Note_Id%>"><%=Note_Name%></a>
            &nbsp; </td>
          <td align="center" height="16"><a href="shownote.jsp?fid=<%=Forum_Id%>&noteid=<%=Note_Id%>" target="_blank"><img src="image/newwin.gif" border="0"></a></td>
          <td align="center" height="16"><!--Jony:屏蔽<a href="member.jsp?member=<%/*=Note_Author*/%>">--><%=Note_Author%><!--</a>--></td>
          <td align="center" height="16"><%=rs.getString("post_reply_count")%></td>
          <td align="center" height="16"><%=rs.getString("post_click_count")%></td>
          <td height="16">时间：<%=Replay_Time%><br />
            作者：<!--Jony:屏蔽<a href="member.jsp?member=<%/*=Replay_Name*/%>">--><%=Replay_Name%><!--</a>--></td>
</tr>
<%
if (!rs.next())
break;
}
}
else
{

%>
        <tr bgcolor="#F7FBFF">
          <td align="center"  height="16" colspan="7" width="633">没有你所需要的记录</td>
        </tr>
<%
}
%>


</table>
</td></tr></table>
<br>
<table width="100%" cellspacing="0" cellpadding="0" align="center" height="2" >
  <tr>
    <td width="524" height="2" valign="top">&nbsp; </td>
<td  align="right" width="205" height="2">
<form method="POST" action="article.jsp">

    <p>
     <input type="hidden" name="member" size="20" value='<%=S_Member%>'>
     <input type="hidden" name="Key" size="20" value='<%=S_Key%>'>
     <input type="hidden" name="user" size="20" value='<%=S_User%>'>
	 <input type="hidden" name="board" size="20" value='<%=S_Board%>'>
	 <input type="hidden" name="time" size="20" value='<%=S_Time%>'>
	 <input type="hidden" name="area" size="20" value='<%=S_Area%>'></p>

  <p>现在是第 <font color=black ><%=ShowPage%></font> 页 转到<select size="1" name="page">

<%
for (int i=1;i<=PageCount;i++)
{
    out.println(" <option value="+i+">"+i+"页</option>");
}
%>
</select>
<input type="submit" value="go" name="B1"></p>
</form>
</td></tr>
<%@include file="inc/bottom.jsp"%>
</body>
</html>
<html><script language="JavaScript"></script></html>
