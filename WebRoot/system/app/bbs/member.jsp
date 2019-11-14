<%@page contentType="text/html; charset=gb2312" language="java" import="java.sql.*"  %>
<%
if (session.getValue("UserName")==null)
{
 response.sendRedirect("err.jsp?id=5");
 return;
}

%>
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
</script>

<title>论坛</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
</head>
<body text="#0000ff" >
<jsp:include page="inc/public.jsp" flush="true"/>
<table width="99%" cellspacing="0" cellpadding="0" align="center" height="22">
<tr>
    <td width="62%" height="22"> <a href="../default1.asp">首页</a>&gt;&gt;<a href="index.jsp">论坛</a>&gt;&gt;查看用户资料 
    </td>
    <td class="post" align="right" width="38%" height="22"> &nbsp;&nbsp;</td>
  </tr></table> 
<table cellspacing="0" cellpadding="0" border="0" width="99%" align="center">
<tr><td bgcolor="#009ACE">

      <table border="0" cellspacing="1" cellpadding="6" width="100%">
        <tr bgcolor="#9CCFFF"> 
          <td colspan="2"> 
            <p align="center">查看用户资料</p>
</td> 
</tr> 
 <jsp:useBean id="yy" scope="page" class="yy.jdbc"/>
 <%! String sql,Online_State,User_Name;%>
 <%
    
    User_Name=request.getParameter("member");
	Connection con=yy.getConn();
    Statement  stmt=con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
    ResultSet rs=null;
   	   sql="select * from forum_online where 在线ur_loginname='"+User_Name+"'";
		
		rs=stmt.executeQuery(sql);
        rs.last();
		if(rs.getRow()>0)
			Online_State="在线";
		else
			Online_State="离线";
  
  sql="Select * from USERINFO Where ur_loginname='"+User_Name+"'";
   
   
   rs=stmt.executeQuery(sql);
   rs.last();
   if (rs.getRow()>0)
   {
   String User_Level=rs.getString("ur_grade");
   String User_Email=rs.getString("ur_email");
 %>
        <tr bgcolor="#F7FBFF"> 
          <td width="42%">用户名称</td> 
          <td bgcolor="#F7FBFF" width="58%"><%=User_Name%>&nbsp;</td>
        </tr> 
 
        <tr bgcolor="#F7FBFF"> 
          <td width="42%">用户图像</td>
          <td width="58%"><img src="<%=rs.getString("ur_portrait")%>" width="32" height="32">　 
          </td>
        </tr>

        <tr bgcolor="#F7FBFF"> 
          <td width="42%">姓别</td>
          <td width="58%"><%=rs.getString("ur_sex")%>　 </td>
        </tr>

        <tr bgcolor="#F7FBFF"> 
          <td width="42%">出生日期</td>
          <td width="58%"><%=rs.getString("ur_birthday")%>　 </td>
</tr>
        <tr bgcolor="#F7FBFF"> 
          <td width="42%">居住地址</td>
          <td width="58%"><%=rs.getString("ur_address")%>　 </td>
</tr>

        <tr bgcolor="#F7FBFF"> 
          <td width="42%">注册日期</td>
          <td width="58%"><%=rs.getString("ur_sign_date").substring(0,10)%> </td>
</tr>

        <tr bgcolor="#F7FBFF"> 
          <td width="42%">ur_visit_count </td>
          <td width="58%"><%=rs.getString("ur_visit_count")%>　 </td>
        </tr>

        <tr bgcolor="#F7FBFF"> 
          <td width="42%">贴子数量 </td>
          <td width="58%"><%=rs.getString("ur_post_count")%> </td>
        </tr>

        <tr bgcolor="#F7FBFF"> 
          <td width="42%">用户等级</td>
          <td width="58%"> 
            <%
		        out.println(User_Level);
			    if (User_Level.equals("新手上路"))
					out.println("&nbsp;<IMG SRC=IMAGES/STAR.GIF>");
				else if (User_Level.equals("初级会员"))
				    out.println("&nbsp;<IMG SRC=IMAGES/STAR.GIF><IMG SRC=IMAGES/STAR.GIF>");
				else if (User_Level.equals("中级会员"))
				    out.println("&nbsp;<IMG SRC=IMAGES/STAR.GIF><IMG SRC=IMAGES/STAR.GIF><IMG SRC=IMAGES/STAR.GIF>");
				else if (User_Level.equals("高级会员"))
				    out.println("&nbsp;<IMG SRC=IMAGES/STAR.GIF><IMG SRC=IMAGES/STAR.GIF><IMG SRC=IMAGES/STAR.GIF><IMG SRC=IMAGES/STAR.GIF>");
				else if (User_Level.equals("资深会员"))
				    out.println("&nbsp;<IMG SRC=IMAGES/STAR.GIF><IMG SRC=IMAGES/STAR.GIF><IMG SRC=IMAGES/STAR.GIF><IMG SRC=IMAGES/STAR.GIF>");
				else if (User_Level.equals("版主"))
				    out.println("&nbsp;<IMG SRC=IMAGES/STAR.GIF><IMG SRC=IMAGES/STAR.GIF><IMG SRC=IMAGES/STAR.GIF><IMG SRC=IMAGES/STAR.GIF><IMG SRC=IMAGES/STAR.GIF><IMG SRC=IMAGES/STAR.GIF>");
				%>
          </td>
        </tr>

        <tr bgcolor="#F7FBFF"> 
          <td width="42%">在线情况</td>
          <td width="58%">
		<%=Online_State%>		
		</td>
        </tr>


        <tr bgcolor="#F7FBFF"> 
          <td width="42%">用户邮箱</td>
          <td width="58%"><a href="mailto:<%=User_Email%>"><%=User_Email%></a></td>
        </tr>










        <tr bgcolor="#F7FBFF"> 
          <td width="42%">OICQ</td>
          <td width="58%"><%=rs.getString("ur_oicq")%></td>
</tr>
        <tr bgcolor="#F7FBFF"> 
          <td width="42%">&gt;&gt;&nbsp;<a href="article.jsp?member=<%=User_Name%>">搜索这个用户的所有贴子</a></td>
          <td width="58%">&nbsp;</td>
</tr>
<%
   }
	else
	{
%>
        <tr bgcolor="#F7FBFF"> 
          <td width="42%">&gt;&gt;&nbsp;对不起，此用户不存在</td>
          <td width="58%">&nbsp;</td>
</tr>
<%
	}
%>
</table>
</td></tr></table>
<jsp:include page="inc/jumpboard.jsp" flush="true"/>
</body></html>

<html><script language="JavaScript"></script></html>
<jsp:include page="inc/online.jsp" flush="true"/>