<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%! String Board_Name,Board_Id,Note_Id;%>
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
		location.href = "bbsDel.jsp?fid="+fid+"&Returnid="+returnid;
		return false;
	}
}
function doDelReply(fid,returnid,replyId,checkDel) {
	if (confirm("确认要删除此帖子吗？")) {
		location.href = "bbsDelReply.jsp?fid="+fid+"&Returnid="+returnid+"&replyId="+replyId+"&checkDel="+checkDel;
		return false;
	}
}
</script>
<%
CDataCn dCn = null;
CDataImpl dImpl = null;
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn);
String checkDel = request.getParameter("checkDel") != null ? request.getParameter("checkDel") : "";	
Board_Id=request.getParameter("fid");
Note_Id=request.getParameter("noteid");
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
<%@include file="/system/app/skin/skin4/template/list_top.jsp"%>
<!--    模块名称开始    -->
&nbsp;&nbsp;<a href=board.jsp?fid=<%=Board_Id%>><%=Board_Name%></a>&gt;&gt;浏览贴子
<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/list_function.jsp"%> 

<!--    功能按钮开始    -->
  <%
		String advStr = "通知通告";
		if (!Board_Name.equals(advStr) || chkName.equals("admin")) {
	%>
	<a href="post.jsp?fid=<%=Board_Id%>"><img src="IMAGES/TOPIC.GIF" border="0"></a>&nbsp;
	<%}%>
	<a href="post.jsp?fid=<%=Board_Id%>&Returnid=<%=Note_Id%>"><img src="IMAGES/REPLY.GIF"  border="0" ></a>&nbsp;
	<%//if (!"".equals(checkDel)) {
    if ("admin".equals(chkName)) {%>
	<a href="#" onClick="doDel(<%=Board_Id%>,<%=Note_Id%>)"><img src="IMAGES/DELETETZ.GIF"  border="0" ></a>&nbsp;
	<%}%>
<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/list_listtop.jsp"%>                                                                                        
<!--    列表开始    -->
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
       sql = "Select forum_post.*,tb_userinfo.*,to_char(post_date,'YYYY-MM-DD HH24:MI') pdFormated from tb_userinfo,forum_post where forum_post.post_author=tb_userinfo.ui_uid  And forum_post.post_id="+Note_Id+" And post_board_id="+Board_Id+" or forum_post.post_author=tb_userinfo.ui_uid  And forum_post.post_reply_id="+Note_Id+" And post_board_id="+Board_Id+"  order by forum_post.post_id";
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
		String postId = rs.getString("post_id");
	    String Note_Title=rs.getString("post_title");
	    String User_Name=rs.getString("ui_name");
	    String post_reply_id = rs.getString("post_reply_id");
	    String Noteall_Id=rs.getString("post_id");
	    //String User_Level=rs.getString("ur_grade");
	    String Sing_Id=rs.getString("post_show_sign");
	    //if(User_Level==null){
	   // //	User_Level="";
	    //}
		if(User_Name==null) User_Name = rs.getString("ui_uid");
%>

 <tr>
          <td width="22%" bgcolor="#e9e9e9">作者 </td>
          <td bgcolor="#e9e9e9" align="left"><%//if (!"".equals(checkDel) && !post_reply_id.equals("0")) {
          if ("admin".equals(chkName)&& i!=0){%>
          	<a href="#" onClick="doDelReply(<%=Board_Id%>,<%=Note_Id%>,<%=Noteall_Id%>,1);">
          	<img src="image/delete.gif"/ border="0"></a>
          <%}%>
          	&nbsp;文章标题
          	 <%  
          	 	if (chkName.equals("admin")) {
	          	 	if (Note_Id.equals(postId)) {
	          	 %>
	          	<span class="postauthor"><a href="postEdit.jsp?post_id=<%=postId%>&fid=<%=Board_Id%>"><%=Note_Title%></a></span>
	          	<%
	          		}
	          		else {
	          	%>
	          	<span class="postauthor"><a href="postEdit.jsp?post_id=<%=postId%>&fid=<%=Board_Id%>&Returnid=<%=Note_Id%>"><%=Note_Title%></a></span>
	          	<%
	          		}
	          	}
	          	else {
	          	%>
	          	<span class="postauthor"><%=Note_Title%></span>
	          	<%}%>
          	</td>
      </tr>
        <tr>
          <td rowspan="3" valign="top" bgcolor="#F7FBFF" > <span class="postauthor"><%=User_Name%></span><br />
           <br /><div><center>
                <span class="postauthor"</span><br />
                <br />
                <%//=User_Level%><br />

              <!--注册日期 ：<span class="postauthor"></span>--></div>
          </td>
          <td valign="top" bgcolor="#F7FBFF" align="left"><img src="IMAGES/<%if(rs.getString("post_image")!=null){out.print(rs.getString("post_image"));}%>.GIF"  />
            &nbsp; 发表于： <span class="postauthor"><%=rs.getString("pdFormated")%></span></td>
        </tr>
      	<tr>
           <td height="120" valign="top" bgcolor="#F7FBFF" align="left">
              		<%=rs.getString("post_content")%>
          </td>
        </tr>
