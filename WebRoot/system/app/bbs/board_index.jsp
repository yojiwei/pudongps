<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<script language="JavaScript">
function Popup(url, window_name, window_width, window_height)
{	settings=
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

//
CDataCn dCn = null;
CDataImpl dImpl = null;
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn);
%>
<%@include file="/system/app/skin/skin4/template/list_top.jsp"%>
<!--    模块名称开始    -->

<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/list_function.jsp"%>                                                            
<!--    功能按钮开始    -->
  
<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/list_listtop.jsp"%>                                                                                        
<!--    列表开始    -->
<table class="FindAreaTable1" cellspacing="1" rules="cols" border="0" id="ctl00_DataGrid_DataGrid1" style="border-width:0px;">
    <tr bgcolor="#e9e9e9">
          <td width="4%" height="14">&nbsp;</td>
          <td width="12%" height="14">专栏</td>
          <td width="30%" height="14">文章标题</td>
          <!--<td width="8%" align="center" height="14">新窗</td>-->
          <td width="10%" align="center" height="14">作者</td>
          <td width="8%" align="center" height="14">回复数量</td>
          <td width="8%" align="center" height="14">浏览数量</td>
          <td width="25%" align="center" height="14">最后回复</td>
     </tr>
     <%  
    	CMySelf mySelf = (CMySelf)session.getAttribute("mySelf");
		//判定是否是自己发的帖子，如果是
		String checkDel = "";
		String chkName = mySelf.getMyUid() ;
		//取得交流平台4个主题
		String sqlStr = "select * from forum_board where fm_id < 45 order by fm_sequence";
		Vector vPage = dImpl.splitPage(sqlStr,4,1);
		Hashtable content = null;
		Vector vPage1 = null;
		Hashtable content1 = null;
		ResultSet rs2 = null;
		String sql = "";
		String Forum_Name = "";
		String fid = "";
		String post_image = "";
		String Note_Id = "";
		String Note_Author = "";
		String Note_Name = "";
		String post_reply_count = "";
		String post_click_count = "";
		String Replay_Time = "";
		String Replay_Name = "";
		int D_num = 0;			//取得主题发布时间与当前时间的差
		String new_im = "<img src=\"image/new.gif\" border=0>";
		if (vPage != null) {
			for (int i = 0;i < vPage.size();i++) {
				content = (Hashtable)vPage.get(i);
				Forum_Name = content.get("fm_name").toString();
				fid = content.get("fm_id").toString();
				sqlStr = "select * from (Select forum_post.*,to_char(forum_post.post_reply_date,'YYYY-MM-DD HH24:MI') " + 
						 "replydateformated,round(to_number(sysdate-forum_post.post_reply_date)) d_num," + 
						 "ua.ui_name,ur.ui_name replier from forum_post,tb_userinfo ua,tb_userinfo ur Where post_board_id = " + 
						 fid + " And post_reply_id=0 and ua.ui_uid=post_author and ur.ui_uid=post_replier order by " + 
						 "to_char(forum_post.post_reply_date,'YYYY-MM-DD HH24:MI') desc,post_sequence,post_id desc) where rownum <= 5";
				vPage1 = dImpl.splitPage(sqlStr,3,1);
				if (vPage1 != null) {
					for (int k = 0;k < vPage1.size();k++) {
						content1 = (Hashtable)vPage1.get(k);
						post_image = content1.get("post_image").toString();
  						Note_Id = content1.get("post_id").toString();
  						Note_Name = content1.get("post_title").toString();
  						Note_Author = content1.get("post_author").toString();
                         //显示最后回复管理员的名称开始
                        Hashtable content_new = new Hashtable(); 
                        String sql_new ="";
                        sql_new="select ui_name from tb_userinfo where ui_uid='"+Note_Author+"'";
                        content_new=dImpl.getDataInfo(sql_new);
                        if(content_new!=null)Note_Author=content_new.get("ui_name").toString();
                        //结束
						post_click_count = content1.get("post_click_count").toString();
						Replay_Time = content1.get("replydateformated").toString();
						Replay_Name = content1.get("post_replier").toString();
                        //显示最后回复管理员的名称开始                        
                        sql_new="select ui_name from tb_userinfo where ui_uid='"+Replay_Name+"'";
                        content_new=dImpl.getDataInfo(sql_new);
                        if(content_new!=null)Replay_Name=content_new.get("ui_name").toString();
                        //结束
						D_num = Integer.parseInt(content1.get("d_num").toString());
						checkDel = Note_Author.equals(chkName) ? "&checkDel=true" : "";
						
						sql = "select count(*) as post_reply_count from forum_post where post_reply_id = " + Note_Id;  
						rs2 = dImpl.executeQuery(sql);
						if(rs2.next()) {
							post_reply_count = rs2.getString("post_reply_count");
						}
     %>
         <tr bgcolor="#F7FBFF">
          <td align="center" height="16"><img src="IMAGES/<%=post_image%>.GIF" ></td>
          <td style="line-height:20px"><a href="board.jsp?fid=<%=fid%>&Menu=交流平台&Module=通知通告"><font color=#cc3333>·[<%=Forum_Name%>]</font></a></td>
          <td height="16"  align="left"><a href="shownote.jsp?fid=<%=fid%>&noteid=<%=Note_Id%><%=checkDel%>"><%=Note_Name%></a><%=D_num > 4 ? "" : new_im%>
            &nbsp; </td>
          <td align="center" height="16"><%=Note_Author%></td>
          <td align="center" height="16"><%=post_reply_count%></td>
          <td align="center" height="16"><%=post_click_count%></td>
          <td height="16">时间：<%=Replay_Time%><br />
            作者：<%=Replay_Name%></td>
</tr>
<%
				}
			}
		}
	}
	else {
%>
        <tr bgcolor="#F7FBFF">
          <td align="center"  height="16" colspan="7" width="633">对不起，该论坛暂时没有贴子　</td>
        </tr>
<%
	}
%>
</table>
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