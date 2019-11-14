<%@page contentType="text/html; charset=gb2312" language="java" import="java.sql.*"  %>
<%
if (session.getValue("UserName")==null)
{
 response.sendRedirect("err.jsp?id=5");
}

%>
<html>
<head>
<META NAME="keywords" CONTENT=" 论坛  java forum jsp forum">
<META NAME="description" CONTENT=" 论坛  java forum jsp forum">
<link rel='stylesheet' type='text/css' href='inc/FORUM.CSS'><script language="JavaScript">
function Popup(url, window_name, window_width, window_height)
{ settings=
"toolbar=no,location=no,directories=no,"+
"status=no,menubar=no,scrollbars=yes,"+
"resizable=yes,width="+window_width+",height="+window_height;

NewWindow=window.open(url,window_name,settings); }

function icon(theicon) {
document.input.content.value += " "+theicon;
document.input.content.focus();
}
</script>

<title>论坛</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
</head>
<body text="#0000ff" >
<%@include file="inc/left.jsp"%>
<jsp:include page="inc/public.jsp" flush="true"/>

<table width="100%" cellspacing="0" cellpadding="0" align="center">

<%!String Board_Id,Note_Id,Edit_Id,sql,Board_Name,Note_Author,Note_Title,Note_Content,Note_Sign;%>
<%
 Board_Id=request.getParameter("fid");
 Note_Id=request.getParameter("noteid");
 Edit_Id=request.getParameter("editid");
 Connection con=yy.getConn();
 Statement  stmt=con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
 ResultSet rs=null;
 sql="Select fm_name from forum_board Where fm_id="+Board_Id;
 rs=stmt.executeQuery(sql);
 while(rs.next())
 Board_Name=rs.getString("fm_name");
 sql="Select post_author,post_title,post_content,post_show_sign from forum_post Where post_id="+Edit_Id;
 //out.println(sql);
 rs=stmt.executeQuery(sql);
 while(rs.next())
 {
   Note_Author=rs.getString("post_author");
   Note_Title=rs.getString("post_title");
   Note_Content=rs.getString("post_content");
   Note_Sign=rs.getString("post_show_sign");
   //out.println(Note_Sign);
 }

%>
<form method="post" name="input" action="querymodify.jsp">
<tr>
    <td width="62%" heigh="22" height="24">&nbsp;&nbsp;<a href=board.jsp?fid=<%=Board_Id%>><%=Board_Name%></a>&gt;&gt;修改贴子</td>
    <td class="post" align="right" width="38%" height="24"> &nbsp;&nbsp;</td>
  </tr></table>
  <table cellspacing="0" cellpadding="0" border="0" width="100%" align="center">



	<tr>
      <td bgcolor="#e9e9e9" width="100%">
        <table border="0" cellspacing="1" cellpadding="6" width="100%">

        <tr bgcolor="#e9e9e9">
          <td colspan="2">发表文章</td>
</tr>


<tr>

          <td  height="35" bgcolor="#F7FBFF">文章标题：</td>

          <td  height="35" bgcolor="#F7FBFF">
            <input type="text" name="title" size="45" value="<%=Note_Title%>" />
            <input type="hidden" name="fid" size="45" value="<%=Board_Id%>" />
            <input type="hidden" name="noteid" size="45" value="<%=Note_Id%>" />
            <input type="hidden" name="editid" size="45" value="<%=Edit_Id%>" />
          </td>
</tr>

<tr>

          <td  bgcolor="#F7FBFF">图标：</td>

          <td bgcolor="#F7FBFF">
            <input type="radio" value="FACE1" name="icon" checked><img src="IMAGES/FACE1.GIF" WIDTH="20" HEIGHT="20" alt="微笑">
	<input type="radio" name="icon" value="FACE2"><img src="IMAGES/FACE2.GIF" WIDTH="20" HEIGHT="20" alt="无聊哦">
	<input type="radio" name="icon" value="FACE3"><img src="IMAGES/FACE3.GIF" WIDTH="20" HEIGHT="20" alt="委屈">
	<input type="radio" name="icon" value="FACE4"><img src="IMAGES/FACE4.GIF" WIDTH="20" HEIGHT="20" alt="顽皮">
	<input type="radio" name="icon" value="FACE5"><img src="IMAGES/FACE5.GIF" WIDTH="20" HEIGHT="20" alt="表情扭曲">
        <input type="radio" name="icon" value="FACE6"><img src="IMAGES/FACE6.GIF" WIDTH="20" HEIGHT="20" alt="发傻">
	<input type="radio" name="icon" value="FACE7"><img src="IMAGES/FACE7.GIF" WIDTH="20" HEIGHT="20" alt="靠！I 服了 YOU">
	<input type="radio" name="icon" value="FACE8"><img src="IMAGES/FACE8.GIF" WIDTH="20" HEIGHT="20" alt="撅嘴">
	<input type="radio" name="icon" value="FACE9"><img src="IMAGES/FACE9.GIF" WIDTH="20" HEIGHT="20" alt="没事偷着乐">
	<input type="radio" name="icon" value="FACE15"><img src="IMAGES/FACE15.GIF" WIDTH="40" HEIGHT="17" alt="原创">
