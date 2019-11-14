<%@page contentType="text/html; charset=gb2312" language="java" import="java.sql.*"  %>
<jsp:useBean id="yy" scope="page" class="yy.jdbc"/>

<%! String Is_Edit,Is_Delete,S_UserName,S_UserClass,Edit_Id,Delete_Id,sql,Board_Id,Note_Id,Note_Title,Note_Content,Note_Icon,Note_Sign; %>
<%
Is_Edit="0";
Is_Delete="0";

if (session.getValue("UserName")==null)
{
  response.sendRedirect("err.jsp?id=5");
}else{

   Connection con=yy.getConn();
   Statement  stmt=con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
   ResultSet rs=null;
   Board_Id=request.getParameter("fid");
   Edit_Id=request.getParameter("editid");
   Delete_Id=request.getParameter("deleteid");
   Note_Id=request.getParameter("noteid");
   Note_Title=request.getParameter("title");
   //Note_Title=yy.ex_chinese(Note_Title);
   Note_Content=request.getParameter("content");
   //Note_Content=yy.ex_chinese(Note_Content);
   Note_Icon=request.getParameter("icon");
   Note_Sign=request.getParameter("signid");
   //Note_Sign=yy.ex_chinese(Note_Sign);
   if (session.getValue("UserClass")!=null && session.getValue("UserClass").equals("系统管理员"))
   {
   Is_Edit="1";
   Is_Delete="1";
   }else if(session.getValue("UserClass")!=null &&  (session.getValue("UserClass").equals("斑竹")||session.getValue("UserClass").equals("版主")))
   {
      out.println("OK");
   sql="select fm_id from forum_board where fm_master_name='"+session.getValue("UserName")+"'";
   rs=stmt.executeQuery(sql);
   rs.last();
   if (rs.getRow()>0)
   {
     if (Board_Id.equals(rs.getString("fm_id")))
     {
       Is_Edit="1";
       Is_Delete="1";
     }
   }
   }else
   {
   sql="select * from forum_post where post_id="+Edit_Id+" and post_author='"+session.getValue("UserName")+"'";
   rs=stmt.executeQuery(sql);
   rs.last();
   if (rs.getRow()>0)
     Is_Edit="1";
   sql="select * from forum_post where post_id="+Delete_Id+" and post_author='"+session.getValue("UserName")+"'";
   rs=stmt.executeQuery(sql);
   rs.last();
   if (rs.getRow()>0)
       Is_Delete="1";
   }


if ((Is_Edit.equals("1")&&(Delete_Id==null)))
{
   
   sql="update forum_post set post_title='"+Note_Title+"', post_content='"+Note_Content+"', post_show_sign="+Note_Sign+", post_image='"+Note_Icon+"' where post_id="+Edit_Id;
   stmt.executeUpdate(sql);
   //out.println(sql);
   response.sendRedirect("shownote.jsp?fid="+Board_Id+"&noteid="+Note_Id);
}else if (Is_Delete.equals("0")&&(Edit_Id!=null))
 response.sendRedirect("err.jsp?id=6");

if ((Is_Delete.equals("1")&&(Edit_Id==null)))
{
   sql="Delete from forum_post Where post_id="+Delete_Id;
   //out.println(sql);
    stmt.executeUpdate(sql);
   //out.println("<html> <meta http-equiv='refresh' content='1;url=board.jsp?fid="+Board_Id+"'> </html>");
 	response.sendRedirect("board.jsp?fid="+Board_Id);
}
else if(Is_Edit.equals("0")&&(Delete_Id!=null))
    response.sendRedirect("err.jsp?id=7");
}

%>
