<%@page contentType="text/html; charset=gb2312" language="java" import="java.sql.*"  %>
<jsp:useBean id="yy" scope="page" class="yy.jdbc"/>
<%
if ((session.getValue("UserName")==null)||(session.getValue("UserClass")==null)||(!session.getValue("UserClass").equals("系统管理员")))
{
 response.sendRedirect("err.jsp?id=14");
 return;
}

%>
<%!String sql,Notice_Id,Delete_Id,Notice_Title,Notice_Content;%>
<%
   Delete_Id=request.getParameter("deleteid");
   Notice_Title=request.getParameter("title");
   //Notice_Title=yy.ex_chinese(Notice_Title);
   Notice_Content=request.getParameter("content");
   //Notice_Content=yy.ex_chinese(Notice_Content);
   Notice_Id=request.getParameter("noticeid");
   Connection con=yy.getConn();
   Statement  stmt=con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
   if (Delete_Id!=null)
   {
   sql="Delete from  forum_notice Where pn_id="+Delete_Id;
   stmt.executeUpdate(sql);

   out.println("<html> <meta http-equiv='refresh' content='1;url=manager.jsp'> </html>");
   return;
   }
 
   if (Notice_Id.equals("0"))
    
	 sql="insert into forum_notice(pn_id,pn_title,pn_content,pn_date) values(SEQ_FORUM_NOTICE.nextval,'"+Notice_Title+"','"+Notice_Content+"',TO_Date('"+yy.getTime()+"','YYYY-MM-DD HH24:MI:SS'))";
   else
     sql="update forum_notice set pn_title='"+Notice_Title+"',pn_content='"+Notice_Content+"' where pn_id="+Notice_Id;
   //out.println(sql);
   stmt.executeUpdate(sql);
   out.println("<html> <meta http-equiv='refresh' content='1;url=manager.jsp'> </html>");

%>
<jsp:include page="inc/online.jsp" flush="true"/>