<br>
        <input type="radio" value="FACE10" name="icon"><img src="IMAGES/FACE10.GIF" WIDTH="20" HEIGHT="20" alt="斜视">
	<input type="radio" name="icon" value="FACE11"><img src="IMAGES/FACE11.GIF" WIDTH="20" HEIGHT="20" alt="为难">
	<input type="radio" name="icon" value="FACE12"><img src="IMAGES/FACE12.GIF" WIDTH="20" HEIGHT="20" alt="生气！">
	<input type="radio" name="icon" value="FACE13"><img src="IMAGES/FACE13.GIF" WIDTH="20" HEIGHT="20" alt="小吃一惊">
	<input type="radio" name="icon" value="FACE14"><img src="IMAGES/FACE14.GIF" WIDTH="20" HEIGHT="20" alt="不好意思的笑">
	<input type="radio" name="icon" value="FACE17"><img src="IMAGES/FACE17.GIF" WIDTH="20" HEIGHT="20" alt="狂吼">
        <input type="radio" name="icon" value="FACE18"><img src="IMAGES/FACE18.GIF" WIDTH="20" HEIGHT="20" alt="嘻嘻">
	<input type="radio" name="icon" value="FACE19"><img src="IMAGES/FACE19.GIF" WIDTH="20" HEIGHT="20" alt="痛苦的哭了">
	<input type="radio" name="icon" value="FACE20"><img src="IMAGES/FACE20.GIF" WIDTH="20" HEIGHT="20" alt="帅呆了">
	<input type="radio" name="icon" value="FACE16">
            <img src="IMAGES/FACE16.GIF" WIDTH="40" HEIGHT="17" alt="转贴"> <br />
             <input type="radio" name="icon" value="EXELAMATION.GIF" /><img src="IMAGES/exclamation.gif" alt="感叹" />&nbsp;
    <input type="radio" name="icon" value="question.GIF" /><img src="IMAGES/QUESTION.GIF" alt="疑问" />&nbsp;
    <input type="radio" name="icon" value="thumbup.GIF" /><img src="IMAGES/THUMBUP.GIF" alt="赞成" />&nbsp;
    <input type="radio" name="icon" value="thumbdown.GIF" />
            <img src="IMAGES/THUMBDOWN.GIF" alt="反对" /> </td>
        </tr>

<tr>

          <td valign="top" nowrap bgcolor="#F7FBFF">文章内容：</td>


          <td bgcolor="#F7FBFF">
            <table width="100%"><tr>
                  <td align="left" width="70%" colspan="2"> <a href="javascript:icon('[b] [/b]')"><img src="IMAGES/BB_BOLD.GIF" border="0"></a>&nbsp;
                    &nbsp; <a href="javascript:icon('[i] [/i]')"><img src="IMAGES/bb_italicize.gif" border="0"></a>&nbsp;
                    &nbsp; <a href="javascript:icon('[u] [/u]')"><img src="IMAGES/bb_underline.gif" border="0"></a>&nbsp;
                    &nbsp; <a href="javascript:icon('[email] [/email]')"><img src="IMAGES/BB_EMAIL.GIF" border="0"></a>&nbsp;
                    &nbsp; <a href="javascript:icon('[quote] [/quote]')"><img src="IMAGES/BB_QUOTE.GIF" border="0" width="23" height="22"></a>&nbsp;
                    &nbsp; <a href="javascript:icon('[url]http:// [/url]')"><img src="IMAGES/BB_URL.GIF" border="0"></a>&nbsp;
                    &nbsp; <a href="javascript:icon('[img]http:// [/img]')"><img src="IMAGES/BB_IMAGE.GIF" border="0"></a>
                    &nbsp; &nbsp;<a href="javascript:icon('[flash]http:// [/flash]')"><img src="IMAGES/SWF.GIF" border="0"></a>
                    &nbsp; </td>
                </tr>

<tr><td align="left" width="70%">
                    <textarea rows="15" cols="70" name="content"><%=Note_Content%></textarea>
    <!--Jony:屏蔽<p><input type="checkbox" name="signid" value="1"
	<%/*
	if (Note_Sign!=null)
	{
	if (Note_Sign.equals("1"))
	   out.println("checked");
	}*/
	%>


	> 使用个人签名？（选择此项你的个人签名将会附在贴子下方）</p>-->
  </td>
                <td>
                 <table border="1" align="center"><tr><td><a href="javascript:icon(':)')"><img src="IMAGES/SMILE.GIF" border="0"></a></td><td><a href="javascript:icon(':(')"><img src="IMAGES/SAD.GIF" border="0"></a></td></tr><tr><td><a href="javascript:icon(':D')"><img src="IMAGES/BIGSMILE.GIF" border="0"></a></td><td><a href="javascript:icon(';)')"><img src="IMAGES/WINK.GIF" border="0"></a></td></tr><tr><td><a href="javascript:icon(':cool:')"><img src="IMAGES/COOL.GIF" border="0"></a></td><td><a href="javascript:icon(':mad:')"><img src="IMAGES/MAD.GIF" border="0"></a></td></tr><tr><td><a href="javascript:icon(':o')"><img src="IMAGES/SHOCKED.GIF" border="0"></a></td><td><a href="javascript:icon(':P')"><img src="IMAGES/TONGUE.GIF" border="0"></a></td></tr></table>
</td></tr></table>
<center><input type="submit" name="topicsubmit" value="修改" />&nbsp; <input type="reset" name="previewpost" value="重写" />
</center>
          </td>
</tr>

</table>
</td></tr><%@include file="inc/bottom.jsp"%>

</form>


