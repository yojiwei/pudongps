<%@page contentType="text/html; charset=gb2312" language="java" import="java.sql.*,java.util.*"  %>
<jsp:useBean id="yy" scope="page" class="yy.jdbc"/>
<%!String User_Name,Pass_Word,sql;%>
<%
  String _forPage=request.getParameter("_forPage");
  User_Name=request.getParameter("username");
  //User_Name=yy.ex_chinese(User_Name);
  Pass_Word=request.getParameter("password");
  if ((User_Name.equals("")) || (Pass_Word.equals("")))
     response.sendRedirect("err.jsp?id=2");
  else
  {
    Connection con=yy.getConn();
    Statement  stmt=con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
    ResultSet  rs=null;
    sql="Select * from USERINFO Where ur_loginname='"+User_Name+"' And ur_password='"+Pass_Word+"'";
    rs=stmt.executeQuery(sql);
    rs.last();
	//out.println(sql);
    if (rs.getRow()>0)
    {
       if (rs.getString("ur_isactive").equals("0"))
		{
	   response.sendRedirect("err.jsp?id=8");
	   return;
	   }
	 
	 session.putValue("UserName",User_Name);
     	session.putValue("UserClass",rs.getString("ur_grade"));
	 session.putValue("UserRealName",rs.getString("ur_realname"));
     sql="update USERINFO set ur_visit_count=ur_visit_count+1 where ur_loginname='"+User_Name+"'";
     stmt.executeUpdate(sql);
	 if(_forPage!=null&&!_forPage.equals(""))
		 response.sendRedirect(_forPage);
	 else
		 response.sendRedirect("index.jsp");
     //out.println(session.getValue("UserClass"));
     //out.println(("<font size=2 color=blue>欢迎您的到来，正在登陆,请稍后...</font><meta http-equiv='refresh' content='2;url=index.jsp'>"));
    }else
    {
      response.sendRedirect("err.jsp?id=4");
    }



  }



%>
