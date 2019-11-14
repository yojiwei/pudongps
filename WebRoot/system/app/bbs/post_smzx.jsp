<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<script LANGUAGE="javascript" src="../common/common.js"></script>
<script type="text/javascript" src="../infopublish/editor/fckeditor.js"></script>
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
document.input.content.value += " "+theicon;
document.input.content.focus();
}

function checkPost(f){

	/*
	if(f.content.value == "") {
		alert("留言不能为空!");
		f.content.focus();
		return false;
	}
	if(f.content.value.length == 0) {
		alert("留言不能为空!");
		f.content.focus();
		return false;
	} else if(f.content.value.length > 2000) {
		alert("留言不能超过2000字!");
		return false;
	}
	f.topicsubmit.style.display="none";
	//f.previewpost.style.display="none";
	document.all.subdiv.style.display="";
	*/
	f.submit();
}

function textCounter(field, maxlimit) {
	if (field.value.length > maxlimit)
		field.value = field.value.substring(0, maxlimit);
	else
		document.input.remLen.value = maxlimit - field.value.length;
}
</script>
</head>
<body>
<%!String Note_Title,Note_Content,Board_Name,sql;%>
<%
String Board_id=request.getParameter("fid");
String Note_id=request.getParameter("noteid");
String Return_id=request.getParameter("Returnid");
String guestName = "";
int action=1;	//action=1 发贴 action=0 回帖


%>

<%
CDataCn dCn = null;
try{
dCn = new CDataCn();
Connection con=dCn.getConnection();
Statement  stmt=con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
ResultSet  rs=null;

if(action==1)
{
	if (Note_id!=null)
	{
		sql="Select post_content from forum_post Where post_id="+Note_id;
		rs=stmt.executeQuery(sql);
		while (rs.next())
			Note_Content=rs.getString("post_content");
	}else
		Note_Content="";
	if (Note_id!=null)
		Note_Content="[quote]"+Note_Content +"[/quote]";

	if (Return_id!=null)
	{
	  sql="Select post_title from forum_post Where post_id="+Return_id;
	  rs=stmt.executeQuery(sql);
		while (rs.next())
			Note_Title="回复："+rs.getString("post_title");
	}else
		Note_Title="";



	  sql="Select fm_name from forum_board Where fm_id="+Board_id;
	  //out.println(sql);
	  rs=stmt.executeQuery(sql);
	  while (rs.next())
		Board_Name=rs.getString("fm_name");

%>


	<table width="100%" cellspacing="0" cellpadding="0" align="center">
	<form method="post" name="input" action="savepost_smzx.jsp">
	<tr>
		<td width="62%" heigh="22" height="24">&nbsp;&nbsp;<a href=board.jsp?fid=<%=Board_id%>><%=Board_Name%></a>&gt;&gt;
		  <%
		   if (Return_id==null)
		   out.println("发表新帖");
		   else
		   out.println("回复贴子");
		  %>
		</td>
		<td class="post" align="right" width="38%" height="24"> &nbsp;&nbsp;</td>
	  </tr></table>
	  <table cellspacing="0" cellpadding="0" border="0"  align="center" width="100%" >
		<tr>
		  <td bgcolor="#e9e9e9" width="100%">
			<table border="0" cellspacing="1" cellpadding="6" align="center" width="100%">

			<tr bgcolor="#F7FBFF">
			  <td colspan="2"><b>发表文章</b></td>
	</tr>


	<tr >

			  <td  height="35" bgcolor="#F7FBFF" nowrap>文章标题：</td>

			  <td height="35" bgcolor="#F7FBFF" align="left">
				<input type="text" name="title" size="45" value="<%=Note_Title%>" />
				  <input type="hidden" name="fid" size="12" value="<%=Board_id%>" />
				  <input type="hidden" name="returnid" size="12" value="<%=Return_id%>" />
			  </td>
	</tr>
	<%
	//匿名用户回帖
	CMySelf mySelf = (CMySelf)session.getAttribute("mySelf");

	if((CMySelf)session.getAttribute("mySelf")==null)
	{
	%>
	<tr >

			  <td  height="35" bgcolor="#F7FBFF" nowrap>署名：</td>

			  <td height="35" bgcolor="#F7FBFF">
				<input type="text" name="Guest_Sign" size="45" value=""/>
			  </td>
	</tr>
	<%
	}
	%>
	<tr>
		  <td  bgcolor="#F7FBFF">图标：</td>

		  <td  bgcolor="#F7FBFF" align="left">
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
			<input type="radio" name="icon" value="FACE16"><img src="IMAGES/FACE16.GIF" WIDTH="40" HEIGHT="17" alt="转贴">
			<br/>
			<input type="radio" name="icon" value="EXELAMATION" /><img src="IMAGES/exclamation.gif" alt="感叹" />&nbsp;
			<input type="radio" name="icon" value="QUESTION" /><img src="IMAGES/QUESTION.GIF" alt="疑问" />&nbsp;
			<input type="radio" name="icon" value="THUMBUP" /><img src="IMAGES/THUMBUP.GIF" alt="赞成" />&nbsp;
			<input type="radio" name="icon" value="THUMBDOWN" />
			<img src="IMAGES/THUMBDOWN.GIF" alt="反对" /> </td>
	</tr>

	<tr>
		  <td valign="top"  bgcolor="#F7FBFF">文章内容：</td>
		  <td  bgcolor="#F7FBFF">
			<table width="100%">
				
		<tr>
	  <td align="left">（回复字数为2000<!--，现剩余字数:
	    <input name=remLen value=2000 readonly type=text size=3 maxlength=3 style="border: 0; color: red">-->
	    ）</td>
	  <td width="43%">&nbsp;</td>
	  </tr>
	<tr><td align="left" width="100%">
				<textarea  name="content" onPropertyChange="textCounter(input.content, 2000)"><%=Note_Content%></textarea>
				<script type="text/javascript">
					  var oFCKeditor = new FCKeditor('content') ;
					  oFCKeditor.BasePath = "/system/app/infopublish/editor/" ;
					  oFCKeditor.Height = 400;
					  oFCKeditor.ToolbarSet = "Default" ;
					  oFCKeditor.ReplaceTextarea();
				  </script>
	
	</td></tr>

			</table>

		  </td>
		</tr>
		</table>
		</td></tr></table><br>
		<center><div id="subdiv" style="display:none">正在提交数据...</div>
		<input type="button" name="topicsubmit" value="发表" onclick="checkPost(input);"/>
		&nbsp; <input type="reset" name="previewpost" value="重写" />
		&nbsp; <input type="button" name="previewpost" value="返回" onclick="window.history.back();" />
		</center>
		</form>

<%
	dCn.closeCn();
}
else
{
	dCn.closeCn();
	//if(true) return;
	//response.sendRedirect("err.jsp?id=91");
}

//}
%>

<%@include file="/system/app/skin/bottom.jsp"%>

<%


} catch (Exception ex) {
	System.out.println(new java.util.Date() + "--"
			+ request.getServletPath() + " : " + ex.getMessage());
} finally {
	if(dCn != null)
	dCn.closeCn();
}

%>