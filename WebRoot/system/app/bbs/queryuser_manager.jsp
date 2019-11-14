<%@page contentType="text/html; charset=gb2312" language="java" import="java.sql.*"  %>
<jsp:useBean id="yy" scope="page" class="yy.jdbc"/>
<%!String Stop_Id,Delete_Id,Is_User,User_Name,sql;%>
<%
   Connection con=yy.getConn();
   Statement  stmt=con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
   Stop_Id=request.getParameter("stopid");
   Delete_Id=request.getParameter("deleteid");
   Is_User=request.getParameter("isuser");
   User_Name=request.getParameter("username");
   //User_Name=yy.ex_chinese(User_Name);
   if (Delete_Id!=null)
   {
   sql="delete from USERINFO where ur_id="+Delete_Id;
   stmt.executeUpdate(sql);
   sql="delete from forum_post where 贴子作者='"+User_Name+"'";
   stmt.executeUpdate(sql);
   out.println("<html> <meta http-equiv='refresh' content='1;url=user_manager.jsp'> </html>");

   return;
   }
   
   if ((Stop_Id!=null)&&(Is_User!=null))
   {
   if (Is_User.equals("0"))
	sql="update USERINFO set 认证身份='0' where ur_id="+Stop_Id;  
   else 
	sql="update USERINFO set 认证身份='1' where ur_id="+Stop_Id; 
   stmt.executeUpdate(sql);
    out.println("<html> <meta http-equiv='refresh' content='1;url=user_manager.jsp'> </html>");   
   }
%>
<jsp:include page="inc/online.jsp" flush="true"/>