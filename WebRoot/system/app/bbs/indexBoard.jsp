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
<body>
	<%@include file="inc/left.jsp"%>
            <table border="0" cellspacing="0" width="100%" cellpadding="0">
              <tr>
			  
          <td height="27" align="left" >&nbsp;&nbsp; <A href="/oa30/website/index.jsp">首页</A> 
            > 热点论坛</td>			
                
          <td align="right"  class="f16Gray">热点论坛 
            <marquee style="display:none" width="100%" height="12" direction="left">

       
<%
		Connection con=yy.getConn();
		Statement  stmt=con.createStatement();
		ResultSet  rs=null;
		


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
				  
              </tr><tr>
          <td height="5" COLSPAN=2 class="f12std"></td>
        </tr>
            </table>
          
    
<table cellspacing="0" cellpadding="0" width="100%" border="0" background="<%=URL_HEAD%>website/images/indexsub_leftbg.gif" align="center">
  <tr><td bgcolor="#e9e9e9"> 
		<jsp:include page="inc/public.jsp" flush="true"/>
        <tr bgcolor="#e9e9e9">
          <td nowrap height="14">&nbsp;</td>
          <td nowrap  height="14">论坛列表</td>
          <td nowrap  align="center" height="14">新窗</td>
          <td nowrap  align="center" height="14">主题数量</td>
          <td nowrap  align="center" height="14">贴子数量 </td>
          <td nowrap  align="center" height="14">最后回复</td>
          <td nowrap  align="center" height="14">版主</td>
        </tr>
 
		<%	

		sql="SELECT f.*,to_char(f.fm_last_post_date,'YYYY-MM-DD HH24:MI:SS') fdFormated,u.ur_realname,f.fm_last_poster lastPoster FROM forum_board f,userinfo u where u.ur_loginname=f.fm_master_name order by f.fm_id desc";

		rs=stmt.executeQuery(sql);
		while (rs.next())
		{
			String Time_Str=rs.getString("fdFormated");
			String Man_Str=rs.getString("lastPoster");
			String Forum_id=rs.getString("fm_id");
			String Forum_Mastor=rs.getString("ur_realname");
				
				if (Man_Str==null){
			       		Man_Str="无";
			       	}
				/* Jony: 屏蔽无关信息
				else
					Man_Str="<a href='member.jsp?member="+Man_Str+"'>"+Man_Str+"</a>";
				*/
				
				if ((Forum_Mastor==null)||(Forum_Mastor.equals("")))
				{
                   			Forum_Mastor="招骋中...";
                   		}
                   		/* Jony: 屏蔽无关信息
				else
					Forum_Mastor="<a href=member.jsp?member="+Forum_Mastor+">"+Forum_Mastor+"</a>";
				*/
				%>
		<tr bgcolor="#F7FBFF">
          <td align="center"  height="26" ><img src="image/folder.gif" width="13" height="16"></td>
          <td height="26"  bgcolor="#F7FBFF"><a href="board.jsp?fid=<%=Forum_id%>"> <%=rs.getString("fm_name")%> </a>
            <br />
          </td>
          <td align="center" height="26" >&nbsp;<a href="board.jsp?fid=<%=Forum_id%>" target="_blank"><img border="0" src="image/newwin.gif" width="14" height="11"></a></td>
          <td align="center" height="26" ><%=rs.getString("fm_main_post_count")%></td>
          <td align="center" height="26" ><%=rs.getString("fm_post_count")%></td>
          <td height="26" >时间：<%=Time_Str.substring(0,16)%><br>
            作者：<%=Man_Str%></td>
          <td align="center" height="26"><%=Forum_Mastor%></td>
        </tr>
		<%
                }     
                %>
</table></td></tr>
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