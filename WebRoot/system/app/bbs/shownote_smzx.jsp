<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>

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
function doDel(fid,returnid) {
	if (confirm("确认要删除此帖子吗？")) {
		location.href = "bbsDel_smzx.jsp?fid="+fid+"&Returnid="+returnid;
		return false;
	}
}
function doDelReply(fid,returnid,replyId,Page) {
	if (confirm("确认要删除此帖子吗？")) {
		location.href = "bbsDelReply_smzx.jsp?fid="+fid+"&Returnid="+returnid+"&replyId="+replyId+"&checkDel=true&page="+Page;
		return false;
	}
}
</script>

<body>
<table width="100%" cellspacing="0" cellpadding="0" align="center">
<tr>

<%! String Board_Name,Board_Id,Note_Id;%>
<%

	String checkDel = request.getParameter("checkDel") != null ? request.getParameter("checkDel") : "";	
	
    Board_Id=request.getParameter("fid");
    Note_Id=request.getParameter("noteid");

//update20080122
CDataCn dCn = null;
try{
	dCn = new CDataCn();
	Connection con=dCn.getConnection();
    Statement stmt=con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
    ResultSet rs=null;
    String sql="Select fm_name from forum_board Where fm_id="+Board_Id;
    
    CMySelf mySelf = (CMySelf)session.getAttribute("mySelf");

    rs=stmt.executeQuery(sql);
    while(rs.next())
    {
      Board_Name=rs.getString("fm_name");
    }
    
	String chkName = mySelf.getMyUid() ;
    
%>
	<td width="62%">&nbsp;&nbsp;<a href=board.jsp?fid=<%=Board_Id%>><%=Board_Name%></a>&gt;&gt;浏览贴子
    </td>
    <td class="post" align="right" width="38%">
	<%		
	   if (chkName.equals("admin")) {
	%>
	<a href="post_smzx.jsp?fid=<%=Board_Id%>"><img src="IMAGES/TOPIC.GIF" border="0"></a>&nbsp;
	<%}%>
	<a href="post_smzx.jsp?fid=<%=Board_Id%>&Returnid=<%=Note_Id%>"><img src="IMAGES/REPLY.GIF"  border="0" ></a>&nbsp;
	<%//if (!"".equals(checkDel)) {%>
	<a href="#" onClick="doDel(<%=Board_Id%>,<%=Note_Id%>)"><img src="IMAGES/DELETETZ.GIF"  border="0" ></a>&nbsp;
	<%//}%>
</td>
  </tr></table>

<table cellspacing="0" cellpadding="0" border="0" width="100%" align="center">
<tr>
  <td bgcolor="#e9e9e9">
      <table border="0" cellspacing="1" cellpadding="6" width="100%">
        <%
       sql="update forum_post set post_click_count=post_click_count+1 where post_id="+Note_Id;
       stmt.executeUpdate(sql);
       int PageSize=10;
       int RecordCount=0;
       int PageCount=0;
       int ShowPage=1;
       sql="Select forum_post.*,to_char(post_date,'YYYY-MM-DD HH24:MI') pdFormated  from forum_post where forum_post.post_id="+Note_Id+" And post_board_id="+Board_Id+" or forum_post.post_reply_id="+Note_Id+" And post_board_id="+Board_Id+"  order by forum_post.post_id";
       //out.println(sql);
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
		String post_id=rs.getString("post_id");
	    String Note_Title=rs.getString("post_title");
	    //String User_Name=rs.getString("ui_name");
	    String User_Name=rs.getString("post_guest_sign");
		String post_reply_id = rs.getString("post_reply_id");
	    String Noteall_Id=rs.getString("post_id");
		String post_flag=rs.getString("post_flag");
	    //String User_Level=rs.getString("ur_grade");	    
	    //if(User_Level==null){
	   // //	User_Level="";
	    //}
		//if(User_Name==null) User_Name = rs.getString("ui_uid");
%>

 <tr>
          <td width="22%" bgcolor="#e9e9e9">作者 </td>
          <td bgcolor="#e9e9e9" align="left"><%if(!post_reply_id.equals("0")) {%>
          	<a href="#" onClick="doDelReply(<%=Board_Id%>,<%=Note_Id%>,<%=Noteall_Id%>,<%=Page%>);">
          	<img src="image/delete.gif"/ border="0"></a>
          <%}%>
          	&nbsp;文章标题 <span class="postauthor"><%=Note_Title%>
<%
	 if(Page==null)Page="1";
	 if(post_flag.equals("0"))
	{
%>
          	<input type="button" name="chenk" value="审核" onClick="window.location.href='check_smzx.jsp?noteid=<%=Note_Id%>&post_id=<%=post_id%>&fid=<%=Board_Id%>&page=<%=Page%>'" style="cursor:hand">
<%
	}
    else if(post_flag.equals("1"))
	{
%>
           <input type="button" name="chenk" value="取消审核" onClick="window.location.href='cancel_smzx.jsp?noteid=<%=Note_Id%>&post_id=<%=post_id%>&fid=<%=Board_Id%>&page=<%=Page%>'" style="cursor:hand">
<%
	}
%>
          	</span></td>
      </tr>
        <tr>
          <td rowspan="3" valign="top" bgcolor="#F7FBFF" > <span class="postauthor"><%=User_Name%></span><br>
            <span class="postauthor">作者IP：<%=rs.getString("post_ip")%></span><br />
           <br /><div><center>
                <span class="postauthor"></span><br />
                <br />
                <%//=User_Level%><br />

              <!--注册日期 ：<span class="postauthor"></span>--></div>
          </td>
          <td valign="top" bgcolor="#F7FBFF" align="left"><img src="IMAGES/<%if(rs.getString("post_image")!=null){out.print(rs.getString("post_image"));}%>.GIF"  />
            &nbsp; 发表于： <span class="postauthor"><%=rs.getString("pdFormated")%></span></td>
        </tr>
      <tr>
              <td height="120" valign="top" bgcolor="#F7FBFF" align="left">&nbsp;&nbsp;<%=rs.getString("post_content")%>


          </td>
        </tr>
<tr>
          <td valign="top" bgcolor="#F7FBFF">
            <table border="0" cellspacing="0" cellpadding="0" align="left" width="378" height="20">
              <tr>
                <td><!--Jony: 屏蔽无关信息<a href="member.jsp?member=<%/*=User_Name*/%>"><img src="IMAGES/PROFILE.GIF" border="0" alt="查看此人的个人资料" width="45" height="18"></a>-->
                  <!--<a href="mailto:<%/*if(rs.getString("ur_email")!=null){out.print(rs.getString("ur_email"));}*/%>"><img src="IMAGES/EMAIL.GIF" border="0" alt="发送E-Mail给此人" width="45" height="18" /></a>-->


                  <%
                                //End If
                                %>
                </td>
</tr>

</table>
          </td>
</tr>

<%
	if (!rs.next())
		break;
	}
}
%>

