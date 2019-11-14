<%@page contentType="text/html; charset=gb2312" language="java" import="java.sql.*"%>
<html>
<head>
<link rel='stylesheet' type='text/css' href='inc/FORUM.CSS'>
<link href="/oa30/website/images/main.css" rel="stylesheet" type="text/css">    
<META NAME="keywords" CONTENT="论坛  java forum jsp forum">
<META NAME="description" CONTENT="论坛  java forum jsp forum">
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
<body leftMargin=0 topMargin=0>
	<%@include file="inc/left.jsp"%>
            <table border="0" cellspacing="0" width="100%" cellpadding="0">
              <!--tr>
			  
          <td height="27" align="left" >&nbsp;&nbsp; <A href="/oa30/website/index.jsp">首页</A> 
            > 热点论坛</td>			
                
          <td align="right"  class="f16Gray">热点论坛 
            <marquee style="display:none" width="100%" height="12" direction="left">

       
<%
		Connection con=yy.getConn();
		Statement  stmt=con.createStatement();
		ResultSet  rs=null;
		String post_id = "";
		String post_title = "";
		String post_board_id = "";
		String fm_name = "";
        String sql="";
		/*"select pn_title,pn_content,to_char(pn_date,'yyyy-mm-dd hh24:mi:ss') pn_date from forum_notice order by pn_id desc";
		String Notice="";
		int i=0;
		rs=stmt.executeQuery(sql);
		//rs.last();
		//if (rs.getRow()>0)
		//{
		 while ((rs.next())&&(i<5))
			{
		  String Time=rs.getString("pn_date");
		  Time=Time.substring(5,16);

		  Notice="<B>"+rs.getString("pn_title")+":</B><font color=black>"+rs.getString("pn_content")+"</font><font color=gray>&nbsp;"+Time+"</font>&nbsp;&nbsp;&nbsp;"+Notice;;
		  
		  i++;

		  
		  }
		
		out.println(Notice);*/



%>


                  </marquee> </td>
				  
              </tr-->
            </table>
          
  
<table cellspacing="0" cellpadding="0" width="100%" border="1" background="<%=URL_HEAD%>website/images/indexsub_leftbg.gif" align="center">
  <tr><td bgcolor="#e9e9e9" colspan="7" valign="top"> 
		<jsp:include page="inc/public.jsp" flush="true"/>
		 <%@include file="inc/countBBS.jsp"%> 
        <tr bgcolor="#e9e9e9">         
          <td nowrap  align="left" style="line-height:20px">&nbsp;&nbsp;<b>■最新帖子</b></td>
          <td nowrap  align="left" style="line-height:20px">&nbsp;&nbsp;<b>■热门帖子</b></td>        
        </tr>
		<tr bgcolor="#F7FBFF">
			<td width="50%">
				<table cellspacing="1" cellpadding="1" width="100%" border="1" align="center">
			<%	
				sql="select f.*,b.fm_name,b.fm_id from forum_post f,forum_board b where b.fm_id = f.post_board_id and post_reply_id = 0 order by post_date desc";
				rs=stmt.executeQuery(sql);
				int i = 0;
				while (rs.next())
				{					
					if(i>20){
						break;
					}
					post_title = rs.getString("post_title");		
					if(post_title.length()>18)
					{					
						post_title = post_title.substring(0,17) + "...";
						
					}
					post_board_id = rs.getString("post_board_id").toString();
					post_id = rs.getString("post_id").toString();
					fm_name = rs.getString("fm_name").toString();
					i++;
				%>
					<tr><td style="line-height:20px"><a href="board.jsp?fid=<%=post_board_id%>"><font color=#cc3333>·[<%=fm_name%>]</font></a></td>
					<td>
					<a href="shownote.jsp?fid=<%=post_board_id%>&noteid=<%=post_id%>" target="_blank"><font color=#000099><%out.println(post_title);%></font></a>
					</td></tr>
				<%
					}
				  //<jsp:include page="inc/showonline.jsp" flush="true"/>
						%>
				</table>
			</td>
			<td width="50%">
				<table cellspacing="1" cellpadding="1" width="100%" border="1" align="center">
			<%	
				sql="select f.*,b.fm_name,b.fm_id from forum_post f,forum_board b where b.fm_id = f.post_board_id and post_reply_id = 0 order by post_click_count desc";
				rs=stmt.executeQuery(sql);
				int j = 0;
				while (rs.next())
				{					
					if(j>20){
						break;
					}
					post_title = rs.getString("post_title");		
					if(post_title.length()>18)
					{					
						post_title = post_title.substring(0,17) + "...";
						
					}
					post_board_id = rs.getString("post_board_id").toString();
					post_id = rs.getString("post_id").toString();
					fm_name = rs.getString("fm_name").toString();
					j++;
				%>
					<tr><td style="line-height:20px"><a href="board.jsp?fid=<%=post_board_id%>"><font color=#cc3333>·[<%=fm_name%>]</font></a></td>
					<td>
					<a href="shownote.jsp?fid=<%=post_board_id%>&noteid=<%=post_id%>" target="_blank"><font color=#000099><%out.println(post_title);%></font></a>
					</td></tr>
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