<tr>
          <td valign="top" bgcolor="#F7FBFF">
            <table border="0" cellspacing="0" cellpadding="0" align="left" width="100%" height="20">
              <tr>
                <td align="left">
                <%
                	String attach_sql = "select bi_id,bi_filename from tb_bimage where bi_tablename " + 
                						"= 'forum_post' and bi_table_id = " + Noteall_Id;
                	//out.print(attach_sql);
           			Vector vPage_attach = dImpl.splitPage(attach_sql,100,1);
           			if (vPage_attach!=null) {
           				out.print("&nbsp;<b>相关附件：</b>");
             			for(int n = 0; n < vPage_attach.size();n++) {
               				Hashtable content_attach = (Hashtable)vPage_attach.get(n);
               				String bi_fileName = content_attach.get("bi_filename").toString();
               				String bi_id = content_attach.get("bi_id").toString();
               				String comma = n == 0 ? "" : "，";
               				out.print(comma + "<a href='isDownload.jsp?tn=forum_post&bi_id=" + bi_id + "'target='_blank'>" + bi_fileName +
               							"</a>");
             			}
             		}
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
<form method="POST" action="shownote.jsp">
<tr bgcolor="#ffffff">
    <td valign="top" height="25" nowrap colspan="2" align="right">

  <input type="hidden" name="fid" size="20" value='<%=Board_Id%>'>
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
		out.print("<a href='shownote.jsp?fid="+Board_Id+"&noteid="+Note_Id+"&boardname="+Board_Name+"&page="+(ShowPage+1)+"'>下一页</a>&nbsp;");
		out.print("<a href='shownote.jsp?fid="+Board_Id+"&noteid="+Note_Id+"&boardname="+Board_Name+"&page="+PageCount+"'>最后页</a>&nbsp;");
	}
	else if((ShowPage>1)&&(ShowPage<PageCount))
	{
		out.print("<a href='shownote.jsp?fid="+Board_Id+"&noteid="+Note_Id+"&boardname="+Board_Name+"&page=1'>第一页</a>&nbsp;");
		out.print("<a href='shownote.jsp?fid="+Board_Id+"&noteid="+Note_Id+"&boardname="+Board_Name+"&page="+(ShowPage-1)+"'>上一页</a>&nbsp;");
		out.print("<a href='shownote.jsp?fid="+Board_Id+"&noteid="+Note_Id+"&boardname="+Board_Name+"&page="+(ShowPage+1)+"'>下一页</a>&nbsp;");
		out.print("<a href='shownote.jsp?fid="+Board_Id+"&noteid="+Note_Id+"&boardname="+Board_Name+"&page="+PageCount+"'>最后页</a>&nbsp;");
	}
	else if((ShowPage>1)&&(ShowPage==PageCount))
	{
		out.print("<a href='shownote.jsp?fid="+Board_Id+"&noteid="+Note_Id+"&boardname="+Board_Name+"&page=1'>第一页</a>&nbsp;");
		out.print("<a href='shownote.jsp?fid="+Board_Id+"&noteid="+Note_Id+"&boardname="+Board_Name+"&page="+(ShowPage-1)+"'>上一页</a>&nbsp;");
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
    <td class="post" valign="top" height="6" nowrap>&nbsp;<a href="post.jsp?fid=<%=Board_Id%>&Returnid=<%=Note_Id%>"><img src="IMAGES/REPLY.GIF"  border="0" ></a>&nbsp;
	<%
		if (!Board_Name.equals(advStr) || chkName.equals("admin")) {
	%>
	<a href="post.jsp?fid=<%=Board_Id%>"><img src="IMAGES/TOPIC.GIF" border="0"></a>
	<%}%>
	</td>
<td align="right"  height="6" nowrap>&nbsp;
</td></tr></table>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
</body>
</html>
<!--    列表结束    -->
<%
}
catch(Exception e){
	System.out.print(e.toString());
}
finally{
	dImpl.closeStmt();
	dCn.closeCn(); 
}
%>
<%@include file="/system/app/skin/bottom.jsp"%>