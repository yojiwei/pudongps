<%@page contentType="text/html; charset=gb2312" language="java" import="java.sql.*,java.util.*"  %>
<jsp:useBean id="yy" scope="page" class="yy.jdbc"/>



<%!String User_Name,User_Password,User_Password1,sql,User_Sex,User_Email,User_Address,User_Mobile,User_ur_oicq,User_Birthay,User_Icon,User_Sign;%>
<%
User_Name=request.getParameter("name");
//User_Name=yy.ex_chinese(User_Name);
User_Password=request.getParameter("password");
//User_Password=yy.ex_chinese(User_Password);
User_Password1=request.getParameter("password2");
//User_Password1=yy.ex_chinese(User_Password1);
User_Sex=request.getParameter("sex");
//User_Sex=yy.ex_chinese(User_Sex);
User_Email=request.getParameter("email");
User_Address=request.getParameter("address");
//User_Address=yy.ex_chinese(User_Address);
User_Mobile=request.getParameter("mobile");
User_ur_oicq=request.getParameter("ur_oicq");
User_Birthay=request.getParameter("birthday");
//User_Birthay=yy.ex_chinese(User_Birthay);
User_Icon=request.getParameter("icon");
User_Sign=request.getParameter("sign");
//User_Sign=yy.ex_chinese(User_Sign);

if (User_Email.equals(""))
{
  response.sendRedirect("err.jsp?id=11");
  return;
}else
{

}

if (!User_Password.equals(User_Password1))
{
response.sendRedirect("err.jsp?id=9");
return;
}
if ((User_Password.length()<5)||(User_Password.length()>12))
{
response.sendRedirect("err.jsp?id=10");
return;
}


if ((User_Email.indexOf("@")<0)||(User_Email.indexOf(".")<0))
{
response.sendRedirect("err.jsp?id=13");
return;
}






Connection con=yy.getConn();
Statement  stmt=con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
sql="update USERINFO set ur_password='"+User_Password+"',ur_sex='"+User_Sex+"',ur_email='"+User_Email+"',ur_address='"+User_Address+"',mobilephone='"+User_Mobile+"',ur_ur_oicq='"+User_Oicq+"',ur_birthday='"+User_Birthay+"',ur_portrait='"+User_Icon+"',ur_sign='"+User_Sign+"' where ur_loginname='"+session.getValue("UserName")+"'";

stmt.executeUpdate(sql);
out.println("<font size=2 color=blue>正在处理您的用户信息，请稍后...</font><meta http-equiv='refresh' content='2;url=index.jsp'>");
%>
<jsp:include page="inc/online.jsp" flush="true"/>
