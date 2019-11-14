<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%! String Forum_Name,Forum_Mastor,Forum_Id,Forum_AdminName;%>
<script language="JavaScript">
function Popup(url, window_name, window_width, window_height)
{ 
settings=
"toolbar=no,location=no,directories=no,"+
"status=no,menubar=no,scrollbars=yes,"+
"resizable=yes,width="+window_width+",height="+window_height;
NewWindow=window.open(url,window_name,settings); }
function icon(theicon) {
document.input.message.value += " "+theicon;
document.input.message.focus();
}
</script>
<%
CMySelf mySelf = (CMySelf)session.getAttribute("mySelf");
//判定是否是自己发的帖子，如果是
String checkDel = "";
String chkName = mySelf.getMyUid() ;
CDataCn dCn = null;
CDataImpl dImpl = null;
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn);
Connection con=dCn.getConnection();
 String fid=request.getParameter("fid");
 int D_num = 0;			//取得主题发布时间与当前时间的差
 String new_im = "<img src=\"image/new.gif\" border=0>";
 Statement  stmt=con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
 Statement  stmt1=con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
 ResultSet rs = null;
 String sql="Select fm_id,fm_name,fm_master_name,tb_userinfo.ui_name from forum_board,tb_userinfo Where fm_id="+fid+" and tb_userinfo.ui_uid=forum_board.fm_master_name";
 rs=stmt.executeQuery(sql);
//out.println(sql);
 while (rs.next())
 {
   Forum_Name=rs.getString("fm_name");
   Forum_Id=rs.getString("fm_id");
   Forum_Mastor=rs.getString("fm_master_name");
   Forum_AdminName=rs.getString("ui_name");
   //out.println(Forum_Name);
 }
%>
<%@include file="/system/app/skin/skin4/template/list_top.jsp"%>
<!--    模块名称开始    -->
<b>&nbsp;&nbsp;<%=Forum_Name%></b>
<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/list_function.jsp"%>                                                            
<!--    功能按钮开始    -->
  论坛版主：<%=Forum_AdminName%>&nbsp;
  <%
		String advStr = "通知通告";
		//out.println(Forum_Name+"///"+advStr+"........."+chkName);
		if (!Forum_Name.equals(advStr) || chkName.equals("administrator")) {
			//out.println(Forum_Name+"..."+advStr);
	%>
	<a href="post.jsp?fid=<%=Forum_Id%>"><img src="IMAGES/TOPIC.GIF" border="0" ></a>
	<%}%>
<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/list_listtop.jsp"%>                                                                                        
<!--    列表开始    -->
<table class="FindAreaTable1" cellspacing="1" rules="cols" border="0" id="ctl00_DataGrid_DataGrid1" style="border-width:0px;">
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
  int PageSize=15;
  int RecordCount=0;
  int PageCount=0;
  int ShowPage=1;

  sql="Select forum_post.*,to_char(forum_post.post_reply_date,'YYYY-MM-DD HH24:MI') replyDateFormated,round(to_number(sysdate-forum_post.post_reply_date)) d_num,ua.ui_name,ur.ui_name replier from forum_post,tb_userinfo ua,tb_userinfo ur Where post_board_id="+fid+" And post_reply_id=0 and ua.ui_uid=post_author and ur.ui_uid=post_replier order by to_char(forum_post.post_reply_date,'YYYY-MM-DD HH24:MI') desc,post_sequence,post_id desc";
  
  //out.println(sql);
  
  //Statement stmt=con.createStatement();
  rs=stmt.executeQuery(sql);

  rs.last();
  RecordCount=rs.getRow();
  PageCount=(RecordCount % PageSize==0)?(RecordCount/PageSize):(RecordCount/PageSize+1);
  String Page=request.getParameter("page");
  String xx = request.getParameter("xx") != null ? request.getParameter("xx") : "";
  if (!"".equals(xx)) {
  	Page = "1";
  }
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
//更新２００７／１２／０４
CDataCn dCn_new = null;
CDataImpl dImpl_new = null;
String sql_new ="";
try{
dCn_new = new CDataCn();
dImpl_new = new CDataImpl(dCn_new);
Hashtable content = new Hashtable();

for (int i=0;i<PageSize;i++)
{
  Note_Id=rs.getString("post_id");
  Note_Name=rs.getString("post_title");
  Note_Author=rs.getString("post_author");
  //更新２００７／１２／０４
  sql_new ="select ui_name from tb_userinfo where ui_uid='"+Note_Author+"'";
  content=dImpl_new.getDataInfo(sql_new);
  if(content!=null)Note_Author=content.get("ui_name").toString();
  Replay_Name=rs.getString("post_replier");
  //更新２００７／１２／０４
  sql_new ="select ui_name from tb_userinfo where ui_uid='"+Replay_Name+"'";
  content=dImpl_new.getDataInfo(sql_new);
  if(content!=null)Replay_Name=content.get("ui_name").toString();
  
  Replay_Time=rs.getString("replyDateFormated");
  //sql = "select count(*) as post_reply_count from forum_post where post_board_id='"+Forum_Id+"' and post_reply_id = "+Note_Id;  
 // ResultSet rs2 = stmt1.executeQuery(sql);
  String post_reply_count = "";
  //if(rs2.next()){
	  
	  post_reply_count = rs.getString("post_reply_count");
  //}
	checkDel = Note_Author.equals(chkName) ? "&checkDel=true" : "";
%>
         <tr bgcolor="#F7FBFF">
          <td align="center" height="16"><img src="IMAGES/<%=rs.getString("post_image")%>.GIF" ></td>
          <td align="left" height="16" ><a href="shownote.jsp?fid=<%=Forum_Id%>&noteid=<%=Note_Id%><%=checkDel%>"><%=Note_Name%></a><%=Integer.parseInt(rs.getString("d_num")) > 4 ? "" : new_im%>
            &nbsp; </td>
          <td align="center" height="16"><a href="shownote.jsp?fid=<%=Forum_Id%>&noteid=<%=Note_Id%><%=checkDel%>" target="_blank"><img src="image/newwin.gif" border="0"></a></td>
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
  //更新２００７／１２／０４
}
catch(Exception e){
out.print(e.toString());
}
finally{
dImpl_new.closeStmt();
dCn_new.closeCn(); 
}
}else{

%>
        <tr bgcolor="#F7FBFF">
          <td align="center"  height="16" colspan="7" width="633">对不起，该论坛暂时没有贴子　</td>
        </tr>
<%
}
%></table>
<br>
<form name="formPage" method="post" action="" onSubmit="do_Page()"><table width="100%" cellspacing="0" cellpadding="0" align="center" height="2">
<input type="hidden" name="xx">
<script language="javascript">
	function do_Page() {
		if (formPage.page.value == "") {
			alert("请输入您想转到的页数！");
			formPage.page.focus();
			return false;
		}
		if(isNaN(formPage.page.value)) {
			alert("您输入的字符无效，请重新输入！");
			formPage.page.focus();
			formPage.xx.value = "xx";
			return false;
		}
		else {
			formPage.xx.value = "";
			formPage.action = "board.jsp?fid=<%=Forum_Id%>";
			formPage.submit();
		}
	}
</script>
  <tr>
<td  align="right" >
  共有 <font color='red'><%=RecordCount%></font> 条匹配记录  共 <B><%=PageCount%></B> 页 现在是第 <B><%=ShowPage%></B> 页&nbsp;
  <input type="text" name="page" size="2">&nbsp;<b style="cursor:hand" onClick="do_Page()">GO</b>
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
	 %>&nbsp;
</td></tr>
</table>
</form>
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