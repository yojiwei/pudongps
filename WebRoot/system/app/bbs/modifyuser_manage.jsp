<%@page contentType="text/html; charset=gb2312" language="java" import="java.sql.*,java.util.*"  %>
<jsp:useBean id="yy" scope="page" class="yy.jdbc"/>



<%!String User_Name,User_Password,sql,User_Sex,User_Email,User_Address,User_Mobile,User_ur_oicq,User_Birthay,User_Class,User_Sign;%>
<%
User_Name=request.getParameter("name");

//out.println(User_Name);
User_Password=request.getParameter("password");
//User_Password=yy.ex_chinese(User_Password);
User_Sex=request.getParameter("sex");
//User_Sex=yy.ex_chinese(User_Sex);
User_Email=request.getParameter("email");
User_Address=request.getParameter("address");
//User_Address=yy.ex_chinese(User_Address);
User_Mobile=request.getParameter("mobile");
User_ur_oicq=request.getParameter("ur_oicq");
User_Birthay=request.getParameter("birthday");
//User_Birthay=yy.ex_chinese(User_Birthay);
User_Class=request.getParameter("userclass");
//User_Class=yy.ex_chinese(User_Class);
User_Sign=request.getParameter("sign");
//User_Sign=yy.ex_chinese(User_Sign);

Connection con=yy.getConn();
Statement  stmt=con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
sql="update USERINFO set ur_password='"+User_Password+"',ur_sex='"+User_Sex+"',ur_email='"+User_Email+"',ur_address='"+User_Address+"',mobilephone='"+User_Mobile+"',ur_oicq='"+User_Oicq+"',ur_birthday='"+User_Birthay+"',ur_grade='"+User_Class+"',ur_sign='"+User_Sign+"' where ur_loginname='"+User_Name+"'";
//out.println(sql);
stmt.executeUpdate(sql);
out.println("<font size=2 color=blue>正在处理您的用户信息，请稍后...</font><meta http-equiv='refresh' content='2;url=user_manager.jsp'>");
%>
<jsp:include page="inc/online.jsp" flush="true"/>
