<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<html>
<head>

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
 
<body leftMargin=0 topMargin=0>
	<%@include file="inc/left.jsp"%>
            <table border="0" cellspacing="0" width="100%" cellpadding="0">
              <!--tr>
			  
          <td height="27" align="left" >&nbsp;&nbsp; <A href="/oa30/website/index.jsp">首页</A> 
            > 热点论坛</td>			
                
          <td align="right"  class="f16Gray">热点论坛 
            <marquee style="display:none" width="100%" height="12" direction="left">
<%
 		CDataCn dCn = null;
 		try{
 		dCn = new CDataCn();
		Connection con = dCn.getConnection();  
		Statement  stmt = con.createStatement();   
		ResultSet  rs = null;   
		String post_id = "";
		String post_title = "";
		String post_board_id = "";
		String fm_name = "";
        String sql="";			
%>


                  </marquee> </td>
				  
              </tr-->
            </table>
                      
<table cellspacing="0" cellpadding="0" width="100%" border="0" background="images/indexsub_leftbg.gif" align="center">
  <tr><td bgcolor="#e9e9e9" colspan="7" valign="top"> 
		 <%//@include file="inc/countBBS.jsp"%> 
        <tr bgcolor="#e9e9e9">         
          <td nowrap  align="left" style="line-height:20px">&nbsp;&nbsp;<b>■最新帖子</b></td>
          <td nowrap  align="left" style="line-height:20px">&nbsp;&nbsp;<b>■热门帖子</b></td>        
        </tr>
		<tr bgcolor="#F7FBFF"> 
			<td width="50%" height="200" valign="top">
				<table cellspacing="1" cellpadding="1" width="100%" border="1" align="center">
			<%				
				ResultSet rs2 = null;
				Statement  stmt2=con.createStatement();
				String countnum = "";
				//sql = "select f.post_id,f.post_board_id,f.post_title,b.fm_name,b.fm_id,count(f2.post_id) as countnum from forum_post f,forum_post f2,forum_board b where b.fm_id = f.post_board_id and f.post_reply_id = 0 and  f2.post_reply_id=f.post_id   group by f.post_date,f.post_id,f.post_board_id,f.post_title,b.fm_name,b.fm_id order by f.post_date desc";
				sql = "select f.post_id,f.post_board_id,f.post_title,b.fm_name,b.fm_id from forum_post f,forum_board b where b.fm_id = f.post_board_id and f.post_reply_id = 0 order by f.post_date desc";
				rs=stmt.executeQuery(sql);
				int ii = 0;
				while (rs.next())
				{					
					if(ii>20){
						break;
					}
					post_title = rs.getString("post_title");		
					if(post_title.length()>10)
					{					
						post_title = post_title.substring(0,10) + "...";
						
					}
					post_board_id = rs.getString("post_board_id").toString();
					post_id = rs.getString("post_id").toString();
					fm_name = rs.getString("fm_name").toString();
					sql = "select count(post_id) as countnum from forum_post where post_reply_id = '" + post_id + "'";					
					rs2 = stmt2.executeQuery(sql);
					if(rs2.next())
					{
						countnum = rs2.getString("countnum");
					}
					ii++;
				%>
					<tr><td style="line-height:20px"><a href="board.jsp?fid=<%=post_board_id%>"><font color=#cc3333>·[<%=fm_name%>]</font></a></td>
					<td>
					<a href="shownote.jsp?fid=<%=post_board_id%>&noteid=<%=post_id%>" target="_blank"><font color=#000099><%out.println(post_title);%></a></td><td><font color=#000099>回复数：<%=countnum%></td></font>
					</tr>
				<%
					}
				  //<jsp:include page="inc/showonline.jsp" flush="true"/>
						%>
				</table>
			</td>
			<td width="50%" height="200" valign="top"> 
				<table cellspacing="1" cellpadding="1" width="100%" border="1" align="center">
			<%	
				sql="select f.post_id,f.post_board_id,f.post_title,b.fm_name,b.fm_id,count(f2.post_id) as countnum from forum_post f,forum_post f2,forum_board b where b.fm_id = f.post_board_id and f.post_reply_id = 0 and  f2.post_reply_id=f.post_id   group by f.post_click_count,f.post_id,f.post_board_id,f.post_title,b.fm_name,b.fm_id order by countnum desc,f.post_click_count desc";
				rs=stmt.executeQuery(sql);
				int j = 0;
				while (rs.next())
				{					
					if(j>20){
						break;
					}
					post_title = rs.getString("post_title");		
					if(post_title.length()>9)
					{					
						post_title = post_title.substring(0,8) + "...";
						
					}
					post_board_id = rs.getString("post_board_id").toString();
					post_id = rs.getString("post_id").toString();
					fm_name = rs.getString("fm_name").toString();
					j++;
				%>
					<tr><td style="line-height:20px"><a href="board.jsp?fid=<%=post_board_id%>"><font color=#cc3333>·[<%=fm_name%>]</font></a></td>
					<td>
					<a href="shownote.jsp?fid=<%=post_board_id%>&noteid=<%=post_id%>" target="_blank"><font color=#000099><%out.println(post_title);%></a></td><td><font color=#000099>回复数：<%=rs.getString("countnum").toString()%></td></font>
					</tr>
				<%
					}
				  //<jsp:include page="inc/showonline.jsp" flush="true"/>
						%>
				</table>
			</td>
		</tr>
		
<jsp:include page="inc/showonline.jsp" flush="true"/>
<%@include file="inc/bottom.jsp"%>
<html><script language="JavaScript"></script></html>
<%
  try {
		
	rs.close();
	stmt.close();
	con.close();
	}
	catch (Exception ex) {
		 out.println(ex);
 }

%>
<%


} catch (Exception ex) {
	System.out.println(new java.util.Date() + "--"
			+ request.getServletPath() + " : " + ex.getMessage());
} finally {
	if(dCn != null)
	dCn.closeCn();
}

%>