</table>
</td></tr>
</table>

<table width="100%" cellspacing="0" cellpadding="0" align="center" height="20">
<form method="POST" action="shownote_smzx.jsp">
<tr bgcolor="#ffffff">
    <td valign="top" height="25" nowrap colspan="2" align="right"><input type="hidden" name="fid" size="20" value='<%=Board_Id%>'>
      <input type="hidden" name="noteid" size="20" value='<%=Note_Id%>'>
  <input type="hidden" name="boardname" size="20" value='<%=Board_Name%>'>
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
		out.print("<a href='shownote_smzx.jsp?fid="+Board_Id+"&noteid="+Note_Id+"&boardname="+Board_Name+"&page="+(ShowPage+1)+"'>下一页</a>&nbsp;");
		out.print("<a href='shownote_smzx.jsp?fid="+Board_Id+"&noteid="+Note_Id+"&boardname="+Board_Name+"&page="+PageCount+"'>最后页</a>&nbsp;");
	}
	else if((ShowPage>1)&&(ShowPage<PageCount))
	{
		out.print("<a href='shownote_smzx.jsp?fid="+Board_Id+"&noteid="+Note_Id+"&boardname="+Board_Name+"&page=1'>第一页</a>&nbsp;");
		out.print("<a href='shownote_smzx.jsp?fid="+Board_Id+"&noteid="+Note_Id+"&boardname="+Board_Name+"&page="+(ShowPage-1)+"'>上一页</a>&nbsp;");
		out.print("<a href='shownote_smzx.jsp?fid="+Board_Id+"&noteid="+Note_Id+"&boardname="+Board_Name+"&page="+(ShowPage+1)+"'>下一页</a>&nbsp;");
		out.print("<a href='shownote_smzx.jsp?fid="+Board_Id+"&noteid="+Note_Id+"&boardname="+Board_Name+"&page="+PageCount+"'>最后页</a>&nbsp;");
	}
	else if((ShowPage>1)&&(ShowPage==PageCount))
	{
		out.print("<a href='shownote_smzx.jsp?fid="+Board_Id+"&noteid="+Note_Id+"&boardname="+Board_Name+"&page=1'>第一页</a>&nbsp;");
		out.print("<a href='shownote_smzx.jsp?fid="+Board_Id+"&noteid="+Note_Id+"&boardname="+Board_Name+"&page="+(ShowPage-1)+"'>上一页</a>&nbsp;");
		out.print("<font style='color:silver'>下一页</font>&nbsp;");
		out.print("<font style='color:silver'>最后页</font>");
	}
  %>
	转到&nbsp;<select size="1" name="page">
<%
	for (int i=1;i<=PageCount;i++)
	{
		out.println(" <option value="+i+">"+i+"页</option>");
	}
%>
<input type="submit" value="转到" name="B1">
<input type="button" value="返回" onclick="window.history.back();">
</form>
</td></tr>
</form>
<tr bgcolor="#ffffff">
    <td class="post" valign="top" height="6" nowrap>&nbsp;<a href="post_smzx.jsp?fid=<%=Board_Id%>&Returnid=<%=Note_Id%>"><img src="IMAGES/REPLY.GIF"  border="0" ></a>&nbsp;

	<%
		if (chkName.equals("admin")) {
	%>
	<a href="post_smzx.jsp?fid=<%=Board_Id%>"><img src="IMAGES/TOPIC.GIF" border="0"></a>
	<%}%>	</td>
<td align="right"  height="6" nowrap>&nbsp;</td></tr></table>
<%dCn.closeCn();

} catch (Exception ex) {
	System.out.println(new java.util.Date() + "--"
			+ request.getServletPath() + " : " + ex.getMessage());
} finally {
	if(dCn != null)
	dCn.closeCn();
}
%>
</body></html>

<html><script language="JavaScript"></script></html>
<%@include file="/system/app/skin/bottom.jsp"%>
<br>
