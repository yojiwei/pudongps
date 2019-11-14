<%@page contentType="text/html; charset=gb2312" language="java" import="java.sql.*"  %>
<jsp:useBean id="yy" scope="page" class="yy.jdbc"/>
<%!String sql,Note_Singid,Note_Title,Note_Content,Note_Icon,Note_Signid,Board_Id,Return_Id;%>
<%

  Note_Title=request.getParameter("title");
  //Note_Title=yy.ex_chinese(Note_Title);
  Note_Content=request.getParameter("content");
 //Note_Content=yy.ex_chinese(Note_Content);
  Note_Icon=request.getParameter("icon");
  Note_Singid=request.getParameter("signid");
  Board_Id=request.getParameter("fid");
  Return_Id=request.getParameter("returnid");

  String userName="BBS_Guest" ;
  if(session.getValue("UserName") != null){
  	userName=session.getValue("UserName")+"";
  }

  String guestName = request.getParameter("Guest_Sign");
  
  //guestName=yy.ex_chinese(guestName);
  if(guestName==null){
  	guestName="";
  }
  //if(!guestName.equals(""))
  //{
     //userName = guestName;
  //}
//out.println(userName);
//out.close();
  //userName = userName + guestName;
  if (Return_Id.toString().equals("null"))
      Return_Id="0";
  if (Note_Title.equals("")||Note_Content.equals(""))
  {
    response.sendRedirect("err.jsp?id=1");
  }else
  {
   Connection con=yy.getConn();
   Statement  stmt=con.createStatement();
  
   if (Return_Id!="0")
   {
      sql="update forum_post set post_reply_count=post_reply_count+1,post_replier='" + userName + "',post_reply_date=to_date('"+yy.getTime()+"','YYYY-MM-DD HH24:MI:SS') where post_id="+Return_Id;
      stmt.executeUpdate(sql);
      sql="update forum_board set fm_post_count=fm_post_count+1,fm_last_poster='"+userName+"',fm_last_post_date=to_date('"+yy.getTime()+"','YYYY-MM-DD HH24:MI:SS') where fm_id="+Board_Id;
      stmt.executeUpdate(sql);
   }else
   {
     sql="update forum_board set fm_post_count=fm_post_count+1,fm_last_poster='"+userName+"',fm_main_post_count=fm_main_post_count+1 where fm_id="+Board_Id;
     stmt.executeUpdate(sql);
   }
   sql="update USERINFO set ur_post_count=ur_post_count+1 where ur_loginname='"+userName+"'";
   stmt.executeUpdate(sql);





   sql="insert into forum_post(post_id,post_board_id,post_reply_id,post_title,post_content,post_date,post_author,post_length,post_show_sign,post_image,post_ip,post_replier,post_reply_date,post_guest_sign,post_reply_count,post_click_count)";
   sql=sql+"values(SEQ_FORUM_POST.nextval,"+Board_Id+","+Return_Id+",'"+Note_Title+"','"+Note_Content+"',to_date('"+yy.getTime()+"','YYYY-MM-DD HH24:MI:SS'),'"+userName+"',"+Note_Content.length()+","+Note_Singid+",'"+Note_Icon+"','"+request.getRemoteHost()+"','"+userName+"',to_date('"+yy.getTime()+"','YYYY-MM-DD HH24:MI:SS'),'"+guestName+"',0,0)";
   out.println(sql);
   //out.close();
   stmt.executeUpdate(sql);
   if (Return_Id=="0")
   {
   	response.sendRedirect("board.jsp?fid="+Board_Id);
%>
<html>
<meta http-equiv='refresh' content='2;url=board.jsp?fid=<%=Board_Id%>'>
<body>
<p>&nbsp;</p>
<table width="75%" border="1" align="center" cellpadding="5" cellspacing="0">
  <tr>
    <td bgcolor="e9e9e9">系统提示：</td>
  </tr>
  <tr>
    <td><font size=2 color=blue>您的贴子发表成功，正在处理您的提交信息，稍后自动返回。</font></td>
  </tr>
</table>
<%
   }else
{
	response.sendRedirect("shownote.jsp?fid="+Board_Id+"&noteid="+Return_Id);
%>
<html>
<meta http-equiv='refresh' content='2;url=shownote.jsp?fid=<%=Board_Id%>&noteid=<%=Return_Id%>'>
<body>
<p>&nbsp;</p>
<table width="75%" border="1" align="center" cellpadding="5" cellspacing="0">
  <tr>
    <td bgcolor="e9e9e9">系统提示：</td>
  </tr>
  <tr>
    <td><font size=2 color=blue>您的贴子发表成功，正在处理您的提交信息，稍后自动返回。</font></td>
  </tr>
</table>
<%
}

  }
%>
</body>
</html>