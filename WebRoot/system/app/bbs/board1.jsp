<%@page contentType="text/html; charset=gb2312" language="java" import="java.sql.*"  %>




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
<body text="#0000ff" >
<%@include file="inc/left.jsp"%>
<jsp:include page="inc/public.jsp" flush="true"/>

<table width="100%" align="center" cellspacing="0" cellpadding="0" align="center">

<%! String Forum_Name,Forum_Mastor,Forum_Id;%>
<%
 String fid=request.getParameter("fid");
 Connection con=yy.getConn();
 Statement  stmt=con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
 Statement  stmt1=con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
 ResultSet rs=null;
 String sql="Select fm_id,fm_name,fm_master_name,userinfo.ur_realname from forum_board,userinfo Where fm_id="+fid+" and userinfo.ur_loginname=forum_board.fm_master_name";
 rs=stmt.executeQuery(sql);
 //out.println(sql);
 while (rs.next())
 {
   Forum_Name=rs.getString("fm_name");
   Forum_Id=rs.getString("fm_id");
   Forum_Mastor=rs.getString("ur_realname");
 }
 //  stmt.close();
%>

<tr>
    <td bgcolor="#ffffff" width="501"> <br>
      <b>&nbsp;&nbsp;<%=Forum_Name%></b></td>
    <td bgcolor="#ffffff" class="post" align="right" width="230" nowrap>论坛版主：<%=Forum_Mastor%>&nbsp;<a href="post.jsp?fid=<%=Forum_Id%>"><img src="IMAGES/TOPIC.GIF" border="0" ></a></td>
  </tr></table>

<table cellspacing="0" cellpadding="0" border="0" width="100%" align="center">
<tr><td bgcolor="#e9e9e9">

      <table border="0" cellspacing="1" cellpadding="6" width="100%" height="58">




    <tr bgcolor="#e9e9e9">
          <td width="4%" height="14">&nbsp;</td>
          <td width="30%" height="14">文章标题</td>
          <td width="8%" align="center" height="14">新窗</td>
          <td width="10%" align="center" height="14">作者</td>
          <td width="10%" align="center" height="14">回复数量</td>
          <td width="10%" align="center" height="14">浏览数量</td>
          <td width="25%" align="center" height="14">最后回复</td>
     </tr>
<%! String Note_Id,Note_Name,Replay_Name,Note_Author,Replay_Time;%>
 <%
  int PageSize=10;
  int RecordCount=0;
  int PageCount=0;
  int ShowPage=1;


  sql="Select forum_post.*,to_char(forum_post.post_reply_date,'YYYY-MM-DD HH24:MI') replyDateFormated,ua.ur_realname,ur.ur_realname replier from forum_post,userinfo ua,userinfo ur Where post_board_id="+fid+" And post_reply_id=0 and ua.ur_loginname=post_author and ur.ur_loginname=post_replier order by post_id desc";
  //Statement stmt=con.createStatement();
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
  Note_Id=rs.getString("post_id");
  Note_Name=rs.getString("post_title");
  Note_Author=rs.getString("ur_realname");
  Replay_Name=rs.getString("replier");
  Replay_Time=rs.getString("replyDateFormated");
  sql = "select count(*) as post_reply_count from forum_post where post_reply_id = "+Note_Id;  
  ResultSet rs2 = stmt1.executeQuery(sql);
  String post_reply_count = "";
  if(rs2.next()){
	  
	  post_reply_count = rs2.getString("post_reply_count");
  }
%>
         <tr bgcolor="#F7FBFF">
          <td align="center" height="16"><img src="IMAGES/<%=rs.getString("post_image")%>.GIF" ></td>
          <td height="16" bgcolor="#F7FBFF"><a href="shownote.jsp?fid=<%=Forum_Id%>&noteid=<%=Note_Id%>"><%=Note_Name%></a>
            &nbsp; </td>
          <td align="center" height="16"><a href="shownote.jsp?fid=<%=Forum_Id%>&noteid=<%=Note_Id%>" target="_blank"><img src="image/newwin.gif" border="0"></a></td>
          <td align="center" height="16"><!--Jony: 屏蔽无关信息<a href="member.jsp?member=<%/*=Note_Author*/%>">--><%=Note_Author%><!--</a>--></td>
          <td align="center" height="16"><%=post_reply_count%></td>
          <td align="center" height="16"><%=rs.getString("post_click_count")%></td>
          <td height="16">时间：<%=Replay_Time%><br />
            作者： <!--Jony: 屏蔽无关信息<a href="member.jsp?member=<%/*=Replay_Name*/%>">--><%=Replay_Name%><!--</a>--></td>
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
          <td align="center"  height="16" colspan="7" width="633">对不起，该论坛暂时没有贴子　</td>
        </tr>
<%
}
%>


</table>
</td></tr></table>
<br>
<table width="100%" cellspacing="0" cellpadding="0" align="center" height="2">
  <tr>
    <td width="10%" height="2" valign="top">&nbsp; </td>
<td  align="right" width="90%" height="2" nowrap>
<form method="post" action="board.jsp">
<input type="hidden" name="fid" size="20" value='<%=Forum_Id%>'>
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
		out.print("<a href='board.jsp?fid="+Forum_Id+"&page="+(ShowPage+1)+"'>下一页</a>&nbsp;");
		out.print("<a href='board.jsp?fid="+Forum_Id+"&page="+PageCount+"'>最后页</a>&nbsp;");
	}
	else if((ShowPage>1)&&(ShowPage<PageCount))
	{
		out.print("<a href='board.jsp?fid="+Forum_Id+"&page=1'>第一页</a>&nbsp;");
		out.print("<a href='board.jsp?fid="+Forum_Id+"&page="+(ShowPage-1)+"'>上一页</a>&nbsp;");
		out.print("<a href='board.jsp?fid="+Forum_Id+"&page="+(ShowPage+1)+"'>下一页</a>&nbsp;");
		out.print("<a href='board.jsp?fid="+Forum_Id+"&page="+PageCount+"'>最后页</a>&nbsp;");
	}
	else if((ShowPage>1)&&(ShowPage==PageCount))
	{
		out.print("<a href='board.jsp?fid="+Forum_Id+"&page=1'>第一页</a>&nbsp;");
		out.print("<a href='board.jsp?fid="+Forum_Id+"&page="+(ShowPage-1)+"'>上一页</a>&nbsp;");
		out.print("<font style='color:silver'>下一页</font>&nbsp;");
		out.print("<font style='color:silver'>最后页</font>");
	}
	 %>
	
</form>
</td></tr>
<%@include file="inc/bottom.jsp"%>
</body></html>

<html><script language="JavaScript"></script></html>
<jsp:include page="inc/online.jsp" flush="true"/>