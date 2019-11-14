<%@page contentType="text/html; charset=gb2312" language="java" import="java.sql.*,java.util.*"  %>
<jsp:useBean id="yy" scope="page" class="yy.jdbc"/>



<%!String User_Name,User_Password,User_Password1,sql,User_Sex,User_Email,User_Address,User_Mobile,User_ur_oicq,User_Year,User_Month,User_Day,User_Birthday,User_Icon,User_Sign;%>
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
User_Year=request.getParameter("year");
User_Month=request.getParameter("month");
User_Day=request.getParameter("day");
User_Icon=request.getParameter("icon");
User_Sign=request.getParameter("sign");
//User_Sign=yy.ex_chinese(User_Sign);

if (User_Year.equals(""))
{
   if ((User_Month.equals(""))&&(User_Day.equals("")))
      User_Birthday="保密";
   else
	  User_Birthday=User_Month+"月"+User_Day+"日";
}else
{
  if ((User_Month.equals(""))&&(User_Day.equals("")))
     User_Birthday="保密";
  else
     User_Birthday=User_Year+"年"+User_Month+"月"+User_Day+"日";
}

//User_Birthday=yy.ex_chinese(User_Birthday);

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

if ((User_Name.indexOf("'")>0)||(User_Name.indexOf(" ")>0)||(User_Name.indexOf("@")>0)||(User_Name.indexOf("=")>0)||(User_Name.indexOf("%")>0))
{
response.sendRedirect("err.jsp?id=12");
return;
}


if ((User_Email.indexOf("@")<0)||(User_Email.indexOf(".")<0))
{
response.sendRedirect("err.jsp?id=13");
return;
}


Connection con=yy.getConn();
Statement  stmt=con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
ResultSet  rs=null;
sql="select * from USERINFO where ur_loginname='"+User_Name+"'";
rs=stmt.executeQuery(sql);
rs.last();
//out.println(sql);
if (rs.getRow()>0)
{
   response.sendRedirect("err.jsp?id=3");
}else
{
sql="insert into USERINFO(ur_loginname,ur_password,ur_sex,ur_email,ur_address,mobilephone,ur_oicq,ur_birthday,ur_portrait,ur_sign,ur_post_count,ur_visit_count,ur_grade,ur_sign_date,ur_online,认证身份)";
sql=sql+" values('"+User_Name+"','"+User_Password+"','"+User_Sex+"','"+User_Email+"','"+User_Address+"','"+User_Mobile+"','"+User_Oicq+"','"+User_Birthday+"','"+User_Icon+"','"+User_Sign+"',0,1,'新手上路','"+yy.getTime()+"','在线','1')";
//out.println(sql);
stmt.executeUpdate(sql);
session.putValue("UserName",User_Name);

session.putValue("UserLevel","新手上路");
//out.println(session.getValue("UserName"));
out.println("<font size=2 color=blue>谢谢您的注册，正在处理您的用户信息，稍后会自动登陆...</font><meta http-equiv='refresh' content='2;url=index.jsp'>");

}

%>
<jsp:include page="inc/online.jsp" flush="true"/>
