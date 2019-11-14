<%@page contentType="text/html; charset=gb2312" language="java" import="java.sql.*"  %>
<html>
<head>
<META NAME="keywords" CONTENT=" 论坛  java forum jsp forum">
<META NAME="description" CONTENT=" 论坛  java forum jsp forum">
<link rel='stylesheet' type='text/css' href='inc/FORUM.CSS'>
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
<body text="#0000ff" >
<%@include file="inc/left.jsp"%>
<jsp:include page="inc/public.jsp" flush="true"/>
<table width="100%" cellspacing="0" cellpadding="0" align="center">

<tr>
    <td bgcolor="#ffffff"  width="501">&nbsp;&nbsp;<a href="index.jsp">论坛</a>&gt;&gt;文章搜索</td>
    <td bgcolor="#ffffff" class="post" align="right" width="230">　</td>
  </tr></table>

<table cellspacing="0" cellpadding="0" border="0" width="100%" align="center"> 
<form method="post" action="article.jsp"> 
<tr><td bgcolor="#e9e9e9"> 
 
      <table border="0" cellspacing="1" cellpadding="6" width="100%">
        <tr bgcolor="#e9e9e9"> 
          <td colspan="2">文章搜索</td> 
</tr> 
 
        <tr bgcolor="#F7FBFF"> 
          <td width="22%">关 键 字：</td> 
          <td> 
            <input type="text" name="key" size="30" maxlength="40" /></td> 
</tr> 
 
        <tr bgcolor="#F7FBFF"> 
          <td width="22%">搜索用户：</td> 
          <td> 
            <input type="text" name="user" size="30" maxlength="40" /></td> 
</tr> 
 
        <tr bgcolor="#F7FBFF"> 
          <td width="22%">搜索论坛：</td> 
          <td> 
            <select name="board"> 
<option value="all">所有</option>
<%
 Connection con=yy.getConn();
 Statement  stmt=con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
 ResultSet rs=null;
 String sql="select fm_id,fm_name from forum_board";
 rs=stmt.executeQuery(sql);
 while (rs.next())
 { 

  out.println("<option value="+rs.getString("fm_id")+">"+rs.getString("fm_name")+"</option>");
 }
%>

</select></td>
</tr>

        <tr bgcolor="#F7FBFF"> 
          <td width="22%">搜索时间：</td>
          <td> 
            <select name="time" size="1">
<option value="1">最近一天</option>
<option value="5">最近5天</option>
<option value="10">最近10天</option>
<option value="30">最近30天</option>
<option value="365">最近1年</option>
<option value="0" selected>所有时间</option>
</select></td>
</tr>

        <tr bgcolor="#F7FBFF"> 
          <td width="22%">搜索范围：</td>
          <td class="tablerow"> 
            <input type="radio" name="area" value="content">内容 <input type="radio" name="area" value="title">标题 <input type="radio" name="area" value="both" checked>两者都有</td>   
</tr>   
   
</table>
<center><input type="submit" name="searchsubmit" value="文章搜索" /></center>    
</td></tr><br>  

</form>   
<%@include file="inc/bottom.jsp"%>
</body>
</html>    

<html><script language="JavaScript"></script></html>